import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAHktfEobqf3kA60fMvM0MLMgjS6YaHOsQ",
            authDomain: "selling-test-ntnvf9.firebaseapp.com",
            projectId: "selling-test-ntnvf9",
            storageBucket: "selling-test-ntnvf9.appspot.com",
            messagingSenderId: "397765789429",
            appId: "1:397765789429:web:380db0581bb6cb5b10a7bc"));
  } else {
    await Firebase.initializeApp();
  }
}
