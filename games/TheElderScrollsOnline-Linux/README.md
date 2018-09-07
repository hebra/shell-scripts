# Setup guide on how to install and run The Elder Scrolls Online on Linux using Steam Proton

This guide is work in progress.

Everything tested with Ubuntu 18.04 64-Bit and NVidia GTX 1080.

Note: as of writing of this guide (September 2018) both LLVM 7 and Mesa 18.2 are not available as a GA release, therefore pre-releases will be used. This guide will be updated as soon as official GA packages are available.

## Preconditions
- make sure your system matches the requirements listed on https://github.com/ValveSoftware/Proton/blob/proton_3.7/PREREQS.md
  - you probably will have to uninstall older NVidia drivers first
- an [The Elder Scrolls Online](https://www.elderscrollsonline.com) account
- the Elder Scrolls Online Windows installer (Install_ESO.exe)
- a Steam account
- an installed Steam for Linux (we need this even if you don't use the Steam version of TESO)
- enabled Steam Beta access
- at least one Windows-only game in your library
- to prevent conflicts with other/older versions of Wine you might want to uninstall PlayOnLinux and Wine prior to proceeding with this guide

### LLVM 7
As LLVM 7 is not available in the main Ubuntu repositories yet (or a PPA) we need to add an additional repository provided by the LLVM project.
- to add the signing key, run the following command as root
      wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -
- create a new file in /etc/apt/source.list.d/ called llvm7.conf and add these two lines
      deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main
      deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main
- then run
      sudo apt update && sudo apt install clang-7 lldb-7 lld-7

### Mesa 18.2
Installing Mesa 18.2 is a little more effort as there are currently no DEB packages available at all.


## Install Steam and enable Beta access
- download the official Steam DEB package and install it
      wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
      sudo dpkg -i steam_latest.deb
- start Steam and login
- go to the menu Steam -> Settings -> Account
- in the sub-section Beta participation click change and join the beta releases
- Hint: on HiRes displays you might also want to tick the checkbox 'Enlarge text and icons...' in the Interface section
- let Steam restart
- go back to Settings and open section SteamPlay
  - tick Enable SteamPlay for all titles
  - tick Use this tool instead of...
  - in the dropdown box for the Compatibility tool make sure the latest Proton 3.7 Beta (or newer) is selected

## Prepare the system
### Increase maxmimum limit of open files per process
- edit the file /etc/systemd/system.conf and uncomment the key DefaultLimitNOFILE and set a proper value
      DefaultLimitNOFILE=131072
- restart the system

## Create separate Proton data folder
Even though Proton comes as part of Steam the data folder for games doesn't need to be inside Steam.
It is actually better to keep non-Steam games in a separate folder but still use the Proton binary from Steam.

Note: to force Steam to install Proton you first need to install a non-Linux game inside Steam as well. In my case I used The Witcher 3. You need to start the game at least once to force Steam to install the matching Proton distribution for your platform.

- first create a copy of the Proton data environment in you home folder via
      cp -r ~/.local/share/Steam/SteamApps/common/Proton\ 3.7\ Beta/dist/share/default_pfx ~/.proton
- that data environment is basically just a Wine environment
- next you have two choices
  - copy an existing TESO installation from Windows (just copy the whole Zenimax Online folder) into
        ~/.proton/pfx/drive_c/
  - or start an installation of TESO from scratch
      STEAM_COMPAT_DATA_PATH=~/.proton python3 ~/.local/share/Steam/SteamApps/common/Proton\ 3.7\ Beta/proton waitforexitandrun ~/Downloads/Install_ESO.exe
- Hint: after the initial installation of libraries (e.g. DirectX) the process will fallback to command line - don't panic, after a few seconds the main launcher window should appear
- start the installation by clicking Install, and go get a coffee or raise some kids - the download will take a few hours (the current Summerset iteration of TESO is rougly 60GB in size to download)

## Start the game
Whichever way you chose (copy Windows installation or install from scratch), the final step you want to do is starting the actual game.
For the first test-run open a terminal and start via (again, the folder name and structure might be different on other systems)

    STEAM_COMPAT_DATA_PATH=~/.proton python3 ~/.local/share/Steam/SteamApps/common/Proton\ 3.7\ Beta/proton waitforexitandrun ~/.proton/pfx/drive_c/Program\ Files\ \(x86\)/Zenimax\ Online/The\ Elder\ Scrolls\ Online/game/client/eso64.exe
