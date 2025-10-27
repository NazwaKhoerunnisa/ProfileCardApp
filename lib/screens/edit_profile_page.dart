import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  String? imagePath;
  Uint8List? webImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    imagePath = widget.imageUrl;
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          webImage = result.files.single.bytes;
          imagePath = '';
        });
      }
    } else {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imagePath = image.path;
        });
      }
    }
  }

  void saveProfile() {
    Navigator.pop(context, {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'imageUrl': imagePath ?? widget.imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = kIsWeb
        ? CircleAvatar(
            radius: 50,
            backgroundImage:
                webImage != null ? MemoryImage(webImage!) : NetworkImage(widget.imageUrl) as ImageProvider,
          )
        : CircleAvatar(
            radius: 50,
            backgroundImage: imagePath != null && imagePath!.isNotEmpty
                ? FileImage(File(imagePath!))
                : NetworkImage(widget.imageUrl) as ImageProvider,
          );

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  imageWidget,
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Telepon'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: saveProfile,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
