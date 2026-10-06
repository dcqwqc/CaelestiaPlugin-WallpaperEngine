#!/usr/bin/env bash
set -u

wpe="$HOME/.local/bin/caelestia-wpe"
path="${WALLPAPER_PATH:-}"

# Files in Pictures/Wallpapers/WallpaperEngine are static previews whose final
# _<WorkshopID> suffix identifies the live item. Launcher selection has no
# per-monitor UI, so it applies that live item to all active outputs. The Nexus
# Wallpaper Engine page still provides explicit per-screen assignment.
if [[ "$path" == *"/steamapps/workshop/content/431960/"* ]] || [[ "$path" == *"/WallpaperEngine/"* ]]; then
    id=""
    if [[ "$path" == *"/steamapps/workshop/content/431960/"* ]]; then
        rest="${path#*'/steamapps/workshop/content/431960/'}"
        id="${rest%%/*}"
    else
        id="$(basename "$path" | sed -nE 's/.*_([0-9]+)\.[A-Za-z0-9]+$/\1/p')"
    fi

    if [[ -n "$id" && -x "$wpe" ]] && "$wpe" has "$id"; then
        if [[ "${WPE_TRIGGERED_BY_CAELESTIA:-0}" != "1" ]]; then
            export WPE_TRIGGERED_BY_CAELESTIA=1
            "$wpe" set all "$id"
        fi
    elif [[ -x "$wpe" ]]; then
        # A copied preview with no installed Workshop payload is just a normal
        # static image, so make sure a previous live layer does not cover it.
        "$wpe" stop
    fi
elif [[ -x "$wpe" ]]; then
    "$wpe" stop
fi

# Color is an independent plugin. If installed, let it restore the chosen
# palette after Caelestia generated a wallpaper-derived scheme.
if [[ -x "$HOME/.config/caelestia/apply_color_overrides.py" ]]; then
    "$HOME/.config/caelestia/apply_color_overrides.py"
fi
