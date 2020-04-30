#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2018, Jamie McDonald <jamie@qwyck.net>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from ansible.module_utils.basic import AnsibleModule
from github import Github

ANSIBLE_METADATA = {'metadata_version': '1.1',
                    'status': ['preview'],
                    'supported_by': 'community'}

DOCUMENTATION = '''
---
module: github_deploy_key
author: "Jamie McDonald (https://www.qwyck.co.uk)"
short_description: Manages deploy keys for GitHub repositories.
description:
  - "Adds, replaces, or removes deploy keys for GitHub repositories. Supports authentication using a valid GitHub 
  access token. Admin rights on the repository are required."
requirements:
  - "PyGithub"
options:
  repo:
    description:
      - The name of the GitHub repository e.g username/hello-world
    required: true
  title:
    description:
      - The title for the deploy key.
    required: true
  key:
    description:
      - The SSH public key to add to the repository as a deploy key.
    required: true
  read_only:
    description:
      - If C(true), the deploy key will be only be able to read. Otherwise, the deploy key will 
      be only be able to read and write repository contents.
    type: bool
    default: 'no'
  state:
    description:
      - The state of the deploy key.
    default: "present"
    choices: [ "present", "absent" ]
  replace:
    description:
      - If C(true), the id already exists, and the key value is different, then relace the key.
    type: bool
    default: 'no'
  token:
    description:
      - The OAuth2 token or personal access token to authenticate with. 
    required: true
notes:
   - "Refer to GitHub's API documentation here: https://developer.github.com/v3/repos/keys/."
'''

EXAMPLES = '''

'''

RETURN = '''
msg:
    description: the status message describing what occurred
    returned: always
    type: str
    sample: "Deploy key created"

error:
    description: the error message returned by the GitHub API
    returned: failed
    type: str
    sample: "key is already in use"
'''


class DeployKeyManager(object):
    KEY_EXISTS = dict(changed=False, msg='Deploy key already exists')
    KEY_DOESNT_EXIST = dict(changed=False, msg='Deploy key does not exist')
    KEY_CREATED = dict(changed=True, msg='Deploy key created')
    KEY_REPLACED = dict(changed=True, msg='Deploy key replaced')
    KEY_DELETED = dict(changed=True, msg='Deploy key deleted')

    def __init__(self, module):
        self.module = module

        self.github = Github(self.module.params.get('token'))

        self.repo = self.module.params['repo']
        self.title = self.module.params['title']
        self.key = self.module.params['key']
        self.read_only = self.module.params.get('read_only', False)
        self.force = self.module.params.get('replace', False)

        self.existing_key = self.get_existing_key()

    def get_repo(self):
        return self.github.get_repo(self.repo)

    def get_existing_key(self):
        return next((k for k in self.get_repo().get_keys() if k.title == self.title), None)

    def exists(self):
        return self.existing_key is not None

    def matches(self):
        return self.existing_key.key in self.key

    def create_or_replace(self):
        if self.exists():
            if self.force:
                return self.replace_key()
            else:
                return self.KEY_EXISTS
        else:
            return self.create_key()

    def create_key(self):
        if not self.module.check_mode:
            self.get_repo().create_key(self.title, self.key, self.read_only)
        return self.KEY_CREATED

    def replace_key(self):
        if not self.matches():
            if not self.module.check_mode:
                self.existing_key.delete()
                self.get_repo().create_key(self.title, self.key, self.read_only)
            return self.KEY_REPLACED
        else:
            return self.KEY_EXISTS

    def remove_key(self):
        if self.exists():
            if not self.module.check_mode:
                self.existing_key.delete()
            return self.KEY_DELETED
        else:
            return self.KEY_DOESNT_EXIST


def main():
    module_args = dict(
        repo=dict(required=True, type='str'),
        title=dict(required=True, type='str'),
        key=dict(required=True, type='str'),
        read_only=dict(required=False, type='bool', default=True),
        state=dict(default='present', choices=['present', 'absent']),
        replace=dict(required=False, type='bool', default=False),
        token=dict(required=False, type='str', no_log=True)
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    state = module.params.get('state')

    result = dict(changed=False)

    try:
        manager = DeployKeyManager(module)

        if state == 'present':
            result = manager.create_or_replace()

        elif state == 'absent':
            result = manager.remove_key()

        else:
            module.fail_json(msg='Unrecognized state %s.' % state)
    except Exception as exc:
        module.fail_json(msg='Failure: %s' % str(exc))

    module.exit_json(**result)


if __name__ == '__main__':
    main()
