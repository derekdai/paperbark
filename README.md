Paperbark is a versioned filesystem manager based on zfsonlinux.

# Installation
## Prerequisites
paperbark need zfsonlinux. In Ubuntu, you can install zfs with following
commands
```bash
$ sudo apt-add-repository ppa:zfs-native/stable
$ sudo apt-get update
$ sudo apt-get install ubuntu-zfs
```

## Download paperbark
```bash
$ git clone git@github.com:derekdai/paperbark.git
```

# Usage
Run paperbark without any argument shows help message
```bash
$ cd paperbark
$ sudo bin/pb
versioned filesystem manager

usage:
    pb COMMAND [OPTIONS]
    where COMMAND is one of the following:
               import    import filesystem from stdin
                  run    run a command in particular snapshot of filesystem
               remove    remove stagging filesystem
                 list    list stagging filesystems
             snapshot    create a snapshot of a specified filesystem
                 move    rename snapshot
        list-snapshot    list snapshots
```
