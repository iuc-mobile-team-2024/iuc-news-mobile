import 'package:flutter/material.dart';
import '../models/scraping_item.dart';
import '../services/scraping_service.dart';
import '../widgets/scraping_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrapingService = ScrapingService();
  List<ScrapingItem> _scrapingItems = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchScrapingItems();
  }

  Future<void> _fetchScrapingItems() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await _scrapingService.getScrapingRequests();

      if (mounted) {
        setState(() {
          _scrapingItems = response;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load scraping requests: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scraping Requests'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchScrapingItems,
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: _fetchScrapingItems,
        child: _scrapingItems.isEmpty
            ? const Center(
          child: Text('No scraping requests found'),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _scrapingItems.length,
          itemBuilder: (context, index) {
            return ScrapingCard(item: _scrapingItems[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/create');
          if (result != null) {
            _fetchScrapingItems();
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}