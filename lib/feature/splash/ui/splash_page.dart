import 'package:chaty/apis/firestore_api.dart';
import 'package:chaty/feature/auth/ui/auth_page.dart';
import 'package:chaty/feature/home/ui/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared_preferences/shared_prefernces.dart';
import '../../customization/data/customization_data.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Future gotoNextPage() async {
     Future.delayed(
      const Duration(seconds: 4),
      () async{
        if ( FirestoreAPI().currentUserID == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthPage(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        }
      },
    );
  }

  Future<void> getThemeValueFromSharedPref() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int? value = sharedPref.getInt(SharedPrefAPI.theme);
    if (value != null) {
      ref.read(themeValueStateProvider.notifier).state = value;
    } else {
      ref.read(themeValueStateProvider.notifier).state = 0;
      if (kDebugMode) {
        print('Theme Value not found in SharedPreferences');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThemeValueFromSharedPref();
    gotoNextPage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gotoNextPage();
    getThemeValueFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Page"),
      ),
    );
  }
}
