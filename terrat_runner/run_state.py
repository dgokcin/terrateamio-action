import collections
import os


State = collections.namedtuple('State', ['work_token',
                                         'repo_config',
                                         'working_dir',
                                         'work_manifest',
                                         'api_base_url',
                                         'workspace',
                                         'path',
                                         'env',
                                         'output',
                                         'failed'])


def create(work_token, repo_config, working_dir, api_base_url, work_manifest):
    return State(work_token=work_token,
                 repo_config=repo_config,
                 working_dir=working_dir,
                 work_manifest=work_manifest,
                 api_base_url=api_base_url,
                 path=None,
                 workspace=None,
                 env=os.environ.copy(),
                 output={},
                 failed=False)
