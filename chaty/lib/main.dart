import 'package:chaty/feature/auth/ui/auth_page.dart';
import 'package:chaty/feature/home/ui/home_page.dart';
import 'package:chaty/feature/splash/ui/splash_page.dart';
import 'package:chaty/shared_preferences/shared_prefernces.dart';
import 'package:chaty/theme/theme_palletes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/customization/data/customization_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {

        return MaterialApp(
          title: 'Chaty',
          debugShowCheckedModeBanner: false,
          theme: Themes().themesList[ref.watch(themeValueStateProvider) ?? 0],
          home: const SplashPage(),
        );
      }
    );
  }
}
