import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monitor_orgadmin/ui/dashboard/dashboard_main.dart';
import 'package:monitorlibrary/bloc/theme_bloc.dart';
import 'package:monitorlibrary/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(OrgAdministratorApp());
  await Firebase.initializeApp();
  pp('🥦🥦🥦🥦🥦 OrgAdministratorApp: 🍎 Firebase has been initialized 🥦🥦🥦🥦');
}

class OrgAdministratorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: themeBloc.newThemeStream,
        builder: (context, snapshot) {
          ThemeData theme = themeBloc.getCurrentTheme();
          pp('🌸 🌸 current default theme for the app, themeIndex: ${themeBloc.themeIndex}');
          if (snapshot.hasData) {
            pp('🌸 🌸 🌸 🌸 🌸 Setting theme for the app, themeIndex: 🌸 ${snapshot.data}');
            theme = themeBloc.getTheme(snapshot.data);
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Organization Admin',
            theme: theme,
            home: DashboardMain(),
          );
        });
  }
}
