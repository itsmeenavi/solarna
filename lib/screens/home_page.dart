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

  // NEW: Dialog for Payment Options
  void _showPaymentDialog(BuildContext context, NftItem item) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Confirm Purchase: ${item['title']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price: ${item['price'] ?? 'N/A'}'),
              const SizedBox(height: 20),
              const Text('Select Payment Method (Mock):'),
              // Add mock payment options here
              RadioListTile<String>(
                title: const Text('Bank Transfer'),
                value: 'bank',
                groupValue: 'bank', // Simple mock, always selected
                onChanged: (value) {},
              ),
              RadioListTile<String>(
                title: const Text('E-Wallet (Solana Pay)'),
                value: 'ewallet',
                groupValue: 'bank', // Simple mock
                onChanged: (value) {},
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Pay Now (Mock)'),
              onPressed: () {
                Navigator.of(ctx).pop(); // Close payment dialog
                print('Payment successful (mock) for ${item['title']}');
                // Show the next step: Deploy or Deliver
                _showPostPaymentOptionsDialog(context, item);
              },
            ),
          ],
        );
      },
    );
  }

  // RENAMED: Dialog for Deploy/Deliver Options (previously _showBuyOptionsDialog)
  void _showPostPaymentOptionsDialog(BuildContext context, NftItem item) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Choose Action for ${item['title']}'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Text(
              'Featured NFTs',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              itemCount: _nftItems.length,
              itemBuilder: (context, index) {
                final item = _nftItems[index];
                final bool isSaved = widget.isItemSaved(item);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            item['icon'] as IconData? ?? Icons.error,
                            size: 45,
                            color: item['color'] as Color? ?? Colors.grey[400],
                          ),
                          title: Text(
                            item['title'] as String? ?? 'No Title',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(item['subtitle'] as String? ?? ''),
                          ),
                          contentPadding: const EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
                        ),
                        const Divider(height: 15, indent: 10, endIndent: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item['price'] as String? ?? 'N/A',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                                      color: isSaved ? Theme.of(context).colorScheme.primary : Colors.grey[500],
                                    ),
                                    iconSize: 28,
                                    tooltip: isSaved ? 'Unsave Item' : 'Save Item',
                                    onPressed: () {
                                      widget.onToggleSave(item);
                                    },
                                  ),
                                  const SizedBox(width: 0),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showPaymentDialog(context, item);
                                    },
                                    child: const Text('Buy'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 10.0),
            child: Text(
              'Browse Categories',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text('More categories coming soon...', style: TextStyle(color: Colors.grey)),
            )
          ),
        ],
      ),
    );
  }
} 