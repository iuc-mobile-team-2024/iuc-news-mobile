import 'package:flutter/material.dart';
import '../models/scraping_item.dart';
import '../services/scraping_service.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  EditScreenState createState() => EditScreenState();
}

class EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _urlController;
  late TextEditingController _selectorController;
  late TextEditingController _intervalController;
  late String _selectedMethod;
  final _scrapingService = ScrapingService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ScrapingItem item = ModalRoute.of(context)!.settings.arguments as ScrapingItem;
    _titleController = TextEditingController(text: item.title);
    _urlController = TextEditingController(text: item.url);
    _selectorController = TextEditingController(text: item.selector);
    _intervalController = TextEditingController(text: item.interval.toString());
    _selectedMethod = item.method;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _selectorController.dispose();
    _intervalController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      final ScrapingItem updatedItem = ScrapingItem(
        id: (ModalRoute.of(context)!.settings.arguments as ScrapingItem).id,
        title: _titleController.text,
        url: _urlController.text,
        selector: _selectorController.text,
        interval: int.parse(_intervalController.text),
        method: _selectedMethod,
        createdAt: DateTime.now(),
      );

      await _scrapingService.updateScrapingItem(updatedItem);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Scraping Request'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Request Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Title is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'URL',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'URL is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedMethod,
              decoration: const InputDecoration(
                labelText: 'Method',
                border: OutlineInputBorder(),
              ),
              items: ['XPath', 'CSS Selector', 'ID'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _selectorController,
              decoration: const InputDecoration(
                labelText: 'Selector',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Selector is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _intervalController,
              decoration: const InputDecoration(
                labelText: 'Interval',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Interval is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
