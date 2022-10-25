# aw-watcher-mpv-logger
The logger part of [aw-watcher-mpv](https://github.com/RundownRhino/aw-watcher-mpv-sender), an [ActivityWatch](https://github.com/ActivityWatch/activitywatch) watcher for `mpv`. Most of the information is in the sender repo - only the installation instructions for the logger are here.
## Installation
1. Put the repository in `<mpv root>/scripts`. The path to the script should be `<mpv root>/scripts/aw-watcher-mpv-logger/main.lua`.
2. Manually create the folder to log into. By default, this is `<mpv root>/mpv-history`, but can be changed via script-opts (see [mpv docs](https://mpv.io/manual/master/#lua-scripting-on-update]]) on how to use script-opts and [main.lua](/main.lua) about what options are there).
(The script can't easily create the folder itself because there's no builtin for making directories, and calling `mkdir` would be hacky and not very crossplatform).