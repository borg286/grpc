PROJECT = "fiery-orb-681"
CLUSTER = "k3d-k3s-default"
# One can run a local registry like https://rancher.com/docs/k3s/latest/en/installation/private-registry/
# This one follows the defaults here https://k3d.io/v5.4.6/usage/configfile/
REGISTRY = "registry.localhost:5000"

PROD = "prod"
STAGING = "staging"
DEV = "dev"
MYNS = "myns"
ENVS = [PROD, STAGING, DEV, MYNS]

"""Fetches the current username.
Relies on bazel being built with --action_env=USER
Otherwise outputs "default".
"""
def _user_impl(ctx):
    output = ctx.outputs.out
    ctx.actions.run_shell(
        outputs = [output],
        use_default_shell_env=True,
        command = 'echo "\\"${USER:-default}\\"" > \'%s\'' % (output.path)
    )

user = rule(
    implementation = _user_impl,
    attrs = {},
    outputs = {"out": "%{name}.txt"},
)
