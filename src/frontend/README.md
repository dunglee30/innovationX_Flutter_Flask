# Flask and Flutter Application

This project is a full-stack application that combines a Flask backend with a Flutter frontend. The backend handles image uploads and interacts with the OpenAI API, while the frontend provides a user interface for these functionalities.

## Frontend Setup

1. **Install Flutter**: Make sure you have Flutter installed on your machine. You can follow the installation guide on the [official Flutter website](https://flutter.dev/docs/get-started/install).

2. **Navigate to the Frontend Directory**:
   ```bash
   cd flask_flutter_app/frontend
   ```

3. **Install Dependencies**:
   Run the following command to install the necessary packages:
   ```bash
   flutter pub get
   ```

4. **Run the Flutter Application**:
   You can run the application using:
   ```bash
   flutter run
   ```

## Backend Setup

1. **Navigate to the Backend Directory**:
   ```bash
   cd flask_flutter_app/backend
   ```

2. **Install Dependencies**:
   Use pip to install the required packages:
   ```bash
   pip install -r requirements.txt
   ```

3. **Run the Flask Application**:
   You can start the Flask server with:
   ```bash
   flask run
   ```

## API Endpoints

- **Image Upload**: The backend provides an endpoint for uploading images. You can send a POST request to `/upload` with the image file.

- **OpenAI API Calls**: The backend also includes functionality to make calls to the OpenAI API. You can access this feature through the appropriate endpoint.

## Project Structure

```
flask_flutter_app
├── backend
│   ├── app
│   │   ├── __init__.py
│   │   ├── routes.py
│   │   └── openai_client.py
│   ├── requirements.txt
│   ├── Dockerfile
│   └── README.md
├── frontend
│   ├── lib
│   │   └── main.dart
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

This README provides an overview of the project and instructions for setting up both the backend and frontend components.