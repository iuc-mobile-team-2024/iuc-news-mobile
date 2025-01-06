import 'package:flutter/material.dart';
import 'dart:async';
import '../models/scraping_item.dart';
import '../services/scraping_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _scrapingService = ScrapingService();
  ScrapingItem? _currentItem;
  Timer? _timer;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ScrapingItem item = ModalRoute.of(context)!.settings.arguments as ScrapingItem;
      _currentItem = item;
      _startPolling();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startPolling() {
    // Initial fetch
    _fetchResults();

    // Set up periodic polling
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchResults();
    });
  }

  Future<void> _fetchResults() async {
    if (_currentItem?.id == null) return;

    try {
      final updatedItem = await _scrapingService.getScrapingResults(_currentItem!.id!);
      if (mounted) {
        setState(() {
          _currentItem = updatedItem;
          _isLoading = false;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentItem == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentItem!.title),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchResults,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status: ${_currentItem!.status ?? "Unknown"}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('URL: ${_currentItem!.url}'),
                    Text('Method: ${_currentItem!.method}'),
                    Text('Selector: ${_currentItem!.selector}'),
                    if (_currentItem!.lastUpdated != null)
                      Text('Last Updated: ${_formatDateTime(_currentItem!.lastUpdated!)}'),
                    const SizedBox(height: 16),
                    const Text(
                      'Content:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (_error != null)
                      Text(
                        'Error: $_error',
                        style: const TextStyle(color: Colors.red),
                      )
                    else if (_currentItem!.content?.isEmpty ?? true)
                        const Text('No content available')
                      else
                        Text(_currentItem!.content!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}