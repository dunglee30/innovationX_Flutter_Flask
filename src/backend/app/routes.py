from flask import Blueprint, request, jsonify
from .firebase_client import get_db_ref, upload_image_to_storage
from .openai_client import OpenAIClient

bp = Blueprint('main', __name__)

@bp.route('/upload', methods=['POST'])
def upload_image():
    if 'image' not in request.files:
        return jsonify({"error": "No image part"}), 400
    image = request.files['image']
    if image.filename == '':
        return jsonify({"error": "No selected file"}), 400

    # Upload image to Firebase Storage
    url = upload_image_to_storage(image.stream, image.filename, image.content_type)

    # Store image URL in Realtime Database
    ref = get_db_ref("uploads")
    data = {
        "filename": image.filename,
        "url": url
    }
    new_ref = ref.push(data)
    return jsonify({"key": new_ref.key, "url": url}), 201

@bp.route('/openai-image', methods=['POST'])
def openai_image():
    prompt = request.json.get("prompt")
    openai_client = OpenAIClient(api_key="YOUR_OPENAI_API_KEY")
    result = openai_client.generate_image(prompt)
    return jsonify(result)