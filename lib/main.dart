import 'package:flutter/material.dart';
import 'core/cache/cache_functions.dart';
import 'view/app/matrial.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheDataInit();
  runApp(const MyApp());
}
