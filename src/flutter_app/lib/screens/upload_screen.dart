import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/api/api_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  Uint8List? _imageBytes;
  String? _solution;
  bool _isLoading = false;
  String? _error;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = pickedFile;
        _imageBytes = bytes;
        _solution = null; // Clear previous solution
        _error = null;
      });
    }
  }

  Future<void> _uploadAndSolve() async {
    if (_imageFile == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _solution = null;
    });

    try {
      final solution = await _apiService.uploadImage(_imageFile!);
      setState(() {
        _solution = solution;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_imageBytes != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  constraints: const BoxConstraints(maxHeight: 400),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(_imageBytes!),
                  ),
                ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Pick Image'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: _imageFile != null && !_isLoading ? _uploadAndSolve : null,
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('Solve Problem'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              if (_isLoading)
                const CircularProgressIndicator(),

              if (_error != null)
                Text('Error: $_error', style: const TextStyle(color: Colors.red, fontSize: 16)),

              if (_solution != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Solution:', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      SelectableText(_solution!),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}