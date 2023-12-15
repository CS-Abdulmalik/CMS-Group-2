import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



// Function to get the roles of the current user based on email and password
Future<List<String>> getUserRoles(String email, String password) async {
  String? userId = await getUserIdByEmailAndPassword(email, password);
  if (userId != null) {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      var userData = userSnapshot.data() as Map<String, dynamic>?; // Provide type information
      var rolesData = userData?['roles'];
      if (rolesData is List<String>) {
        return List<String>.from(rolesData);
      }
    }
  }
  return [];
}

// Function to get the user ID by email and password from Firebase Authentication
Future<String?> getUserIdByEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user?.uid;
  } catch (e) {
    print('Error signing in: $e');
    return null;
  }
}