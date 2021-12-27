# Automatically builds docker images and pushes them to the registry.
# Required drone secrets:
#   - docker_repo       eg. 'xeniaproject/buildenv'
#   - docker_username   user with write permissions to repo
#   - docker_password   password of the user

def main(ctx):
    return [
        pipeline('2021-05-05'),
        pipeline('2021-06-21'),
        pipeline('2022-01-01'),
    ]

def pipeline(tag):
    return {
        'kind': 'pipeline',
        'type': 'docker',
        'name': tag,
        'steps': [
            {
                'name': 'docker',
                'image': 'plugins/docker',
                'settings': {
                  'dockerfile': 'Dockerfile.' + tag,
                  'tags': [tag],
                  'repo': {'from_secret': 'docker_repo'},
                  'username': {'from_secret': 'docker_username'},
                  'password': {'from_secret': 'docker_password'},
                },
            },
        ],
        'trigger': {
            'branch': ['master'],
            'event': ['push']
        },
    }
