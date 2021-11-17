# Database utils
This module provide a class called `FirestoreConnector` which have functions to manipulate data in Firestore. 

## Initialize
```
# Import the class from the `.py` file
from firestore_utils import FirestoreConnector

# path to the credential file
cred = 'path/to/serviceAccount.json'
# initialize the database
database = FirestoreConnector(credential_path = cred)
```

## List of functions:
- General funtions:
  - `add_data`
  - `update_data`
  - `get_single_data`
  - `get_listing`
- Customized functions:
  - `add_users`
  - `add_apt`
  - `add_maint`
  - `update_balance`

TBU
