import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform; 
// import 'package:firebase_auth/firebase_auth.dart'; // Remove Firebase Auth import
// import 'firebase_options.dart'; // Don't use generated options file
import 'firebase_manual_config.dart'; // <-- Import the manual config file

import './screens/auth_screen.dart'; // Import the auth screen
import './screens/main_app_screen.dart'; // Import MainAppScreen for logout route

// --- Manual config is now in firebase_manual_config.dart ---

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  
  // Determine platform options from the manual config file
  FirebaseOptions currentPlatformOptions;
  if (Platform.isAndroid) {
    currentPlatformOptions = firebaseOptionsAndroidManual; // <-- Use constant from manual config
  } else if (Platform.isIOS) {
    // Make sure you've added your iOS config in firebase_manual_config.dart
    currentPlatformOptions = firebaseOptionsIOSManual; // <-- Use constant from manual config
  } else {
     throw Exception("Firebase not configured for this platform (manual setup)");
  }

  await Firebase.initializeApp(
    options: currentPlatformOptions, // Use options from manual config file
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solarna',
      theme: ThemeData(
        // Revert to Light Theme with Teal accents
        colorScheme: ColorScheme.fromSeed(
           seedColor: const Color(0xFF008080), // Teal
           brightness: Brightness.light, // Set brightness to light
        ),
        // Use the color scheme for consistency
        primaryColor: const Color(0xFF008080),
        
        // Set light background
        scaffoldBackgroundColor: Colors.white, // White background

        appBarTheme: AppBarTheme(
          // Use primary color variant for AppBar
          backgroundColor: const Color(0xFF006666), // Darker Teal
          foregroundColor: Colors.white, // Keep text white
          elevation: 2,
          centerTitle: true,
          titleTextStyle: const TextStyle(
             fontSize: 20.0, 
             fontWeight: FontWeight.w500,
             color: Colors.white
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2, // Slightly less elevation for light theme
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias, 
          color: Colors.white, // Explicitly white cards
        ),
         bottomNavigationBarTheme: BottomNavigationBarThemeData(
           selectedItemColor: const Color(0xFF008080), // Teal for selected
           unselectedItemColor: Colors.grey[600], 
           backgroundColor: Colors.white, 
           elevation: 5,
           showUnselectedLabels: true,
           type: BottomNavigationBarType.fixed, 
         ),
         dialogTheme: DialogTheme(
           backgroundColor: Colors.white, // White background for dialogs
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0)
           ),
           elevation: 5,
           // Adjust text styles for light background
           titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold), 
           contentTextStyle: const TextStyle(color: Colors.black54), 
         ),
         elevatedButtonTheme: ElevatedButtonThemeData(
           style: ElevatedButton.styleFrom(
             foregroundColor: Colors.white, 
             backgroundColor: const Color(0xFF008080), // Teal background
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8.0),
             ),
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
           ),
         ),
         textButtonTheme: TextButtonThemeData(
           style: TextButton.styleFrom(
             foregroundColor: const Color(0xFF006666), // Darker Teal
           ),
         ),
         inputDecorationTheme: InputDecorationTheme(
           hintStyle: TextStyle(color: Colors.grey[500]),
           labelStyle: const TextStyle(color: Color(0xFF008080)), // Teal label
           floatingLabelStyle: const TextStyle(color: Color(0xFF008080)), 
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8.0),
             borderSide: BorderSide(color: Colors.grey[400]!) // Light grey border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFF008080), width: 2.0), // Teal focus border
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
         ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Remove StreamBuilder, directly show AuthScreen initially
      home: const AuthScreen(),
      // Define routes for manual navigation later
      routes: {
        // '/': (context) => const AuthScreen(), // Keep AuthScreen as default
        '/main': (context) => const MainAppScreen(), 
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
