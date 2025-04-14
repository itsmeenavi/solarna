import 'package:flutter/material.dart';
import 'main_app_screen.dart'; // Corrected import path

class HomePage extends StatefulWidget {
  final Function(NftItem) onToggleSave;
  final bool Function(NftItem) isItemSaved;

  const HomePage({
    super.key,
    required this.onToggleSave,
    required this.isItemSaved,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Mock NFT data
  final List<NftItem> _nftItems = [
    {
      'id': 'solar_panel_001',
      'title': 'Solarna Panel X1',
      'subtitle': 'High-efficiency monocrystalline panel.',
      'icon': Icons.solar_power,
      'color': Colors.orange,
      'price': '2.5 SOL'
    },
    {
      'id': 'solar_pump_001',
      'title': 'AquaSol Pump V2',
      'subtitle': 'Reliable solar water pump for agriculture.',
      'icon': Icons.water_drop,
      'color': Colors.blue,
      'price': '1.8 SOL'
    },
     {
      'id': 'solar_inverter_001',
      'title': 'PowerGrid Inverter',
      'subtitle': 'Convert solar energy efficiently.',
      'icon': Icons.electrical_services,
      'color': Colors.green,
      'price': '1.2 SOL'
    },
  ];

  // --- Dialog Functions ---

  void _showBuyOptionsDialog(BuildContext context, NftItem item) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Buy ${item['title']}'),
          content: const Text('Choose an option:'),
          actions: <Widget>[
            TextButton(
              child: const Text('Deliver'),
              onPressed: () {
                Navigator.of(ctx).pop(); // Close this dialog
                _showDeliverDialog(context, item); // Show delivery dialog
              },
            ),
            TextButton(
              child: const Text('Deploy'),
              onPressed: () {
                Navigator.of(ctx).pop(); // Close this dialog
                _showDeployDialog(context, item); // Show deploy dialog
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeliverDialog(BuildContext context, NftItem item) {
    final formKey = GlobalKey<FormState>();
    // Add TextEditingControllers if you need to capture input

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Delivery Details'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(decoration: const InputDecoration(labelText: 'Country')),
                  TextFormField(decoration: const InputDecoration(labelText: 'Province/State')),
                  TextFormField(decoration: const InputDecoration(labelText: 'City')),
                  TextFormField(decoration: const InputDecoration(labelText: 'Postal Code')),
                  TextFormField(decoration: const InputDecoration(labelText: 'Address Line 1')),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            ElevatedButton(
              child: const Text('Confirm Delivery'),
              onPressed: () {
                // Add form validation and delivery logic here
                print('Delivery confirmed for ${item['title']} (Mock)');
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeployDialog(BuildContext context, NftItem item) {
     String? selectedFarm = 'farm1'; // Default value

    showDialog(
      context: context,
      // Use StatefulBuilder to manage state within the dialog
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              title: const Text('Deploy Options'),
              content: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   const Text('Choose Farm:'),
                   RadioListTile<String>(
                     title: const Text('Farm One'),
                     value: 'farm1',
                     groupValue: selectedFarm,
                     onChanged: (String? value) {
                        setStateDialog(() {
                           selectedFarm = value;
                        });
                     },
                   ),
                   RadioListTile<String>(
                     title: const Text('Farm Two'),
                     value: 'farm2',
                     groupValue: selectedFarm,
                     onChanged: (String? value) {
                       setStateDialog(() {
                          selectedFarm = value;
                       });
                     },
                   ),
                 ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
                ElevatedButton(
                  child: const Text('Deploy'),
                  onPressed: () {
                    print('Deploy confirmed for ${item['title']} to $selectedFarm (Mock)');
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }

  // --- Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solarna Marketplace'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Reduced padding for cards
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Text(
                'Featured NFTs',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              // Use ListView.builder for potentially longer lists
              child: ListView.builder(
                itemCount: _nftItems.length,
                itemBuilder: (context, index) {
                  final item = _nftItems[index];
                  final bool isSaved = widget.isItemSaved(item);
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Make column height fit content
                        children: [
                          ListTile(
                            leading: Icon(
                              item['icon'] as IconData? ?? Icons.error, 
                              size: 45,
                              color: item['color'] as Color? ?? Colors.grey,
                            ),
                            title: Text(item['title'] as String? ?? 'No Title', style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(item['subtitle'] as String? ?? ''),
                            // contentPadding: EdgeInsets.zero, // Adjust if needed
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0), // Align price text
                                child: Text(
                                  item['price'] as String? ?? 'N/A',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).primaryColorDark),
                                ),
                              ),
                              Row( // Row for buttons
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   IconButton(
                                    icon: Icon(
                                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                                      color: isSaved ? Theme.of(context).primaryColor : Colors.grey,
                                    ),
                                    tooltip: isSaved ? 'Unsave Item' : 'Save Item',
                                    onPressed: () {
                                      widget.onToggleSave(item); // Use the callback
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showBuyOptionsDialog(context, item);
                                    },
                                    child: const Text('Buy'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Text(
                'Browse Categories', // Placeholder for categories
                style: Theme.of(context).textTheme.headlineSmall,
                       ),
             ),
             // Add category placeholders or a GridView later
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text('More categories coming soon...')
              )
            ),
          ],
        ),
      ),
    );
  }
} 