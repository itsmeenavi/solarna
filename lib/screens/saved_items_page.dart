import 'package:flutter/material.dart';
import 'main_app_screen.dart'; // Import NftItem typedef

class SavedItemsPage extends StatelessWidget {
  final List<NftItem> savedItems;

  const SavedItemsPage({super.key, required this.savedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Items'),
      ),
      body: savedItems.isEmpty
          ? const Center(
              child: Text(
                'You haven\'t saved any items yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                final item = savedItems[index];
                return Card(
                   margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: ListTile(
                     leading: Icon(
                        item['icon'] as IconData? ?? Icons.error, 
                        size: 40,
                        color: item['color'] as Color? ?? Colors.grey,
                      ),
                    title: Text(item['title'] as String? ?? 'No Title'),
                    subtitle: Text(item['subtitle'] as String? ?? ''),
                     // Optional: Add a trailing button to remove from saved?
                     // trailing: IconButton(
                     //   icon: Icon(Icons.delete_outline, color: Colors.red[300]),
                     //   onPressed: () { 
                     //      // Need a way to call back to MainAppScreen to remove
                     //      // For now, we'll just display
                     //    }, 
                     // ),
                  ),
                );
              },
            ),
    );
  }
} 