import 'package:flutter/material.dart';
import '../screens/auth_screen.dart'; // Assuming AuthScreen is in screens folder

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

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              print('Logout tapped (mock)');
              // Navigate back to AuthScreen (clearing navigation stack)
              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
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