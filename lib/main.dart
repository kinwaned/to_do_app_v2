import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app/services/theme_services.dart';
import 'package:to_do_app/ui/home_page.dart';
import 'package:to_do_app/ui/theme.dart';


import 'db/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: Themes.darkTheme,
        theme: Themes.lightTheme,
        themeMode: ThemeServices().theme,
        home: HomePage());
  }
}
