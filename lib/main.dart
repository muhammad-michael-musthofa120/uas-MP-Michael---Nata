import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uas_klp_michael_nata/app/data/authController.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController(), permanent: true);
  runApp(
    StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "El - Nata",
      initialRoute: snapshot.data != null? Routes.HOME : Routes.LOGIN,
      getPages: AppPages.routes,
    );
    },
    ));
}   
