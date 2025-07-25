import base64
from PIL import Image

def encode_image_to_base64(image_path):
    """
    Reads an image file, validates it, and encodes it to a base64 string.
    """
    try:
        # Verify it's a valid image file to prevent errors
        with Image.open(image_path) as img:
            img.verify() # Verify the image integrity
        
        # Read the raw bytes and encode
        with open(image_path, "rb") as image_file:
            return base64.b64encode(image_file.read()).decode('utf-8')
    except Exception as e:
        print(f"Error encoding image file: {e}")
        return None