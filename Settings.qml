import Caelestia.Plugins

SettingsObject {
    property int fps: 60
    SettingMeta on fps {
        label: "Refresh rate"
        description: "Frames per second for Wallpaper Engine renders."
        icon: "60fps"
        inputType: SettingMeta.SpinBox
        min: 15
        max: 144
    }

    property string scaling: "fill"
    SettingMeta on scaling {
        label: "Scaling mode"
        description: "How to fit the wallpaper onto the display."
        icon: "aspect_ratio"
        inputType: SettingMeta.SplitButton
        options: ["fill", "fit", "stretch", "center"]
    }

    property bool pauseOnWindows: true
    SettingMeta on pauseOnWindows {
        label: "Pause when windows are active"
        description: "Freezes the wallpaper animation when any window is open to save CPU/GPU resources."
        icon: "pause_circle"
        inputType: SettingMeta.Switch
    }
}
