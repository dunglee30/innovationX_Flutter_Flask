import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/models/history_item.dart';
import 'package:flutter_app/screens/history_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<HistoryItem>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _apiService.getHistory();
  }

  void _navigateToDetail(HistoryItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HistoryDetailScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistoryItem>>(
      future: _historyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No history found.'));
        }

        final historyList = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: historyList.length,
          itemBuilder: (context, index) {
            final item = historyList[index];
            // FIX: Changed ApiService._baseUrl to the public ApiService.baseUrl
            final imageUrl = '${ApiService.baseUrl}/uploads/${item.localFilename}';
            final formattedDate = DateTime.parse(item.timestamp).toLocal().toString().substring(0, 16);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: ListTile(
                leading: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                ),
                title: Text('Problem from $formattedDate'),
                subtitle: Text(
                  item.answer,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => _navigateToDetail(item),
              ),
            );
          },
        );
      },
    );
  }
}