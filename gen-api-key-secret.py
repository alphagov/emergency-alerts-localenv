# Called by db-init to generate an encrypted value to put as the secret for a service API key
# This value is encrypted and signed, so needs to match the environment's ENCRYPTION_SECRET_KEY
# at runtime for they key to be useable for functional tests.

import os
from itsdangerous import URLSafeSerializer

FUNCTIONAL_TEST_LOCALENV_API_KEY_SECRET = "86aa0bd2-f343-480f-85cd-d3010866cdee"

key = os.environ["ENCRYPTION_SECRET_KEY"]
salt = os.environ["ENCRYPTION_DANGEROUS_SALT"]
serializer = URLSafeSerializer(key)

print(serializer.dumps(FUNCTIONAL_TEST_LOCALENV_API_KEY_SECRET, salt=salt))
