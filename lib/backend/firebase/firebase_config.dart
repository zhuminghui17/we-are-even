import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBCsOyTDlTHdp1jGstVp7xinjNmkLQM3Rs",
            authDomain: "weareeven-c755d.firebaseapp.com",
            projectId: "weareeven-c755d",
            storageBucket: "weareeven-c755d.appspot.com",
            messagingSenderId: "415975807381",
            appId: "1:415975807381:web:cc53f7d93b97fefb4f3e9c",
            measurementId: "G-DCJKZ6Z18F"));
  } else {
    await Firebase.initializeApp();
  }
}
