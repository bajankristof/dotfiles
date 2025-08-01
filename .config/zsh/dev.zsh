function dev {
  osascript <<EOF
tell application "Ghostty"
  activate

  tell application "System Events"
    keystroke "vv"
    keystroke return
    keystroke "t" using {command down}

    keystroke "vibe"
    keystroke return
    keystroke "t" using {command down}
  end tell
end tell
EOF
}
