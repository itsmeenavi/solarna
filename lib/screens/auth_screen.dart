import 'package:flutter/material.dart';
import 'main_app_screen.dart'; // We will create this later

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true; // Toggle between Login and Signup

  void _switchAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _submitAuthForm() {
    // Mock login/signup logic
    // In a real app, you would validate and send data to a backend
    print('Auth submitted (mock)');
    // Navigate to the main app screen after successful "login/signup"
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const MainAppScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView( // Allows scrolling if content overflows
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Solarna',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 40),

              // --- Form Placeholder ---
              // We will add TextFormFields here later
              Text(
                _isLogin ? 'Login' : 'Sign Up',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
               const SizedBox(height: 20),
               TextFormField(
                 decoration: const InputDecoration(labelText: 'Email'),
                 keyboardType: TextInputType.emailAddress,
               ),
               const SizedBox(height: 10),
               TextFormField(
                 decoration: const InputDecoration(labelText: 'Password'),
                 obscureText: true,
               ),
               if (!_isLogin) // Only show Confirm Password in Sign Up mode
                 const SizedBox(height: 10),
               if (!_isLogin)
                 TextFormField(
                   decoration: const InputDecoration(labelText: 'Confirm Password'),
                   obscureText: true,
                 ),
              // --- End Form Placeholder ---

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitAuthForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(_isLogin ? 'LOGIN' : 'SIGN UP'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  '${_isLogin ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 