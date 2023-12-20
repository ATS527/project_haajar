import 'package:flutter/material.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:signals/signals_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void logout(BuildContext context) async {
    await auth.logoutUser().catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final isDark = auth.themeMode() == ThemeMode.dark;
      return Scaffold(
        body: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text("Change Theme"),
                onTap: () async {
                  auth.themeMode.value =
                      isDark ? ThemeMode.light : ThemeMode.dark;
                  await auth
                      .updateUserPrefs({"theme": isDark ? "light" : "dark"});
                },
                trailing: IconButton(
                  onPressed: () async {
                    auth.themeMode.value =
                        isDark ? ThemeMode.light : ThemeMode.dark;
                    await auth
                        .updateUserPrefs({"theme": isDark ? "light" : "dark"});
                  },
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                ),
                //increase height
                minVerticalPadding: 30,
              ),
            ),
            settingsCard(
              context,
              title: "Logout",
              icon: Icons.logout,
              onTap: () => logout(context),
            ),
            // change theme switch
          ],
        ),
      );
    });
  }

  Widget settingsCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Function onTap}) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Icon(icon),
        onTap: () {
          logout(context);
        },
        //increase height
        minVerticalPadding: 30,
      ),
    );
  }
}
