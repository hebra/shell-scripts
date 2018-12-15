#!/bin/bash

PROTON_NO_ESYNC=1 \
mesa_glthread=true \
vblank_mode=0 \
STEAM_COMPAT_DATA_PATH=~/.proton python3 \
	~/.steam/steam/steamapps/common/Proton\ 3.16\ Beta/proton waitforexitandrun \
	~/.proton/pfx/drive_c/Program\ Files\ \(x86\)/Zenimax\ Online/The\ Elder\ Scrolls\ Online/game/client/eso64.exe
