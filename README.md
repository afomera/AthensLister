# AthensLister
This is a utility we use to help us whitelist members on the servers easily. 

## Usage
To use the script run it by doing the following

```bash
./AthensLister.rb username
```

Replace username with the Minecraft username of the user you wish to be whitelisted on the servers. 

## Adding servers
For the moment adding servers is a manual thing, but this should be extracted out and made easier in some later versions. For now we'll have to edit the script to add the screen session name followed by @ and the server IP address or domain which points to the IP.

## Current issues:
- Adding servers is a manual process and is not user friendly.
- This script does not support removing members from the whitelist
- Needs installation / deployment instructions written