#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.local/bin" "$HOME/.config/caelestia"
for spec in "scripts/caelestia-wpe:$HOME/.local/bin/caelestia-wpe" "scripts/wallpaper-changed.sh:$HOME/.config/caelestia/wallpaper-changed.sh"; do
  src="$ROOT/${spec%%:*}"; dst="${spec#*:}"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    cp -a "$dst" "$dst.pre-wallpaper-engine-plugin"
    rm -f "$dst"
  fi
  ln -sfn "$src" "$dst"
done
chmod +x "$ROOT/scripts/"*
python3 - "$HOME/.config/caelestia/cli.json" <<'PY'
import json,sys
from pathlib import Path
p=Path(sys.argv[1]); d={}
try: d=json.loads(p.read_text())
except Exception: pass
d.setdefault('wallpaper',{})['postHook']=str(Path.home()/'.config/caelestia/wallpaper-changed.sh')
p.write_text(json.dumps(d,indent=4)+"\n")
PY
"$HOME/.local/bin/caelestia-wpe" sync || true
printf 'Wallpaper Engine integration installed.\n'
