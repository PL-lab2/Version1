import 'package:Sociio/screens/sign_in/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Sociio/screens/home_screen/home_screen.dart';

Future<User> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Account created Succesfull");

    userCrendetial.user.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser.uid).set({
      "name": name,
      "email": email,
      "uid": _auth.currentUser.uid,
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('users')
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) => userCredential.user.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SignInScreen()));
    });
  } catch (e) {
    print("error");
  }
}

Future resetPassword(BuildContext context, String email) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => SignInScreen()));
    });
  } catch (e) {
    print("error");
  }
}

Future<Stream<QuerySnapshot>> getUserByName(String name) async {
  return FirebaseFirestore.instance
      .collection("users")
      .where("name", isEqualTo: name)
      .snapshots();
}

createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
  final snapShot = await FirebaseFirestore.instance
      .collection("chatrooms")
      .doc(chatRoomId)
      .get();

  if (snapShot.exists) {
    // chatroom already exists
    return true;
  } else {
    // chatroom does not exists
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .set(chatRoomInfoMap);
  }
}
