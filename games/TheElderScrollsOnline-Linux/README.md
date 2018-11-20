# Setup guide on how to install and run The Elder Scrolls Online on Linux using Steam Proton

This guide is work in progress.

Everything tested with Ubuntu 18.10 64-Bit and NVidia GTX 1080.

## Preconditions
- make sure your system matches the requirements listed on https://github.com/ValveSoftware/Proton/blob/proton_3.7/PREREQS.md
  - you probably will have to uninstall older NVidia drivers first
- an [The Elder Scrolls Online](https://www.elderscrollsonline.com) account
- the Elder Scrolls Online Windows installer (Install_ESO.exe)
- a Steam account
- an installed Steam for Linux (we need this even if you don't use the Steam version of TESO)
- enabled Steam Beta access
- at least one Windows-only game in your library

### Vulkan, 32-bit packages and addtional Wine libraries
- as the ESO launcher itself is 32-bit only right now (not the game itself), we need some libraries in their 32-bit flavour to be installed as well
	apt install mesa-vulkan-drivers libfreetype6:i386 wine wine64

### LLVM 7
As LLVM 7 is not available in the main Ubuntu repositories yet (or a PPA) we need to add an additional repository provided by the LLVM project.
- to add the signing key, run the following command as root
      wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -
- create a new file in /etc/apt/source.list.d/ called llvm7.conf and add these two lines
      deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main
      deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main
- then run
      sudo apt update && sudo apt install clang-7 lldb-7 lld-7

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

### Install a Steam Windows game
In order for Steam to install Proton you will first need to install a Windows-only game inside Steam. 
In my case I used The Witcher 3. You need to start the game at least once so Steam will install the matching Proton distribution for your platform.

## Create separate Proton data folder
Even though Proton comes as part of Steam the data folder for games doesn't need to be inside Steam.
It is actually better to keep non-Steam games in a separate folder but still use the Proton binary from Steam.

- first create a copy of the Proton data environment in you home folder via
      cp -r ~/.local/share/Steam/SteamApps/common/Proton\ 3.7\ Beta/dist/share/default_pfx ~/.proton
- that data environment is basically just a Wine environment
- next you have two choices
  - copy an existing TESO installation from Windows (just copy the whole Zenimax Online folder) into
        ~/.proton/pfx/drive_c/
  - or start an installation of TESO from scratch
	PROTON_NO_ESYNC=1 mesa_glthread=true vblank_mode=0 STEAM_COMPAT_DATA_PATH=~/.proton python3 ~/.steam/steam/steamapps/common/Proton\ 3.7\ Beta/proton waitforexitandrun ~/Downloads/Install_ESO.exe
- Hint: after the initial installation of libraries (e.g. DirectX) the process will fallback to command line - don't panic, after a few seconds the main launcher window should appear
- start the installation by clicking Install, and go get a coffee or raise some kids - the download will take a few hours (the current Summerset iteration of TESO is rougly 60GB in size to download)

## Start the game
Whichever way you chose (copy Windows installation or install from scratch), the final step you want to do is starting the actual game.
For the first test-run open a terminal and start via (again, the folder name and structure might be different on other systems)

```
PROTON_NO_ESYNC=1 \
PROTON_USE_WINED3D11=1 \
mesa_glthread=true \
vblank_mode=0 \
STEAM_COMPAT_DATA_PATH=~/.proton python3 \
        ~/.steam/steam/steamapps/common/Proton\ 3.7\ Beta/proton waitforexitandrun \
        ~/.proton/pfx/drive_c/Program\ Files\ \(x86\)/Zenimax\ Online/The\ Elder\ Scrolls\ Online/game/client/eso64.exe
```

## Addons
Like most players I'd like to have a few improvements in the game like a minimap or a clock. For this, one can use an addon manager like Minion.
Existing addons from a Windows installations are stored outside of the actual game directory in a separate folder

      C:/Users/NAME/Documents/Elder Scrolls Online/live/AddOns

To make these addons available on the Linux installation, first create a backup of the following folder and then copy the whole AddOns and SavedVariables folders to

      ~/.proton/pfx/drive_c/users/steamuser/My Documents/Elder Scrolls Online/ESO_BUILD_BRANCH

Hint: you probably also want to copy other files and folder over from the Windows folder.

### Additional tweaks

#### Skip intro logos

Edit file `.proton/pfx/drive_c/users/steamuser/My\ Documents/Elder\ Scrolls\ Online/ESO_BUILD_BRANCH/UserSettings.txt` and change `SET SkipPregameVideos` from 0 to 1

### Set up Minion addon manager
It seems like Minion isn't working with OpenJDK 11 and openJFX, therefore we need to fallback to Oracle's Java 8.

- first add the Webupd8 PPA for Oracle Java
```
sudo add-apt-repository ppa:webupd8team/java
```
- then install Oracle Java 8
```
sudo apt install oracle-java8-installer 
```
- next download the Minion Java installer from https://minion.mmoui.com/
- create a new folder ~/.minion
- move the dpwnloaded zip file to ~/.minion/
- and unzip the file
- create the folder for the addons if it doesn't already exist
``` 
    mkdir -p ~/.proton/pfx/drive_c/users/steamuser/My Documents/Elder Scrolls Online/ESO_BUILD_BRANCH/AddOns
```
- start via
```
    java -jar ~/.minion/Minion-jfx.jar
```
- reject the offer to update to the latest version (this will crash the Minion)
- agree to the EULA
- deselect the games from the list and Continue
- deselect to scan 
- open the Settings (top right corner) and set the Game Scan Depth to 20
- close and restart Minion
- this time scan for Elder Scrolls Online (and tick Remember my decision)
- tick the root path and also tick Remember my decision in the next screen
- scan for games, when offered to select the addon folder for TESO show hidden files (Ctrl+H) and browse to the previously created AddOns folder
- you now need to restart Minion to actually show the list of AddOns
