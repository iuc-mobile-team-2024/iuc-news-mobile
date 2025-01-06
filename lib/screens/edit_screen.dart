import 'package:flutter/material.dart';
import '../models/scraping_item.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kazıma İsteğini Düzenle'),
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
                labelText: 'İstek Başlığı',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Başlık gereklidir';
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
                  return 'URL gereklidir';
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
                  return 'Selector gereklidir';
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
                  return 'Interval gereklidir';
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
                  child: const Text('İptal'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Save the form
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Düzenle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}