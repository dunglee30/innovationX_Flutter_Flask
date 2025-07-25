import os
from dotenv import load_dotenv

load_dotenv()

# OpenAI API Configuration
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY", "YOUR_OPENAI_API_KEY")

# Firebase Configuration
# IMPORTANT: Create a 'firebase_credentials.json' file in the root directory
# with your Firebase Admin SDK credentials.
FIREBASE_CREDENTIALS_PATH = os.getenv("FIREBASE_CREDENTIALS_PATH", "firebase_credentials.json")