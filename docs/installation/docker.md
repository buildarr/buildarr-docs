# Install Buildarr as a Docker container

Buildarr is available on Docker Hub as a Docker image.

```bash
docker pull callum027/buildarr:latest
```

!!! note

    Because the Docker container is a bundle of packages consisting of Buildarr and implementing plugins, it has a separate version number from the Buildarr python packages.

    For more information, check out the [Docker Hub page](https://hub.docker.com/r/callum027/buildarr) for the Buildarr Docker container.

Once you have a configuration file, create a folder containing that file to mount into the Docker container.
As API keys and login credentials are to be stored here, this folder should have strict permissions set, with ownership exclusively
set to the `PUID` (process user ID) and `PGID` (process group ID) to be configured on the container.

```bash
mkdir --mode=700 /path/to/config
sudo chown -R <PUID>:<PGID> /path/to/config
```

You can start a Buildarr container by calling `docker run`, bind mounting the configuration directory as `/config`.

By default, the Buildarr Docker container runs in daemon mode.

```bash
docker run -d --name buildarr --restart=always --mount "source=/path/to/config,destination=/config,type=bind,readonly" -e PUID=<PUID> -e PGID=<PGID> callum027/buildarr:latest
```

For configuration testing purposes, you can call either [`buildarr run`](../usage.md#manual-runs) or [`buildarr test-config`](../usage.md#testing-configuration) using the Docker image.

```bash
docker run --rm --mount "source=/path/to/config,destination=/config,type=bind,readonly" -e PUID=<PUID> -e PGID=<PGID> callum027/buildarr:latest (run|test-config)
```

## Plugins

The official Buildarr container (`callum027/buildarr`) bundles all currently available first-party Buildarr plugins, so there is usually no need to install plugins separately.

However, if you would like to install a Buildarr plugin that is not bundled into the container, the Docker container supports installing plugins at runtime by defining the `BUILDARR_INSTALL_PACKAGES` environment variable.

`BUILDARR_INSTALL_PACKAGES` is a space-separated list of packages that gets passed directly to `pip install` on container startup, ensuring that any defined packages are ready before Buildarr starts running.

```bash
docker run -d --name buildarr --restart=always --mount "source=/path/to/config,destination=/config,type=bind,readonly" -e PUID=<PUID> -e PGID=<PGID> -e BUILDARR_INSTALL_PLUGINS="<package name>" callum027/buildarr:latest
```

If you would like to upgrade Buildarr itself or the bundled plugins within the container at the same time, set the following environment variables to the version you would like to install (only works when `BUILDARR_INSTALL_PACKAGES` is set):

* `BUILDARR_VERSION`
* `BUILDARR_SONARR_VERSION`
* `BUILDARR_RADARR_VERSION`
* `BUILDARR_PROWLARR_VERSION`
* `BUILDARR_JELLYSEERR_VERSION`

## Docker Compose

Buildarr can be integrated into a Docker Compose environment containing your *Arr stack instances.

!!! note

    Previous versions of the documentation recommended that `depends_on` be used to define service dependencies.

    This is now **not recommended**, as when `depends_on` is used and *Arr application services are recreated,
    the Buildarr service (any any other services marked as dependent) are recreated as well.

    It is now recommended to not use `depends_on` in your `docker-compose.yml` file,
    or use separate `docker-compose.yml` files for each application entirely.

Here is an example of a `docker-compose.yml` file with Buildarr managing one Sonarr instance.

```yaml
version: "3.7"

services:
  sonarr:
    image: linuxserver/sonarr:3.0.10
    restart: always
    ports:
      - 127.0.0.1:8989:8989
    volumes:
      - ./sonarr:/config
      - /path/to/downloads:/downloads
      - /path/to/videos:/videos
    environment:
      TZ: Pacific/Auckland
      PUID: "1000"
      PGID: "1000"

  buildarr:
    image: callum027/buildarr:latest
    restart: always
    volumes:
      - type: bind
        source: ./buildarr
        target: /config
        read_only: true
    environment:
      TZ: Pacific/Auckland
      PUID: "1000"
      PGID: "1000"
```

The corresponding instance configuration in `buildarr.yml` would look something like this:

```yaml
---

buildarr:
  watch_config: true
  update_days:
    - "monday"
    - "tuesday"
    - "wednesday"
    - "thursday"
    - "friday"
    - "saturday"
    - "sunday"
  update_times:
    - "03:00"

sonarr:
  # Configuration common to all Sonarr instances can be defined here.
  # settings:
  #   ...
  instances:
    # Name of the instance as referred to by Buildarr.
    # Assign instance-specific configuration to it.
    sonarr:
      host: "sonarr"
      port: 8989
      protocol: "http"
      # Define instance-specific Sonarr settings here.
      settings:
        ...
```
