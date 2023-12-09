# Install Buildarr as a Python application

Buildarr is written in Python, and can be installed as a standard Python application using `pip`. In the latest release, Python 3.8 or later is required.

As Buildarr uses a plugin architecture to implement its integrations with *Arr stack applications, Buildarr is split into multiple Python packages:

* [`buildarr`](https://pypi.org/project/buildarr) (also known as Buildarr Core), the base package that implements the `buildarr` command.
* Plugin packages for managing different types of applications:
    * [`buildarr-sonarr`](https://pypi.org/project/buildarr-sonarr), the Buildarr plugin for the [Sonarr](https://sonarr.tv) PVR for TV shows.
    * [`buildarr-radarr`](https://pypi.org/project/buildarr-radarr), the Buildarr plugin for the [Radarr](https://sonarr.tv) PVR for movies.
    * [`buildarr-prowlarr`](https://pypi.org/project/buildarr-prowlarr), the Buildarr plugin for the [Prowlarr](https://prowlarr.com) indexer manager.
    * [`buildarr-jellyseerr`](https://pypi.org/project/buildarr-jellyseerr), the Buildarr plugin for the [Jellyseerr](https://github.com/Fallenbagel/jellyseerr) media request manager.

When installing Buildarr [using Docker](docker.md) or [the Windows installer](windows.md#installer), these packages are bundled together, so no additional installation is usually necessary.

Documented below are recommended methods for installing and using Buildarr as a native Python application.

## pipx

The easiest way to install and update Buildarr as a native Python application on a machine is to use [`pipx`](https://pipx.pypa.io).

First, run `pipx install` to install the Buildarr base package.

```bash
pipx install buildarr
```

Now use `pipx inject` to install individual plugins you'd like to use.

```bash
pipx inject buildarr buildarr-sonarr buildarr-radarr buildarr-prowlarr[sonarr,radarr] buildarr-jellyseerr[sonarr,radarr]
```

`pipx` will have installed Buildarr in your local user's execution environment (`~/.local/bin`). If the execution environment is in your `PATH`, the `buildarr` command will now be usable.

```bash
buildarr --help
```

To update Buildarr and any installed plugins to the latest versions, use the `pipx upgrade` command.

```bash
pipx upgrade --include-injected buildarr
```

## Virtual Environment

Buildarr can be installed to, and used from, a Python virtual environment.

This is useful for isolating Buildarr from your host system, or installing the command to a non-privileged path.

First, create the virtual environment, using either the built-in `venv` module, or the third-party `virtualenv` command.

```bash
python3 -m venv buildarr-venv
```

Activate the virtual environment to run Python commands within the virtual environment context.

Using Bash or compatible shells:

```bash
. buildarr-venv/bin/activate
```

On Windows (using Command Prompt):

```bat
buildarr-venv\bin\activate.bat
```

Install Buildarr and any required plugins using `pip`. (The below command will also update Buildarr and plugins to their latest versions, if already installed.)

```bash
python -m pip install --upgrade buildarr buildarr-sonarr buildarr-radarr buildarr-prowlarr[sonarr,radarr] buildarr-jellyseerr[sonarr,radarr]
```

Once installed, you will be able to run the `buildarr` command within the virtual environment.

```bash
buildarr --help
```
