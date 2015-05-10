# AthensLister
This is a utility we use to help us whitelist members on the servers easily. 

## Usage
To use the script run it by doing the following

```bash
./AthensLister.rb username
```

Replace username with the Minecraft username of the user you wish to be whitelisted on the servers. 

## Adding servers
For the moment adding servers is a manual thing, but this should be extracted out and made easier in some later versions. For now we'll have to edit the script to add the screen session name. 

## Current issues:
We'll need to figure out how to whitelist across SSH sessions, for example if one server is running on a box on one user, but on the same box two other servers are ran on a seperate user we need to determine how to handle that. 