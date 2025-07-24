class OpenAIClient:
    def __init__(self, api_key):
        self.api_key = api_key
        self.base_url = "https://api.openai.com/v1"

    def send_request(self, endpoint, data):
        import requests

        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        response = requests.post(f"{self.base_url}/{endpoint}", json=data, headers=headers)
        return response.json()

    def generate_image(self, prompt):
        data = {
            "prompt": prompt,
            "n": 1,
            "size": "1024x1024"
        }
        return self.send_request("images/generations", data)