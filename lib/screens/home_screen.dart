import 'package:flutter/material.dart';
import '../widgets/scraping_card.dart';
import '../models/scraping_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<ScrapingItem> items = [
      ScrapingItem(
        title: 'İstanbul Üniversitesi Duyurular',
        url: 'https://iuc.edu.tr/tr/duyurular/1/1',
        method: 'XPath',
        selector: '/html/body/div[1]/div[2]/div',
        interval: 3600,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      // Add more sample items...
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kazıma İstekleri',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/create'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ScrapingCard(item: items[index]),
          );
        },
      ),
    );
  }
}