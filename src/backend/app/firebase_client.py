import firebase_admin
from firebase_admin import credentials, db, storage
import os

SERVICE_ACCOUNT_PATH = os.path.join(
    os.path.dirname(__file__), "serviceAccountKey.json"
)

FIREBASE_PROJECT_ID = "<YOUR_PROJECT_ID>"

if not firebase_admin._apps:
    cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)
    firebase_admin.initialize_app(cred, {
        "databaseURL": f"https://{FIREBASE_PROJECT_ID}.firebaseio.com/",
        "storageBucket": f"{FIREBASE_PROJECT_ID}.appspot.com"
    })

def get_db_ref(path="/"):
    return db.reference(path)

def upload_image_to_storage(file_stream, filename, content_type):
    bucket = storage.bucket()
    blob = bucket.blob(filename)
    blob.upload_from_file(file_stream, content_type=content_type)
    blob.make_public()
    return blob.public_url