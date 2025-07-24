# Flask and Flutter Application

This project is a full-stack application that combines a Flask backend with a Flutter frontend. The backend provides an API for uploading images and interacting with the OpenAI API, while the frontend is a mobile application built with Flutter.

## Backend Setup

1. **Navigate to the backend directory:**
   ```bash
   cd backend
   ```

2. **Install dependencies:**
   Make sure you have Python 3.9 or higher installed. You can create a virtual environment and install the required packages using:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   pip install -r requirements.txt
   ```

3. **Run the Flask application:**
   You can run the Flask application using:
   ```bash
   flask run
   ```
   Make sure to set the `FLASK_APP` environment variable to `app`:
   ```bash
   export FLASK_APP=app  # On Windows use `set FLASK_APP=app`
   ```

## Frontend Setup

1. **Navigate to the frontend directory:**
   ```bash
   cd frontend
   ```

2. **Install Flutter dependencies:**
   Make sure you have Flutter installed. You can get the dependencies by running:
   ```bash
   flutter pub get
   ```

3. **Run the Flutter application:**
   You can run the Flutter application using:
   ```bash
   flutter run
   ```

## API Endpoints

- **Upload Image Endpoint:**
  - `POST /upload`
  - This endpoint allows users to upload images.

- **OpenAI API Interaction:**
  - This functionality is integrated into the backend to handle requests to the OpenAI API.

## Docker Setup

To build and run the backend using Docker, follow these steps:

1. **Build the Docker image:**
   ```bash
   docker build -t flask_flutter_app_backend .
   ```

2. **Run the Docker container:**
   ```bash
   docker run -p 5000:5000 flask_flutter_app_backend
   ```

## Contributing

Feel free to submit issues or pull requests for improvements or bug fixes. 

## License

This project is licensed under the MIT License.