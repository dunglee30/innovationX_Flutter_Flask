import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/models/history_item.dart';

class HistoryDetailScreen extends StatelessWidget {
  final HistoryItem item;

  const HistoryDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // FIX: Changed ApiService._baseUrl to the public ApiService.baseUrl
    final imageUrl = '${ApiService.baseUrl}/uploads/${item.localFilename}';
    final formattedDate = DateTime.parse(item.timestamp).toLocal().toString().substring(0, 16);

    return Scaffold(
      appBar: AppBar(
        title: Text('History from $formattedDate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Problem Image:', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Center(
                  child: Image.network(
                    imageUrl,
                    errorBuilder: (context, error, stackTrace) => const Text('Could not load image.'),
                  ),
                ),
                const SizedBox(height: 30),
                Text('Solution:', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(item.answer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
