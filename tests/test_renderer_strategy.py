import runpy
import unittest
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
renderer_strategy = runpy.run_path(str(PROJECT_ROOT / "scripts/caelestia-wpe"))["renderer_strategy"]
WORKSHOP = Path.home() / ".local/share/Steam/steamapps/workshop/content/431960"


class RendererStrategyTests(unittest.TestCase):
    def test_installed_preset_uses_animated_preview(self):
        directory = WORKSHOP / "3369752393"
        if not directory.exists():
            self.skipTest("Workshop fixture not installed")
        kind, path = renderer_strategy({"type": "unknown", "path": str(directory), "preview": "preview.gif"})
        self.assertEqual(kind, "preview_animation")
        self.assertEqual(path.name, "preview.gif")

    def test_video_uses_real_asset(self):
        directory = WORKSHOP / "3450329622"
        if not directory.exists():
            self.skipTest("Workshop fixture not installed")
        kind, path = renderer_strategy({"type": "video", "path": str(directory), "file": "未标题-1_1.mp4"})
        self.assertEqual(kind, "video")
        self.assertTrue(path.is_file())

    def test_scene_uses_wallpaper_engine(self):
        kind, _ = renderer_strategy({"type": "scene", "path": "/unused"})
        self.assertEqual(kind, "engine")

    def test_missing_preview_falls_back_static(self):
        kind, _ = renderer_strategy({"type": "unknown", "path": "/no/such/dir", "preview": "preview.jpg"})
        self.assertEqual(kind, "static_preview")


if __name__ == "__main__":
    unittest.main()
