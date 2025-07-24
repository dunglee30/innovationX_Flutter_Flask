# Flask and Flutter Application

This project is a web application that combines a Flask backend with a Flutter frontend. The backend provides an API for uploading images and interacting with the OpenAI API, while the frontend is a mobile application built with Flutter.

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

## Backend Setup

1. Navigate to the `backend` directory:
   ```
   cd backend
   ```

2. Install the required dependencies:
   ```
   pip install -r requirements.txt
   ```

3. Run the Flask application:
   ```
   flask run
   ```

## Frontend Setup

1. Navigate to the `frontend` directory:
   ```
   cd frontend
   ```

2. Get the Flutter dependencies:
   ```
   flutter pub get
   ```

3. Run the Flutter application:
   ```
   flutter run
   ```

## Features

- **Image Upload**: The backend provides an endpoint for uploading images.
- **OpenAI API Integration**: The backend can make calls to the OpenAI API for processing requests.

## Docker Support

The backend can be containerized using Docker. To build and run the Docker container, navigate to the `backend` directory and run:
```
docker build -t flask_flutter_app .
docker run -p 5000:5000 flask_flutter_app
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or features you'd like to add.