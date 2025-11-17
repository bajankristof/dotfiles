import app from "ags/gtk4/app";
import style from "./style.scss";
import StatusBar from "./windows/StatusBar";

// Active state accounting in GNOME apps sometimes emits warnings,
// but they can be ignored for now.
// https://discourse.gnome.org/t/what-does-broken-accounting-of-active-state/24474

app.start({
  // css: style,
  css: "* { font-family: \"JetBrains Mono Nerd Font Propo\", monospace; }",
  main() {
    app.get_monitors().map(StatusBar);
  },
});
