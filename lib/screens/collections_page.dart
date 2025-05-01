import 'package:flutter/material.dart';
// Assuming NftItem definition is accessible or redefined if needed
// Or just use Map<String, dynamic>

class CollectionsPage extends StatelessWidget {
  CollectionsPage({super.key});

  // Mock data for collected/bought NFTs
  final List<Map<String, dynamic>> _collectedItems = [
    {
      'id': 'solar_panel_001',
      'title': 'Solarna Panel X1',
      'subtitle': 'Owned - High-efficiency panel.',
      'icon': Icons.solar_power,
      'color': Colors.orange, 
      'purchaseDate': '2024-05-10' // Example extra field
    },
    {
      'id': 'solar_pump_001',
      'title': 'AquaSol Pump V2',
      'subtitle': 'Owned - Reliable water pump.',
      'icon': Icons.water_drop,
      'color': Colors.blue,
       'purchaseDate': '2024-04-22'
    },
      {
      'id': 'solar_panel_001_b', // Different ID for a second panel
      'title': 'Solarna Panel X1',
      'subtitle': 'Owned - High-efficiency panel.',
      'icon': Icons.solar_power,
      'color': Colors.orange,
       'purchaseDate': '2024-05-15'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'), // Updated Title
      ),
      body: _collectedItems.isEmpty
          ? Center(
              child: Text(
                'Your collection is empty.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0), // Add padding around the list
              itemCount: _collectedItems.length,
              itemBuilder: (context, index) {
                final item = _collectedItems[index];
                return Card(
                  // Uses theme defaults for margin, elevation, shape
                  child: ListTile(
                     leading: Icon(
                        item['icon'] as IconData? ?? Icons.token, 
                        size: 45,
                        color: item['color'] as Color? ?? Theme.of(context).primaryColor,
                      ),
                    title: Text(item['title'] as String? ?? 'No Title', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['subtitle'] as String? ?? ''),
                    trailing: Text( // Show purchase date as an example
                       'Acquired: ${item['purchaseDate'] ?? 'N/A'}',
                       style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    // isThreeLine: true, // Optionally allow more space for subtitle
                    onTap: () {
                       // Optional: Navigate to an item details page
                       print('Tapped on collected item: ${item['title']}');
                    },
                  ),
                );
              },
            ),
    );
  }
} 