import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

class FirestoreConnector:
    ##################### GENERAL FUNCTIONS ###########################
    
    
    # TODO: add credential path
    def __init__(self, credential_path):
        cred = credentials.Certificate(credential_path)
        firebase_admin.initialize_app(cred)

        self.db = firestore.client()
        
        self.user_collection = 'users'
        self.apt_collection = 'apt'
        self.maint_collection = 'maint'
        self.application_collection = 'application'
    
    def add_data(self, _collection, _document, _data_dict):
        doc_ref = self.db.collection(_collection).document(_document)
        doc_ref.set(_data_dict)
        
    def update_data(self, _collection, _document, _update_dict):
        doc_ref = self.db.collection(_collection).document(_document)
        doc_ref.update(_update_dict)
        
    def get_single_data(self, _collection, _document):
        doc_ref = self.db.collection(_collection).document(_document)

        doc = doc_ref.get()
        # TODO: fix handling
        if doc.exists:
            print(f'Document data: {doc.to_dict()}')
        else:
            print(u'No such document!')
            
    def get_listing(self, _collection, _document, _condition):
        """
        _condition: ...
        e.g.: ['user_id', '==', None]
        """
        docs = self.db.collection(_collection).where(*_condition).stream()
        
        return [(doc.id, doc.to_dict) for doc in docs]
    
    
    ##################### CUSTOMIZED FUNCTIONS ###########################
    def add_user(self, user_id, name, email, # no longer need password
#                  password, 
                 type_, 
                 apt_id, 
                 apt_applied):
        data_dict = {
            'user_id': user_id, 
            'name': name, 
            'email': email, 
#             'password': password, 
            'type_': type_, 
            'apt_id': apt_id, 
            'apt_applied': apt_applied
        }
        self.add_data(self.user_collection, user_id, data_dict)
        
    def add_apt(self, apt_id, tenant_id, owner_id, balance):
        data_dict = {
            'apt_id': apt_id, 
            'tenant_id': tenant_id, 
            'owner_id': owner_id, 
            'balance': balance
        }
        self.add_data(self.application_collection, apt_id, data_dict)
    
    def add_maint(self, maint_id, desc, priority, status):
        data_dict = {
            'maint_id': maint_id, 
            'desc': desc, 
            'priority': priority, 
            'status': status
        }
        self.add_data(self.maint_collection, maint_id, data_dict)
    
    def update_balance(self, user_id, apt_id, owner_id, new_balance):
        apt_ref = self.get_single_data(self.apt_collection, apt_id)
        
        if apt_ref.to_dict['owner_id'] == owner_id:
            apt_ref.update({'balance': new_balance})
            return 1
        else:
            # return 0 if the apt's owner is not `owner_id`
            return 0