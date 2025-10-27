import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tentang Aplikasi')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile Card App', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              'Aplikasi sederhana untuk menampilkan dan mengedit profil pengguna '
              'serta mengganti tema aplikasi (light/dark/system).',
            ),
            SizedBox(height: 16),
            Text('Dibuat menggunakan Flutter ❤️', style: TextStyle(color: Colors.teal)),
          ],
        ),
      ),
    );
  }
}
