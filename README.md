# config

## Overview

This repo contains all the configuration files I need to setup a new machine.

## Windows

To setup windows, open `Poweshell` **as administrator** and run the following command inside the root of the repo:

```sh
powershell -ExecutionPolicy Bypass -File .\windows\main.ps1
```

Then reboot the computer and all the changes should apply.

## TODO
- Add a secondary keyboard (FR)
- Create a `config.json` to store personnal data that should be manually added