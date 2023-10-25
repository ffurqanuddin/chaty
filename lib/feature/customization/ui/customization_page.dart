import 'dart:developer';

import 'package:chaty/middleware/firestore_middleware.dart';
import 'package:chaty/shared_preferences/shared_prefernces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/helper.dart';
import '../data/customization_data.dart';
import '../widgets/theme_section.dart';
import '../widgets/verification_tick_section.dart';

class CustomizationPage extends ConsumerWidget {
   CustomizationPage({super.key});



  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customization"),
        actions: [
          Icon(
            darkModeValue ? Icons.dark_mode : Icons.sunny,
            color: Colors.white,
          ),
          Switch(
              value: darkModeValue,
              onChanged: (value) {
                if (darkModeValue == false) {
                  darkModeValue = true;
                  ref.read(themeValueStateProvider.notifier).state = 3;
                } else {
                  darkModeValue = false;
                  ref.read(themeValueStateProvider.notifier).state = 0;
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ///Theme Section
            ThemeSection(ref: ref),

            SizedBox(
              height: 2.h,
            ),

            ///Pick Tick
            VerificationTickSection(
              ref: ref,
            ),

            SizedBox(
              height: 3.h,
            ),

            ///Save Setting
            ElevatedButton(
              onPressed: () async {

                ///Store Theme Value Locally
               await SharedPrefAPI.storeThemeValue(ref: ref);

                ///Store Customization Data to Firestore
                await FirestoreMiddleWare()
                    .changeCustomizationSetting(ref: ref, context: context);

              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(70.w, 6.h),
              ),
              child: const Text("Save Setting"),
            ),
          ],
        ),
      ),
    );
  }
}
