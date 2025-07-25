from flask import Blueprint, request, jsonify, render_template, current_app, send_from_directory
from services.firebase_service import save_answer, get_all_questions
from services.openai_service import get_answer_from_images
from utils.helpers import encode_image_to_base64
import os
from werkzeug.utils import secure_filename
from uuid import uuid4

main_bp = Blueprint('main_bp', __name__)

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif', 'webp'}

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@main_bp.route('/')
def index():
    return render_template('index.html')

@main_bp.route('/api/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({"error": "No file part in the request"}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400
    if file and allowed_file(file.filename):
        try:
            filename = secure_filename(file.filename)
            unique_filename = f"{uuid4()}-{filename}"
            local_path = os.path.join(current_app.config['UPLOAD_FOLDER'], unique_filename)
            file.save(local_path)

            # Encode the uploaded image directly to base64
            base64_image = encode_image_to_base64(local_path)
            if not base64_image:
                 return jsonify({"error": "Could not process the image file."}), 500

            # The OpenAI service expects a list, so we wrap it
            answer = get_answer_from_images([base64_image])
            if not answer:
                return jsonify({"error": "Failed to get an answer from OpenAI."}), 500

            question_id = save_answer(answer, unique_filename)
            if not question_id:
                 return jsonify({"error": "Failed to save data to Firestore."}), 500

            return jsonify({
                "message": "Image processed successfully and stored locally.",
                "question_id": question_id,
                "answer": answer
            })
        except Exception as e:
            print(f"An error occurred: {e}")
            return jsonify({"error": "An internal server error occurred."}), 500
    else:
        return jsonify({"error": "Invalid file type. Please upload an image (png, jpg, jpeg, gif, webp)."}), 400

@main_bp.route('/api/history', methods=['GET'])
def get_history():
    """Endpoint to retrieve all question/answer records."""
    try:
        history = get_all_questions()
        return jsonify(history)
    except Exception as e:
        print(f"Error fetching history: {e}")
        return jsonify({"error": "Failed to retrieve history."}), 500

@main_bp.route('/uploads/<path:filename>')
def serve_upload(filename):
    """Serves an uploaded file from the uploads directory."""
    return send_from_directory(current_app.config['UPLOAD_FOLDER'], filename)
