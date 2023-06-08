import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseAuth AuthInstance = FirebaseAuth.instance;
Stream<User?> get firebaseUserStream => AuthInstance.authStateChanges();

FirebaseMessaging FcmInstance = FirebaseMessaging.instance;

