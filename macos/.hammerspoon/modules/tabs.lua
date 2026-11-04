-- Ctrl+1..9 -> Cmd+1..9, but only in apps that use Cmd+number for tabs.
-- Requires Accessibility permission for Hammerspoon.

local M = {}

local apps = {
  ["com.mitchellh.ghostty"] = true,
  ["com.superlogical.rex"] = true,
  ["com.google.Chrome"] = true,
  ["org.mozilla.firefox"] = true,
  ["com.apple.Safari"] = true,
  ["com.apple.Terminal"] = true,
}

-- macOS virtual key codes for the top-row digits.
local digits = {
  [18] = "1",
  [19] = "2",
  [20] = "3",
  [21] = "4",
  [23] = "5",
  [22] = "6",
  [26] = "7",
  [28] = "8",
  [25] = "9",
}

-- Digits whose key-down we rewrote, so we can swallow the matching key-up.
local consumed = {}
local tap

local function handler(event)
  local code = event:getKeyCode()
  local isDown = event:getType() == hs.eventtap.event.types.keyDown

  if not isDown then
    if consumed[code] then
      consumed[code] = nil
      return true
    end
    return false
  end

  local digit = digits[code]
  if not digit then return false end

  local flags = event:getFlags()
  if not flags.ctrl or flags.cmd or flags.alt or flags.shift then
    return false
  end

  local app = hs.application.frontmostApplication()
  if not app or not apps[app:bundleID()] then
    return false
  end

  consumed[code] = true
  hs.eventtap.keyStroke({ "cmd" }, digit, 0)
  return true
end

function M.start()
  if tap then return end

  if not hs.accessibilityState(false) then
    print("hammerspoon: Accessibility is required for tab_numbers")
  end

  tap = hs.eventtap.new({
    hs.eventtap.event.types.keyDown,
    hs.eventtap.event.types.keyUp,
  }, handler)
  tap:start()
end

function M.stop()
  if tap then
    tap:stop()
    tap = nil
  end
  consumed = {}
end

return M
