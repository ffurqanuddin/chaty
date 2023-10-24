


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/customization/data/customization_data.dart';

class SharedPrefAPI{

  static String theme = "theme";


  static storeThemeValue({required WidgetRef ref})async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(theme, ref.watch(themeValueStateProvider.notifier).state);
  }




}