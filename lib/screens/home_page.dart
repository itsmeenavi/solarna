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
  // Mock NFT data (Inverter Removed)
  final List<NftItem> _nftItems = [
    {
      'id': 'solar_panel_001',
      'title': 'Solarna Panel X1',
      'subtitle': 'High-efficiency monocrystalline panel.',
      'icon': Icons.solar_power,
      'color': Colors.orange,
      'price': '2.5' // Store price as string for parsing
    },
    {
      'id': 'solar_pump_001',
      'title': 'AquaSol Pump V2',
      'subtitle': 'Reliable solar water pump for agriculture.',
      'icon': Icons.water_drop,
      'color': Colors.blue,
      'price': '1.8' // Store price as string for parsing
    },
    // PowerGrid Inverter removed
  ];

  // --- Dialog Functions (Refined Text & Removed "Mock") ---

  void _showPaymentDialog(BuildContext context, NftItem item) {
    int quantity = 1; 
    final double unitPrice = double.tryParse(item['price'] as String? ?? '0') ?? 0;
    String selectedPaymentMethod = 'bank'; 

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            double totalPrice = unitPrice * quantity;

            return AlertDialog(
              title: const Text('Order Summary'),
              content: SingleChildScrollView( 
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quantity Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Quantity:', style: TextStyle(fontSize: 16)),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline), 
                              onPressed: quantity <= 1 ? null : () { 
                                setStateDialog(() {
                                  quantity--;
                                });
                              },
                              iconSize: 28,
                            ),
                            Text('$quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline), 
                              onPressed: () {
                                setStateDialog(() {
                                   quantity++;
                                });
                              },
                              iconSize: 28,
                           ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Unit Price: ${unitPrice.toStringAsFixed(2)} SOL', // Added SOL
                      style: TextStyle(color: Colors.grey[600])
                    ),
                    const SizedBox(height: 5),
                     Text(
                      'Total Price: ${totalPrice.toStringAsFixed(2)} SOL', // Added SOL
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 15),
                    const Text('Select Payment Method:'), // Refined Text
                    // Updated RadioListTiles to capture selection
                    RadioListTile<String>(
                       title: const Text('Bank Transfer'), 
                       value: 'bank', 
                       groupValue: selectedPaymentMethod, 
                       onChanged: (value) {
                         if (value != null) {
                           setStateDialog(() { selectedPaymentMethod = value; });
                         }
                       },
                       dense: true, 
                       contentPadding: EdgeInsets.zero,
                     ),
                     RadioListTile<String>(
                       title: const Text('E-Wallet (Solana Pay)'), 
                       value: 'ewallet', 
                       groupValue: selectedPaymentMethod, 
                       onChanged: (value) {
                         if (value != null) {
                           setStateDialog(() { selectedPaymentMethod = value; });
                         }
                       },
                       dense: true, 
                       contentPadding: EdgeInsets.zero,
                     ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                ElevatedButton(
                  child: Text('Pay ${totalPrice.toStringAsFixed(2)} SOL'), // Removed (Mock)
                  onPressed: () {
                    Navigator.of(ctx).pop(); 
                    print('Payment initiated via $selectedPaymentMethod for $quantity x ${item['title']}'); // Removed (mock)
                    
                    if (selectedPaymentMethod == 'bank') {
                      _showBankPaymentDetailsDialog(context, item, quantity, totalPrice);
                    } else {
                      print('Payment successful via $selectedPaymentMethod'); // Removed (mock)
                      _showPostPaymentOptionsDialog(context, item, quantity); 
                    }
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showBankPaymentDetailsDialog(BuildContext context, NftItem item, int quantity, double totalPrice) {
     final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Bank Transfer Instructions'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Please transfer the amount below to the provided account and enter the reference number.'), // Refined text
                  const SizedBox(height: 20),
                  Text(
                    'Amount: ${totalPrice.toStringAsFixed(2)} SOL', // Added SOL
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  const SizedBox(height: 10),
                  const Text('Bank Account: SOL-12345-6789'), // Refined text
                   const SizedBox(height: 20),
                   TextFormField(
                     decoration: const InputDecoration(
                       labelText: 'Transfer Reference Number',
                       hintText: 'Enter reference number here'
                     ),
                   ),
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
              child: const Text('Confirm Payment'), // Removed (Mock)
              onPressed: () {
                 Navigator.of(ctx).pop(); 
                 print('Bank Payment Confirmed by User'); // Removed (Mock)
                 _showPostPaymentOptionsDialog(context, item, quantity);
              },
            ),
          ],
        );
      },
    );
  }

  void _showPostPaymentOptionsDialog(BuildContext context, NftItem item, int quantity) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Select Fulfillment'),
          content: const Text('Select how you want to receive your item(s).'), // Refined text
          actions: <Widget>[
            TextButton(
              child: const Text('Deliver Item(s)'), // Refined text
              onPressed: () {
                Navigator.of(ctx).pop(); 
                _showDeliverDialog(context, item, quantity); 
              },
            ),
            TextButton(
              child: const Text('Deploy Item(s)'), // Refined text
              onPressed: () {
                Navigator.of(ctx).pop(); 
                _showDeployDialog(context, item, quantity); 
              },
            ),
            TextButton(
              child: const Text('Cancel Purchase'), // Refined text
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeliverDialog(BuildContext context, NftItem item, int quantity) {
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Enter Delivery Address'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(decoration: const InputDecoration(labelText: 'Country/Region')),
                  TextFormField(decoration: const InputDecoration(labelText: 'Province/State')),
                  TextFormField(decoration: const InputDecoration(labelText: 'City')),
                  TextFormField(decoration: const InputDecoration(labelText: 'Postal Code')),
                  TextFormField(decoration: const InputDecoration(labelText: 'Address Line 1')),
                  TextFormField(decoration: const InputDecoration(labelText: 'Address Line 2 (Optional)')),
                  TextFormField(decoration: const InputDecoration(labelText: 'Contact Phone (Optional)')),
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
              child: const Text('Confirm Delivery Address'), // Refined text
              onPressed: () {
                print('Delivery confirmed for $quantity x ${item['title']}'); // Removed (Mock)
                Navigator.of(ctx).pop();
                // Optionally show a success message
                ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Delivery scheduled!'), duration: Duration(seconds: 2))
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeployDialog(BuildContext context, NftItem item, int quantity) {
     String? selectedFarm = 'farm1'; 

    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return AlertDialog(
                title: const Text('Select Deployment Location'),
                content: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   const Text('Choose deployment location:'), // Refined text
                   RadioListTile<String>(
                     title: const Text('Solarna Farm Alpha'), // Refined text
                     value: 'farm1',
                     groupValue: selectedFarm,
                     onChanged: (String? value) {
                        setStateDialog(() { selectedFarm = value; });
                     },
                     dense: true,
                   ),
                   RadioListTile<String>(
                     title: const Text('Solarna Farm Beta'), // Refined text
                     value: 'farm2',
                     groupValue: selectedFarm,
                     onChanged: (String? value) {
                       setStateDialog(() { selectedFarm = value; });
                     },
                     dense: true,
                   ),
                 ],
              ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                  ElevatedButton(
                    child: const Text('Confirm Deployment'), // Refined text
                    onPressed: () {
                      print('Deploy confirmed for $quantity x ${item['title']} to $selectedFarm'); // Removed (Mock)
                      Navigator.of(ctx).pop();
                       // Optionally show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Deployment to $selectedFarm initiated!'), duration: Duration(seconds: 2))
                      );
                    },
                  ),
                ],
              );
            }
          );
        }
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
                                '${item['price'] as String? ?? 'N/A'} SOL', // Added SOL back
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