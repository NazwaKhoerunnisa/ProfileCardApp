import 'package:flutter/material.dart';
import 'screens/profile_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatefulWidget {
  const ProfileCardApp({Key? key}) : super(key: key);

  @override
  State<ProfileCardApp> createState() => _ProfileCardAppState();
}

class _ProfileCardAppState extends State<ProfileCardApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: ProfilePage(
        onThemeChanged: (newMode) {
          setState(() {
            themeMode = newMode;
          });
        },
      ),
    );
  }
}
