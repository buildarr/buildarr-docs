# Plugins

Buildarr utilises a plugin architecture to allow for modular installation of support for different types of *Arr stack applications.

Successfully installed plugins will be loaded when Buildarr is run (listed under `Loaded plugins: PLUGIN[, PLUGIN...]`), with the plugin's version also being logged.

Plugins that are actually being used by the loaded configuration file are output as `Running with plugins: PLUGIN-NAME[, PLUGIN-NAME...]`.

```text
2023-11-12 10:00:29,220 buildarr:1 buildarr.cli.daemon [INFO] Buildarr version 0.7.0 (log level: INFO)
2023-11-12 10:00:29,220 buildarr:1 buildarr.cli.daemon [INFO] Loading configuration file '/config/buildarr.yml'
2023-11-12 10:00:29,775 buildarr:1 buildarr.cli.daemon [INFO] Finished loading configuration file
2023-11-12 10:00:29,775 buildarr:1 buildarr.cli.daemon [INFO] Daemon configuration:
2023-11-12 10:00:29,776 buildarr:1 buildarr.cli.daemon [INFO]  - Watch configuration files: No
2023-11-12 10:00:29,776 buildarr:1 buildarr.cli.daemon [INFO]  - Update at:
2023-11-12 10:00:29,776 buildarr:1 buildarr.cli.daemon [INFO]    - Monday 03:00
2023-11-12 10:00:29,776 buildarr:1 buildarr.cli.daemon [INFO]    - Tuesday 03:00
2023-11-12 10:00:29,777 buildarr:1 buildarr.cli.daemon [INFO]    - Wednesday 03:00
2023-11-12 10:00:29,777 buildarr:1 buildarr.cli.daemon [INFO]    - Thursday 03:00
2023-11-12 10:00:29,778 buildarr:1 buildarr.cli.daemon [INFO]    - Friday 03:00
2023-11-12 10:00:29,778 buildarr:1 buildarr.cli.daemon [INFO]    - Saturday 03:00
2023-11-12 10:00:29,778 buildarr:1 buildarr.cli.daemon [INFO]    - Sunday 03:00
2023-11-12 10:00:29,778 buildarr:1 buildarr.cli.daemon [INFO] Scheduling update jobs
2023-11-12 10:00:29,779 buildarr:1 buildarr.cli.daemon [INFO] Finished scheduling update jobs
2023-11-12 10:00:29,779 buildarr:1 buildarr.cli.daemon [INFO] Config file monitoring is already disabled
2023-11-12 10:00:29,779 buildarr:1 buildarr.cli.daemon [INFO] Applying initial configuration
2023-11-12 10:00:29,932 buildarr:1 buildarr.cli.run [INFO] Loaded plugins: jellyseerr (0.3.0), prowlarr (0.5.0), radarr (0.2.0), sonarr (0.6.0)
2023-11-12 10:00:29,932 buildarr:1 buildarr.cli.run [INFO] Loading instance configurations
2023-11-12 10:00:29,973 buildarr:1 buildarr.cli.run [INFO] Finished loading instance configurations
2023-11-12 10:00:29,973 buildarr:1 buildarr.cli.run [INFO] Running with plugins: sonarr
...
```

Buildarr plugins are installed as Python packages, just like Buildarr itself.

## Supported plugins

At the time of this release the following plugins are available:

* [`buildarr-sonarr`](sonarr/index.md) - [Sonarr](https://sonarr.tv) PVR for TV shows
* [`buildarr-radarr`](radarr/index.md) - [Radarr](https://radarr.video) PVR for movies
* [`buildarr-prowlarr`](prowlarr/index.md) - [Prowlarr](https://prowlarr.com) indexer manager for Arr applications
* [`buildarr-jellyseerr`](jellyseerr/index.md) - [Jellyseerr](https://github.com/Fallenbagel/jellyseerr) media request manager for Jellyfin, Sonarr and Radarr

## Installation

When running Buildarr [as a Python application](../installation/python.md), simply install the plugin's Python package alongside Buildarr in your respective environment.

For other installation methods, refer to the following pages:

* [Docker Container](../installation/docker.md#plugins)
* [Buildarr Installer for Windows](../installation/windows.md#plugins)
