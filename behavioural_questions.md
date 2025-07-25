# AI Math Problem Solver

## Features

* **Image Upload**: Users can upload an image (PNG, JPG, etc.) containing a math problem through the web interface.
* **AI-Powered Solutions**: The backend sends the image to the OpenAI GPT-4o model, which analyzes the image, identifies the math problem, and generates a step-by-step solution.
* **Local Storage**: Uploaded images are stored securely on the local server for future reference.
* **Firebase Integration**: The solution and a reference to the uploaded image are stored in a Google Firestore database.
* **History Tracking**: Users can view a complete history of all previously submitted problems, including the original image and the corresponding solution.
* **Responsive Frontend**: The Flutter web app provides a clean and responsive UI for both uploading new problems and browsing the history.