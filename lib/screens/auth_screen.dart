import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Remove Firebase Auth
import '../services/auth_service.dart'; // Import our custom AuthService
import 'main_app_screen.dart'; // Import for navigation target type safety (optional but good)

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>(); 
  bool _isLogin = true; 
  bool _isLoading = false; 

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Instantiate our AuthService
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _switchAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
       _formKey.currentState?.reset(); 
       _emailController.clear();
       _passwordController.clear();
       _confirmPasswordController.clear();
    });
  }

  Future<void> _submitAuthForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();

    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      Map<String, dynamic>? userResult;
      if (_isLogin) {
        // Log user in using AuthService
        print('Attempting Firestore Sign In...'); // Debug
        userResult = await _authService.signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
         print('Firestore Sign In successful: $userResult'); // Debug
      } else {
        // Sign user up using AuthService
         print('Attempting Firestore Sign Up...'); // Debug
        userResult = await _authService.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          // Add other fields if you collect them (e.g., name: _nameController.text)
        );
         print('Firestore Sign Up successful: $userResult'); // Debug
      }

      // Handle successful login/signup
      if (userResult != null && context.mounted) {
         // Navigate to the main app screen upon success
         // We need manual navigation now
         Navigator.of(context).pushReplacementNamed('/main');
      } else if (context.mounted) {
         // Handle case where service returns null unexpectedly (shouldn't happen if no error)
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: const Text('Authentication failed. Please try again.'),
            backgroundColor: Theme.of(context).colorScheme.error,
           ),
         );
      }

    } on Exception catch (error) { // Catch specific exceptions thrown by AuthService
      print('AuthService Exception: ${error.toString()}'); // Debug
      // Extract user-friendly message if possible (you might refine this in AuthService)
      String message = error.toString().replaceFirst('Exception: ', ''); 
      if (context.mounted) { 
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
         );
      }
    } catch (error) { // Catch any other unexpected errors
       print('Generic Error: $error'); // Debug
       if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('An unexpected error occurred.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
         );
       }
    }
    finally {
       if(mounted) {
         setState(() {
          _isLoading = false;
         });
       }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form( // Wrap content in a Form widget
            key: _formKey, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 // --- Add Logo Here --- 
                 Container(
                   padding: const EdgeInsets.all(20.0), 
                   decoration: BoxDecoration(
                     color: Colors.teal[100], // Very light Teal background
                     shape: BoxShape.circle, 
                     // Optional: Add a subtle border
                     // border: Border.all(color: Colors.teal[200]!, width: 1),
                   ),
                   child: Image.asset(
                     'assets/images/solana.png', 
                     height: 100, // Adjust size slightly smaller due to padding/container
                     errorBuilder: (context, error, stackTrace) {
                       print("Error loading logo: $error"); 
                       return const Icon(Icons.error_outline, size: 80, color: Colors.grey); 
                     },
                   ),
                 ),
                 const SizedBox(height: 25), // Adjust spacing after the container
                 // --- End Logo --- 

                 // Icon(Icons.solar_power_outlined, size: 80, color: Theme.of(context).primaryColor), // Remove old icon
                 // const SizedBox(height: 10), // Remove old spacing
                Text(
                  'Welcome to Solarna',
                  style: TextStyle(
                    fontSize: 28, // Slightly smaller
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                Text(
                  _isLogin ? 'Login' : 'Create Account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                   validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                ),
                if (!_isLogin) // Only show Confirm Password in Sign Up mode
                  const SizedBox(height: 12),
                if (!_isLogin)
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                     validator: (value) {
                       // Only validate if passwords should match (signup mode)
                       if (!_isLogin && value != _passwordController.text) {
                         return 'Passwords do not match!';
                       }
                       return null;
                     },
                  ),
                const SizedBox(height: 30),
                if (_isLoading)
                   const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submitAuthForm,
                    style: ElevatedButton.styleFrom(
                       minimumSize: const Size(double.infinity, 50), // Make button wider
                    ),
                    child: Text(_isLogin ? 'LOGIN' : 'SIGN UP', style: const TextStyle(fontSize: 16)),
                  ),
                if (!_isLoading) // Hide switch button while loading
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      '${_isLogin ? 'Create an account' : 'I already have an account'}',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 