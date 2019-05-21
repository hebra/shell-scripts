#!/bin/bash

PROTON_NO_ESYNC=1 \
mesa_glthread=true \
vblank_mode=0 \
STEAM_COMPAT_DATA_PATH=~/.proton python3 \
	~/.steam/steam/steamapps/common/Proton\ 4.2/proton waitforexitandrun \
	~/.proton/pfx/drive_c/Program\ Files\ \(x86\)/Zenimax\ Online/The\ Elder\ Scrolls\ Online/game/client/eso64.exe
