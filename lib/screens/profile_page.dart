import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Remove Firebase Auth import
import '../services/auth_service.dart'; // Import the custom AuthService

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showEditProfileDialog(BuildContext context) {
    // Simple dialog placeholder for editing profile
     showDialog(
      context: context,
      builder: (BuildContext ctx) {
         return AlertDialog(
           title: const Text('Edit Profile'),
           content: SingleChildScrollView(
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 TextFormField(initialValue: 'User Name', decoration: const InputDecoration(labelText: 'Name')),
                 const SizedBox(height: 15),
                 TextFormField(initialValue: 'user.email@example.com', decoration: const InputDecoration(labelText: 'Email')),
                 const SizedBox(height: 15),
                  // Add more fields as needed (e.g., profile picture upload)
               ],
             ),
           ),
           actions: <Widget>[
             TextButton(
               child: const Text('Cancel'),
               onPressed: () => Navigator.of(ctx).pop(),
             ),
             ElevatedButton(
               child: const Text('Save'),
               onPressed: () {
                 // Add save logic here
                 print('Profile save tapped (mock)');
                 Navigator.of(ctx).pop();
               },
             ),
           ],
         );
      }
     );
  }

  // --- Rent Payment Dialogs --- 

  void _showSelectPropertyDialog(BuildContext context) {
    String? selectedProperty = 'property1'; // Default value
    const double mockRentAmount = 1.5; // Example rent amount in SOL

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              title: const Text('Select Property for Rent Payment'),
              content: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   const Text('Select the recipient:'),
                   RadioListTile<String>(
                     title: const Text('Main Residence (Landlord A)'), 
                     value: 'property1',
                     groupValue: selectedProperty,
                     onChanged: (String? value) {
                        setStateDialog(() { selectedProperty = value; });
                     },
                     dense: true,
                   ),
                   RadioListTile<String>(
                     title: const Text('Secondary Unit (Landlord B)'), 
                     value: 'property2',
                     groupValue: selectedProperty,
                     onChanged: (String? value) {
                       setStateDialog(() { selectedProperty = value; });
                     },
                      dense: true,
                   ),
                   const SizedBox(height: 20),
                   Text(
                      'Rent Due: ${mockRentAmount.toStringAsFixed(2)} SOL', 
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                 ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
                ElevatedButton(
                  child: const Text('Proceed to Payment'),
                  onPressed: () {
                    Navigator.of(ctx).pop(); // Close property selection
                    print('Proceeding to pay rent for $selectedProperty');
                    // Show the bank payment details dialog
                    _showRentBankPaymentDialog(context, selectedProperty ?? 'Unknown Property', mockRentAmount);
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _showRentBankPaymentDialog(BuildContext context, String propertyName, double rentAmount) {
    final formKey = GlobalKey<FormState>(); 

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Bank Transfer for Rent'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Please transfer the rent amount for "$propertyName" to the account below.'),
                  const SizedBox(height: 20),
                  Text(
                    'Amount: ${rentAmount.toStringAsFixed(2)} SOL',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  const SizedBox(height: 10),
                  const Text('Landlord Bank Account: SOL-RENT-9876'), // Mock account
                   const SizedBox(height: 20),
                   TextFormField(
                     decoration: const InputDecoration(
                       labelText: 'Transfer Reference Number',
                       hintText: 'E.g., Rent Payment May'
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
              child: const Text('Confirm Payment Sent'),
              onPressed: () {
                 Navigator.of(ctx).pop(); 
                 print('Rent Bank Payment Confirmed by User for $propertyName');
                  // Show confirmation SnackBar
                 if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Rent payment for $propertyName confirmed!'),
                        duration: const Duration(seconds: 3),
                        backgroundColor: Colors.green[700],
                      ),
                    );
                 }
              },
            ),
          ],
        );
      },
    );
  }

  // --- End Rent Payment Dialogs --- 

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(); // Instantiate AuthService

    return Scaffold(
      // AppBar theme is applied from main.dart
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView( // Use ListView for scrollable content
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        children: <Widget>[
           Center(
             child: Column(
               children: [
                 const SizedBox(height: 10),
                 CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 70, color: Colors.grey[800]),
                  // In a real app, you'd use Image.network or similar
                 ),
                 const SizedBox(height: 15),
                 const Text(
                  'User Name', // Mock User Name
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                 ),
                 const SizedBox(height: 5),
                 Text(
                  'user.email@example.com', // Mock User Email
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                 ),
                 const SizedBox(height: 25),
               ],
             ),
           ),

          const Divider(),
          const SizedBox(height: 10),

          _buildProfileOption(
            context,
            icon: Icons.edit,
            title: 'Edit Profile',
            onTap: () {
              _showEditProfileDialog(context);
            },
          ),
          _buildProfileOption(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              // Navigate to Settings or show dialog
              print('Settings tapped (mock)');
            },
          ),
          _buildProfileOption(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () async { 
              print('Logout button tapped (using AuthService)');
              try {
                // Call signOut from our custom AuthService
                await authService.signOut();
                
                // Navigate back to AuthScreen manually
                // Ensure the context is still valid before navigating
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                }
              } catch (e) {
                print('Error during custom signout: $e');
                // Optionally show a SnackBar error to the user
                if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error signing out: $e'),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                }
              }
            },
          ),
          _buildProfileOption(
            context,
            icon: Icons.house_siding, // Icon for rent/property
            title: 'Pay My Rent',
            onTap: () {
              _showSelectPropertyDialog(context);
            },
          ),
          // Add more profile options as needed (e.g., using _buildProfileOption helper)

        ],
      ),
    );
  }

  // Helper widget for profile options for consistency
  Widget _buildProfileOption(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor.withOpacity(0.8), size: 26),
      title: Text(title, style: const TextStyle(fontSize: 17)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    );
  }
} 