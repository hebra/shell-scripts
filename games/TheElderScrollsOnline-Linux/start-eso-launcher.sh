#!/bin/bash

STEAM_COMPAT_DATA_PATH=~/.proton python3 \
PROTON_USE_WINED3D11=1 \
	~/.steam/steam/steamapps/common/Proton\ 3.7\ Beta/proton waitforexitandrun \
	~/.proton/pfx/drive_c/Program\ Files\ \(x86\)/Zenimax\ Online/Launcher/Bethesda.net_Launcher.exe

