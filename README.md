Sourcemod updater
=================

Updates or installs the latest Sourcemod stable release or snapshots.

![alt text](https://i.imgur.com/5vymVpT.png "Screenshot")

# Features

* Installs/updates stable releases or snapshots
* Custom files and plugins won't get overwritten (except you modified core files)
* Configuration will not be touched (You have to update them yourself)
* Downloaded packages will be cached and not downloaded the next time
* Can fix the permission afterwards (--fixpermissions)

# Installation

```shell
# Change to any directory where you want to install it first
aptitude install lynx wget findutils rsync
wget https://github.com/bcserv/sourcemod-updater/archive/master.zip -O sourcemod-updater.zip
unzip sourcemod-updater.zip
mv sourcemod-updater-master sourcemod-updater
cd sourcemod-updater
chmod u+x update.sh
chmod u+w packagecache
./update.sh
```

# Usage

### Syntax
```shell
./update.sh <game_dir> [<optional Package URL>] --snapshot-stable --snapshot-dev --install --dontask --fixpermissions
```

### Options

#### --snapshot-stable

Updates or installs the latest Sourcemod STABLE snapshot.

#### --snapshot-dev

Updates or installs the latest Sourcemod DEV snapshot.

#### --install

Installs sourcemod instead of updating.
CAUTION: this will overwrite any existing sourcemod files.

#### --dontask

Never ask for anything during execution.
This affects the situation when no package URL was found or
the security check before continuing the update

#### --fixpermissions

Reads the owner and the group of the game directory of the srcds after the update
and applies them recursively to the sourcemod files.
This is needed if the update is executed by root and the srcds doesn't run as root.

#### --smdir

Sets an alternative name for the addons/sourcemod directory.
If you are using srcds forks and need multiple sourcemod installations,
you have to set this.

### Examples
```shell
./update.sh /game/css/cstrike

./update.sh /srcds/css/cstrike --install --fixpermissions # Install sourcemod and fix the file permissions afterwards
./update.sh /srcds/css/cstrike --snapshot-stable          # Update sourcemod to the latest STABLE snapshot
./update.sh /srcds/css/cstrike --snapshot-dev             # Update sourcemod to the latest DEV snapshot
./update.sh /srcds/css/cstrike --dontask                  # Never ask for anything
```

# Behavior on updating

* bin          - full replace
* configs      - replaces geoip and sql-init-scripts, doesn't touch anything else
* data         - not touched
* extensions   - overwrites core files; custom files won't be touched
* gamedata     - fully replaces core.games/, sdktools.games/ and sm-*.txt files
* logs         - not touched
* plugins      - overwrites core files; custom files won't be touched; new core plugins go to disabled/
* scripting    - overwrites core files; custom files won't be touched
* translations - overwrites core files; custom files won't be touched

full replace means also deleting files that are not in the update package

# Settings

```bash
# The source code of this page will be searched for the latest sourcemod package
# We assume that the last one is the latest
SNAPSHOT_STABLE_MIRROR="http://www.sourcemod.net/smdrop/1.10/"
SNAPSHOT_STABLE_SEARCHPATTER="http:.*sourcemod-.*-linux.*gz"

SNAPSHOT_DEV_MIRROR="http://www.sourcemod.net/smdrop/1.10/"
SNAPSHOT_DEV_SEARCHPATTER="http:.*sourcemod-.*-linux.*gz"
```
