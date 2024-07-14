import 'package:flutter/material.dart';

import 'custom_button.dart';

class OtherCustomScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final VoidCallback onButtonPressed;

  const OtherCustomScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  leading: const Icon(Icons.star),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CustomButton(
                text: 'Execute Action',
                onPressed: onButtonPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
