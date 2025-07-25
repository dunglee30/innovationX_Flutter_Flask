from openai import OpenAI
from config import OPENAI_API_KEY

client = OpenAI(api_key=OPENAI_API_KEY)

def get_answer_from_images(base64_images):
    """
    Sends a list of base64 encoded images to OpenAI's vision model.
    """
    if not base64_images: return None

    content = [
        {
            "type": "text",
            "text": "These images are pages from a single document. Please analyze them and solve the math problems you find. Provide clear, step-by-step solutions for each problem."
        }
    ]
    for img in base64_images:
        content.append({
            "type": "image_url",
            "image_url": { "url": f"data:image/png;base64,{img}" }
        })

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=[{ "role": "user", "content": content }],
            max_tokens=2000
        )
        return response.choices[0].message.content.strip()
    except Exception as e:
        print(f"Error calling OpenAI API: {e}")
        return None