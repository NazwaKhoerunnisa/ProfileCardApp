import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'about_page.dart';

class ProfilePage extends StatefulWidget {
  final Function(ThemeMode)? onThemeChanged;

  const ProfilePage({Key? key, this.onThemeChanged}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Tekno';
  String email = 'tekno@test.com';
  String phone = '+62 812 3456 7890';
  String description = 'Scrolling Engineer at Flutter Inc.';
  String imageUrl = 'https://flutter.dev/images/flutter-logo-sharing.png';

  void navigateToEditPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          name: name,
          email: email,
          phone: phone,
          imageUrl: imageUrl,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        name = result['name'] ?? name;
        email = result['email'] ?? email;
        phone = result['phone'] ?? phone;
        imageUrl = result['imageUrl'] ?? imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card App'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (widget.onThemeChanged == null) return;
              if (value == 'Light') widget.onThemeChanged!(ThemeMode.light);
              if (value == 'Dark') widget.onThemeChanged!(ThemeMode.dark);
              if (value == 'System') widget.onThemeChanged!(ThemeMode.system);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'Light', child: Text('Tema Terang')),
              PopupMenuItem(value: 'Dark', child: Text('Tema Gelap')),
              PopupMenuItem(value: 'System', child: Text('Sistem')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(name, style: Theme.of(context).textTheme.titleLarge),
                  Text(description, style: const TextStyle(color: Colors.grey)),
                  const Divider(height: 30),
                  Text('Email: $email'),
                  Text('Telepon: $phone'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: navigateToEditPage,
                    child: const Text('Edit Profil'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
