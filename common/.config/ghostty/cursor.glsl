// Ghostty cursor trail shader.
//
// Renders a short trail between the previous and current cursor positions.
// Straight moves (purely horizontal/vertical) use a rectangle SDF; diagonal
// moves use a parallelogram SDF. The trail shrinks back into the cursor
// over DURATION seconds using a cubic ease-out.

// ============================================================================
// Configuration
// ============================================================================

const float DURATION     = 0.15; // trail lifetime in seconds
const float TRAIL_LENGTH = 0.3; // 0..1, fraction of the move distance the trail spans at its peak
const float BLUR         = 2.0; // antialiasing edge width in pixels

// ============================================================================
// Color space
// ============================================================================

// Ghostty supplies sRGB colors but the shader pipeline composites in linear
// space, so we convert the cursor color once per fragment (uniform input,
// so the driver should hoist this out of the loop).
vec3 sRGBToLinear(vec3 c) {
    return mix(c / 12.92, pow((c + 0.055) / 1.055, vec3(2.4)), step(vec3(0.04045), c));
}

// ============================================================================
// Coordinate helpers
// ============================================================================

// Map pixel-space values into the shader's normalized [-1, 1] coordinates.
// `isPosition` is 1.0 for points (subtracts the resolution to recenter) and
// 0.0 for sizes/offsets (pure scale).
vec2 toNormalized(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

// ============================================================================
// Signed distance functions
// ============================================================================

float sdRectangle(vec2 point, vec2 center, vec2 halfSize) {
    vec2 d = abs(point - center) - halfSize;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Branchless segment distance accumulator for sdParallelogram.
// Based on Inigo Quilez's 2D distance functions: https://iquilezles.org/articles/distfunctions2d/
// Updates `s` (winding sign) and returns the new minimum squared distance.
float accumulateSegment(vec2 p, vec2 a, vec2 b, inout float s, float minDistSq) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float distSq = dot(p - proj, p - proj);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allInside  = c0 * c1 * c2;
    float allOutside = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    s *= mix(1.0, -1.0, step(0.5, allInside + allOutside));

    return min(minDistSq, distSq);
}

float sdParallelogram(vec2 p, vec2 v0, vec2 v1, vec2 v2, vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);
    d = accumulateSegment(p, v0, v3, s, d);
    d = accumulateSegment(p, v1, v0, s, d);
    d = accumulateSegment(p, v2, v1, s, d);
    d = accumulateSegment(p, v3, v2, s, d);
    return s * sqrt(d);
}

// ============================================================================
// Misc helpers
// ============================================================================

// Cubic ease-out: 1 - (1 - x)^3
float easeOutCubic(float x) {
    return 1.0 - pow(1.0 - x, 3.0);
}

// Selects which corner of the cursor rect is the "top" vertex of the
// parallelogram trail, based on the direction of motion.
float getTopVertexFlag(vec2 a, vec2 b) {
    float c1 = step(b.x, a.x) * step(a.y, b.y); // a.x < b.x && a.y > b.y (note: y is flipped)
    float c2 = step(a.x, b.x) * step(b.y, a.y); // a.x > b.x && a.y < b.y
    return 1.0 - max(c1, c2);
}

