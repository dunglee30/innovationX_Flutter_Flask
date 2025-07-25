import firebase_admin
from firebase_admin import credentials, firestore
import datetime
from config import FIREBASE_CREDENTIALS_PATH

# Initialize Firebase Admin SDK for Firestore ONLY
try:
    if not firebase_admin._apps:
        cred = credentials.Certificate(FIREBASE_CREDENTIALS_PATH)
        # No storageBucket configuration needed
        firebase_admin.initialize_app(cred)
    db = firestore.client()
    print("Firebase (Firestore) initialized successfully.")
except Exception as e:
    print(f"Error initializing Firebase: {e}")
    db = None

def save_answer(answer, local_filename):
    """Saves the answer and a reference to the local file in Firestore."""
    if not db:
        return None
    try:
        questions_ref = db.collection('Questions')
        doc_ref = questions_ref.document()
        doc_ref.set({
            'id': doc_ref.id,
            'local_filename': local_filename, # Storing the local filename for reference
            'answer': answer,
            'timestamp': datetime.datetime.now(tz=datetime.timezone.utc)
        })
        return doc_ref.id
    except Exception as e:
        print(f"Error saving to Firestore: {e}")
        return None

def get_all_questions():
    """Retrieves all documents from the 'Questions' collection, ordered by most recent."""
    if not db: return []
    try:
        questions_ref = db.collection('Questions').order_by(
            'timestamp', direction=firestore.Query.DESCENDING
        ).stream()
        
        questions_list = []
        for doc in questions_ref:
            data = doc.to_dict()
            # Convert timestamp to a readable string for JSON serialization
            data['timestamp'] = data['timestamp'].isoformat()
            questions_list.append(data)
        return questions_list
    except Exception as e:
        print(f"Error getting documents from Firestore: {e}")
        return []
