from flask import Flask
from flask_cors import CORS # Import CORS
import os

# Import the blueprint
from routes.main_routes import main_bp

app = Flask(__name__)

# --- FIX: Initialize CORS ---
# This will allow all origins to access your API.
# For production, you might want to restrict this to your Flutter app's domain.
# Example: CORS(app, resources={r"/api/*": {"origins": "https://your-flutter-app.com"}})
CORS(app)
# --------------------------

app.config.from_pyfile('config.py')

# Configure the local upload folder
UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Register the blueprint with the app
app.register_blueprint(main_bp)


if __name__ == '__main__':
    app.run(debug=True)
