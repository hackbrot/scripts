# Backup Scripts ☁️

These scripts involve around backups. I've used these scripts for my OpenMediaVault installation on my BYO-NAS but also for auto-backups from my root server to my NAS. These scripts therefore only have been used on linux systems so far.

> **Note:** [SnapRAID](https://www.snapraid.it/) is required for the **nasbackup** script

## How to use

if you put the script in f.e `/usr/local/bin`, as `nasbackup` (no extension) then it is as easy to run `nasbackup` in your bash terminal. Alternatively just run it with `bash nasbackup.sh` It doesn't accept any arguments for now.

## Changeable Variables

- `log_path` determines in which directory the script should put logs in.

- `config_file` is highly dependant on your setup. In case snapraid has issues getting the config file, this variable can be used to specify a config file path. leave empty to specify no config path

- `has_docker` can be changed to either `true` or `false`. If you have running docker containers on your system, putting this to true will stop them while the the script is executed. After that, they will be started up again.

## TODO

- Add script for backing up stuff from Server to NAS