// ============================================================================
// Main
// ============================================================================

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    // Normalize all inputs into [-1, 1] space.
    vec2 uv             = toNormalized(fragCoord, 1.0);
    vec4 currentCursor  = vec4(toNormalized(iCurrentCursor.xy,  1.0), toNormalized(iCurrentCursor.zw,  0.0));
    vec4 previousCursor = vec4(toNormalized(iPreviousCursor.xy, 1.0), toNormalized(iPreviousCursor.zw, 0.0));

    // Cursor rects are anchored at their top-left in input space; convert
    // to centers (top-left + (w/2, -h/2)).
    const vec2 offsetFactor = vec2(-0.5, 0.5);
    vec2 currentCenter  = currentCursor.xy  - currentCursor.zw  * offsetFactor;
    vec2 previousCenter = previousCursor.xy - previousCursor.zw * offsetFactor;

    float lineLength = distance(currentCenter, previousCenter);
    float minDist    = currentCursor.w * 1.5;
    float progress   = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);

    // Only render the trail while the animation is in progress. Without
    // this, the branch keeps running on every frame after a move (since
    // lineLength is purely positional, not time-based) and re-draws a
    // cursor-rect-sized "trail" forever. On blink-off frames iChannel0
    // has no cursor to punch back in, leaving the antialiased outline
    // visible as a hollow rectangle until the next cursor move.
    if (lineLength <= minDist || progress >= 1.0) {
        return;
    }

    float shrinkFactor = easeOutCubic(progress);

    // Detect straight (purely horizontal or vertical) moves. These get
    // a cheaper rectangle SDF; everything else uses the parallelogram.
    vec2 delta = abs(currentCenter - previousCenter);
    const float STRAIGHT_THRESHOLD = 0.001;
    bool isStraightMove = (delta.x <= STRAIGHT_THRESHOLD) || (delta.y <= STRAIGHT_THRESHOLD);

    float sdfTrail;
    if (isStraightMove) {
        // Rectangle SDF: bounding box of the two cursor rects, shrinking
        // back into the current cursor as `progress` advances.
        vec2 minCenter = min(previousCenter, currentCenter);
        vec2 maxCenter = max(previousCenter, currentCenter);

        vec2 bboxSizeFull   = (maxCenter - minCenter) + currentCursor.zw;
        vec2 bboxCenterFull = (minCenter + maxCenter) * 0.5;

        vec2 bboxSizeStart   = mix(currentCursor.zw, bboxSizeFull,   TRAIL_LENGTH);
        vec2 bboxCenterStart = mix(currentCenter,    bboxCenterFull, TRAIL_LENGTH);

        vec2 animSize   = mix(bboxSizeStart,   currentCursor.zw, shrinkFactor);
        vec2 animCenter = mix(bboxCenterStart, currentCenter,    shrinkFactor);

        sdfTrail = sdRectangle(uv, animCenter, animSize * 0.5);
    } else {
        // Parallelogram SDF: trailing edge shrinks from the previous
        // cursor's far corners back into the current cursor's near corners.
        float topFlag    = getTopVertexFlag(currentCursor.xy, previousCursor.xy);
        float bottomFlag = 1.0 - topFlag;

        vec2 v0 = vec2(currentCursor.x  + currentCursor.z * topFlag,    currentCursor.y - currentCursor.w);
        vec2 v1 = vec2(currentCursor.x  + currentCursor.z * bottomFlag, currentCursor.y);
        vec2 v2Full = vec2(previousCursor.x + currentCursor.z * bottomFlag, previousCursor.y);
        vec2 v3Full = vec2(previousCursor.x + currentCursor.z * topFlag,    previousCursor.y - previousCursor.w);

        vec2 v2Start = mix(v1, v2Full, TRAIL_LENGTH);
        vec2 v3Start = mix(v0, v3Full, TRAIL_LENGTH);
        vec2 v2Anim  = mix(v2Start, v1, shrinkFactor);
        vec2 v3Anim  = mix(v3Start, v0, shrinkFactor);

        sdfTrail = sdParallelogram(uv, v0, v1, v2Anim, v3Anim);
    }

    // Antialiased trail edge. The blur width in normalized coords is
    // uniform across the frame, so hoisting it out of any SDF helper.
    float edgeWidth  = (BLUR * 2.0) / iResolution.y;
    float trailAlpha = 1.0 - smoothstep(0.0, edgeWidth, sdfTrail);

    vec4 trailColor = vec4(sRGBToLinear(iCurrentCursorColor.rgb), iCurrentCursorColor.a);
    vec4 outColor   = mix(fragColor, trailColor, trailAlpha);

    // Punch out the current cursor rect so the underlying cursor glyph
    // (drawn by Ghostty into iChannel0) stays crisp on top of the trail.
    float sdfCurrentCursor = sdRectangle(uv, currentCenter, currentCursor.zw * 0.5);
    outColor = mix(outColor, fragColor, step(sdfCurrentCursor, 0.0));

    fragColor = outColor;
}
