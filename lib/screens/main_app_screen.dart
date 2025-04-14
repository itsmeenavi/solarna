import 'package:flutter/material.dart';

import 'home_page.dart';
import 'earnings_page.dart';
import 'saved_items_page.dart';
import 'collections_page.dart';
import 'profile_page.dart';

// Define a simple structure for NFT data (can be expanded later)
typedef NftItem = Map<String, dynamic>;

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0; // Index for the current tab
  final List<NftItem> _savedItems = []; // List to hold saved NFTs

  // Function to add an item to the saved list (if not already present)
  void _toggleSavedItem(NftItem item) {
    setState(() {
      final isSaved = _savedItems.any((savedItem) => savedItem['id'] == item['id']);
      if (isSaved) {
        _savedItems.removeWhere((savedItem) => savedItem['id'] == item['id']);
        print('Item removed from saved: ${item['title']}'); // For debugging
      } else {
        _savedItems.add(item);
        print('Item added to saved: ${item['title']}'); // For debugging
      }
    });
  }

  // Checks if an item is currently saved
  bool _isItemSaved(NftItem item) {
     return _savedItems.any((savedItem) => savedItem['id'] == item['id']);
  }

  // Generate the list of widgets dynamically to pass state
  List<Widget> _buildWidgetOptions() {
    return <Widget>[
      HomePage( 
        onToggleSave: _toggleSavedItem, 
        isItemSaved: _isItemSaved, // Pass the check function
      ),
      const EarningsPage(),
      SavedItemsPage(savedItems: _savedItems), // Pass the list of saved items
      const CollectionsPage(),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the dynamically generated widget list
    final widgetOptions = _buildWidgetOptions();

    return Scaffold(
      // The body will display the widget from widgetOptions based on the selected index
      // Use IndexedStack to keep the state of the pages when switching tabs
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: 'Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        showUnselectedLabels: true, // Show labels for unselected items too
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
      ),
    );
  }
} 