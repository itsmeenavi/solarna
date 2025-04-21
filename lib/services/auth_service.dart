import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _usersCollection = 'users'; // Name of our Firestore collection

  // --- !!! SECURITY WARNING !!! --- 
  // Storing passwords directly like this is EXTREMELY insecure and 
  // should NEVER be done in a real application. 
  // You MUST implement proper password hashing (e.g., using bcrypt or Argon2)
  // before deploying any application.
  // This is purely for a simplified prototype demonstration.
  // --- !!! END WARNING !!! ---

  Future<Map<String, dynamic>?> signUp({
    required String email,
    required String password,
    // Add other fields like name if needed during signup
  }) async {
    try {
      // 1. Check if user already exists
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User already exists
        throw Exception('Email already in use. Please login or use a different email.');
      }

      // 2. Create new user document (Storing password insecurely!)
      final userRef = await _firestore.collection(_usersCollection).add({
        'email': email,
        'password': password, // INSECURE - Store a HASHED password here in production
        'createdAt': FieldValue.serverTimestamp(),
        // Add other user details here (e.g., name: 'User Name')
      });

      print('User created successfully in Firestore: ${userRef.id}');
      // Return user data (or just success indication)
      return {
         'uid': userRef.id, // Use Firestore document ID as a unique identifier
         'email': email,
         // Add other fields returned
      };

    } on FirebaseException catch (e) {
       print("Firestore Error during SignUp: ${e.code} - ${e.message}");
       throw Exception('Failed to sign up: ${e.message}');
    } catch (e) {
       print("Generic Error during SignUp: $e");
       throw Exception('An unexpected error occurred during sign up.');
    }
  }

  Future<Map<String, dynamic>?> signIn({
    required String email,
    required String password,
  }) async {
     try {
      // 1. Find user by email
      final querySnapshot = await _firestore
          .collection(_usersCollection)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // User not found
        throw Exception('Invalid email or password.'); // Keep error generic for security
      }

      // 2. Get user data and check password (Insecure check!)
      final userDoc = querySnapshot.docs.first;
      final userData = userDoc.data();
      final storedPassword = userData['password'] as String?;

      if (storedPassword == null || storedPassword != password) {
         // Password doesn't match (insecure comparison!)
         throw Exception('Invalid email or password.');
      }
      
      // --- Production Note --- 
      // In production, you would:
      // a) Retrieve the stored HASHED password.
      // b) Use a secure comparison function (provided by your hashing library)
      //    to compare the hash of the input password with the stored hash.
      // ----------------------

      print('User signed in successfully: ${userDoc.id}');
       // Return user data
       return {
         'uid': userDoc.id,
         'email': userData['email'],
         // Add other fields if needed
       };

    } on FirebaseException catch (e) {
       print("Firestore Error during SignIn: ${e.code} - ${e.message}");
       throw Exception('Failed to sign in: ${e.message}');
    } catch (e) {
       print("Generic Error during SignIn: $e");
       // Don't expose detailed errors here, keep it generic
       throw Exception('An error occurred during sign in.');
    }
  }

  // Sign out in this context might just clear local state.
  // For now, it doesn't need to do anything with Firestore.
  Future<void> signOut() async {
    // In a real app with state management, you would clear the user state here.
    print('AuthService: signOut called (clears local state).');
    // No Firebase interaction needed for this simple sign out.
  }

} 