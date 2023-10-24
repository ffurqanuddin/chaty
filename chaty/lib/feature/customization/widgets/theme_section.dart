


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../data/customization_data.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({
    super.key,
    // required this.currentTheme,
    required this.ref,
  });

  final WidgetRef ref;

  // final ThemeValue currentTheme;

  @override
  Widget build(BuildContext context) {
    ThemeValue currentTheme = ref.watch<ThemeValue>(currentThemeStateProvider);
    return Column(
      children: [
        SizedBox(
          height: 2.h,
        ),
        Text(
          "Pick Theme",
          style: GoogleFonts.aboreto(fontSize: 20),
        ),
        SizedBox(
          height: 1.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RadioListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              tileColor: const Color.fromRGBO(210, 233, 233, 1),
              title: Text(
                "Default",
                style: GoogleFonts.roboto(
                    color: darkModeValue ? Colors.white : Colors.black),
              ),
              value: ThemeValue.defaultTheme,
              groupValue: currentTheme,
              onChanged: (value) {
                ref.read(currentThemeStateProvider.notifier).state = value!;
                ref.read(themeValueStateProvider.notifier).state = value.index;
                darkModeValue = false;
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RadioListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              tileColor: const Color.fromRGBO(54, 48, 98, 1),
              title: Text(
                "Purple",
                style: GoogleFonts.puritan(color: Colors.white),
              ),
              value: ThemeValue.purple,
              groupValue: currentTheme,
              onChanged: (value) {
                ref.read(currentThemeStateProvider.notifier).state = value!;
                ref.read(themeValueStateProvider.notifier).state = value.index;
                darkModeValue = false;
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RadioListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              tileColor: const Color.fromRGBO(253, 206, 223, 1),
              title: Text(
                "Creamy",
                style: GoogleFonts.cabin(
                    color: darkModeValue ? Colors.white : Colors.black),
              ),
              value: ThemeValue.theme3,
              groupValue: currentTheme,
              onChanged: (value) {
                ref.read(currentThemeStateProvider.notifier).state = value!;
                ref.read(themeValueStateProvider.notifier).state = value.index;
                darkModeValue = false;
              },
            ),
          ),
        ),

        ///Urchin
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RadioListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              tileColor: const  Color.fromRGBO	(170,126,190, 1),
              title: Text(
                "Urchin",
                style: GoogleFonts.magra(
                    color: darkModeValue ? Colors.white : Colors.black),
              ),
              value: ThemeValue.urchin,
              groupValue: currentTheme,
              onChanged: (value) {
                ref.read(currentThemeStateProvider.notifier).state = value!;
                ref.read(themeValueStateProvider.notifier).state = value.index;
                darkModeValue = false;
              },
            ),
          ),
        ),
      ],
    );
  }
}