import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:im_legends/features/auth/data/models/user_data.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');

  /// ---------------------------
  /// SIGN UP
  /// ---------------------------
  Future<void> signUp({required UserData userData, required password}) async {
    try {
      // Create user in Firebase Auth
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: userData.email,
            password: password,
          );

      // Get user UID
      String uid = credential.user!.uid;

      // Save additional data to Firestore
      await usersCollection.doc(uid).set({
        'name': userData.name,
        'phoneNumber': userData.phoneNumber,
        'age': userData.age,
        'email': userData.email,
        'createdAt': FieldValue.serverTimestamp(),
        'profileImage': userData.profileImageUrl, // Optional placeholder
        'stats': {'matchesWon': 0, 'goalsScored': 0},
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception(e.message ?? 'Sign-up failed.');
      }
    }
  }

  /// ---------------------------
  /// LOGIN
  /// ---------------------------
  Future<UserData> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Fetch user data from Firestore
      DocumentSnapshot snapshot = await usersCollection
          .doc(credential.user!.uid)
          .get();

      final data = snapshot.data() as Map<String, dynamic>;

      return UserData(
        name: data['name'],
        phoneNumber: data['phoneNumber'],
        age: data['age'],
        email: data['email'],
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided.');
      } else {
        throw Exception(e.message ?? 'Login failed.');
      }
    }
  }

  /// ---------------------------
  /// LOGOUT
  /// ---------------------------
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  /// ---------------------------
  /// GET CURRENT USER DATA
  /// ---------------------------
  Future<UserData?> getCurrentUserData() async {
    User? user = _firebaseAuth.currentUser;
    if (user == null) return null;

    DocumentSnapshot snapshot = await usersCollection.doc(user.uid).get();
    if (!snapshot.exists) return null;

    final data = snapshot.data() as Map<String, dynamic>;

    return UserData(
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      age: data['age'],
      email: data['email'],
    );
  }
}
