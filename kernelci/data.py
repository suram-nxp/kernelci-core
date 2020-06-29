import json
import requests


def _submit_backend(name, config, data, token):
    if token is None:
        print('API token must be provided')
        return False
    resp = requests.post(config.url,
                         json=json.loads(data),
                         headers={'Authorization': token})
    print("Status: {}".format(resp.status_code))
    print(resp.text)
    return 200 <= resp.status_code <= 300


def submit(name, config, data, token=None):
    if config.db_type == "kernelci_backend":
        return _submit_backend(name, config, data, token)
    else:
        raise ValueError("db_type not supported: {}".format(config.db_type))
