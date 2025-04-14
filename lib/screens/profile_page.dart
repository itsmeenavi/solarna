import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 70, color: Colors.white),
              // In a real app, you'd use Image.network or similar
            ),
            const SizedBox(height: 20),
            const Text(
              'User Name', // Mock User Name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'user.email@example.com', // Mock User Email
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.edit, color: Theme.of(context).primaryColor),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to Edit Profile screen or show dialog
                print('Edit Profile tapped (mock)');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Theme.of(context).primaryColor),
              title: const Text('Settings'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to Settings or show dialog
                print('Settings tapped (mock)');
              },
            ),
             ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).primaryColor),
              title: const Text('Logout'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Add logout logic - navigate back to AuthScreen
                 print('Logout tapped (mock)');
                 // Example navigation back (replace with your actual auth flow)
                 Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              },
            ),
            // Add more profile options as needed

          ],
        ),
      ),
    );
  }
} 