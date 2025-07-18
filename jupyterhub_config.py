import os, nativeauthenticator
c.JupyterHub.template_paths = [f"{os.path.dirname(nativeauthenticator.__file__)}/templates/"]

def pre_spawn_hook(spawner):
    username = spawner.user.name
    user_dir = f"/srv/jupyterhub/work/{username}"
    os.makedirs(user_dir, exist_ok=True)
    spawner.notebook_dir = user_dir

c.Spawner.pre_spawn_hook = pre_spawn_hook
c.JupyterHub.authenticator_class = 'native'
c.Spawner.default_url = '/lab'
c.NativeAuthenticator.auto_approve = False
c.Authenticator.admin_users = {'admin'}
c.Authenticator.allow_all = True
c.JupyterHub.spawner_class = 'simple'
c.Spawner.args = ['--allow-root']