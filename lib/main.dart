import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/auth_controller.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/introduction_screen/splaash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('🟡 Initializing GetStorage...');
  await GetStorage.init();
  print('✅ GetStorage initialized');

  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();

  Get.put(AuuthController());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);

  runApp(GetMaterialApp(
    home: const SplashScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: AppStyles.bgPrimary,
    ),
  ));
}
