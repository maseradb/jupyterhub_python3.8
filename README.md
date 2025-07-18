# JupyterHub

## This repository deploys a docker-based JupyterHub with NativeAuthenticator. This avoids the necessicity of an OS-level authentication, an easier way to setup a team development and finding environment.


mkdir users
mkdir jupyterhub_data

# Run docker compose

docker compose up -d --build
