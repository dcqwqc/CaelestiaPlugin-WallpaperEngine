# CaelestiaPlugin-WallpaperEngine

Wallpaper Engine integration for Caelestia using `linux-wallpaperengine` for scene/web items and `mpvpaper` for ordinary video wallpapers.

- Wallpaper Engine previews are synced into Caelestia.
- The Nexus page supports per-screen assignment.
- `>wallpaper` in the Caelestia launcher applies a selected Wallpaper Engine item to **all active screens** instead of opening a detached screen-picker that could silently fail.
- Switching back to a static wallpaper tears down the live layer cleanly.
- Wallpaper colour regeneration and live-wallpaper lifecycle are kept separate from the Color plugin.

Run `./install.sh` once after cloning/installing the plugin to wire the helper and wallpaper post-hook into the current user profile.
