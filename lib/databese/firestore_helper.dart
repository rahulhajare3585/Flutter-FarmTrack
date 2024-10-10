import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to register a new user
  Future<User?> registerUser(String name, String email, String password, String contact) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    if (user != null) {
      // Store user data in Firestore
      await _firestore.collection("users").doc(user.uid).set({
        "name": name,
        "email": email,
        "contact": contact,
      });
      return user;
    }
    return null;
  }

  // Function to validate user login
  Future<User?> validateUser(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  // Function to check if a user already exists based on email
  Future<bool> checkUserExists(String email) async {
    var result = await _firestore.collection("users").where("email", isEqualTo: email).get();
    return result.docs.isNotEmpty;
  }

  // Function to register a new customer in Firestore
  Future<void> insertCustomer(String name, String address, String contact, String? aadhar) async {
    await _firestore.collection("customers").add({
      "name": name,
      "address": address,
      "contact": contact,
      "aadhar": aadhar,
    });
  }

  // Function to check if a customer already exists based on contact
  Future<bool> checkCustomerExists(String contact) async {
    var result = await _firestore.collection("customers").where("contact", isEqualTo: contact).get();
    return result.docs.isNotEmpty;
  }

  // Function to insert centring plate details
  Future<void> insertCentringPlateDetails({
    required String customerId,
    required int platesQuantity,
    required double rate,
    required double totalAmount,
    required double receivedAmount,
    required double pendingAmount,
    required int totalDays,
    required String givenDate,
    required String receivedDate,
  }) async {
    await _firestore.collection("centringPlates").add({
      "customer_id": customerId,
      "plates_quantity": platesQuantity,
      "rate": rate,
      "total_amount": totalAmount,
      "received_amount": receivedAmount,
      "pending_amount": pendingAmount,
      "total_days": totalDays,
      "given_date": givenDate,
      "received_date": receivedDate,
    });
  }

  // Function to get all customer details
  Future<List<Map<String, dynamic>>> getCustomers() async {
    var result = await _firestore.collection("customers").get();
    return result.docs.map((doc) => doc.data()).toList();
  }
}


