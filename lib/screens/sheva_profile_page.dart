import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class ShevaProfilePage extends StatelessWidget {
  const ShevaProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF17071F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profil',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.sos, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/shield'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto Profil
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 61,
                    backgroundColor: const Color(0xFF290D36),
                    backgroundImage: userProvider.profileImagePath != null
                        ? FileImage(File(userProvider.profileImagePath!))
                            as ImageProvider
                        : null,
                    child: userProvider.profileImagePath == null
                        ? const Icon(Icons.person,
                            size: 60, color: Color(0xFF736C78))
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () =>
                          _showImagePickerOptions(context, userProvider),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF9B89EC),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Nama
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userProvider.userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _editName(context, userProvider),
                  child: const Icon(Icons.edit,
                      color: Color(0xFF9B89EC), size: 18),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Bergabung sejak ${userProvider.joinDate}',
              style: const TextStyle(color: Color(0xFFDAC4EB), fontSize: 14),
            ),
            const SizedBox(height: 20),
            // Gender
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Gender',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildGenderOption(context, 'Laki-laki', userProvider),
                const SizedBox(width: 16),
                _buildGenderOption(context, 'Perempuan', userProvider),
              ],
            ),
            const SizedBox(height: 24),
            // Pengaturan & Lainnya
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pengaturan & Lainnya',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),
            // Pengaturan Aplikasi
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Pengaturan Aplikasi',
              subtitle: 'tema, ukuran teks, keamanan',
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            const SizedBox(height: 12),
            // Kebijakan Privasi
            _buildMenuItem(
              icon: Icons.privacy_tip,
              title: 'Kebijakan Privasi',
              subtitle: 'lihat cara kami melindungi data anda',
              onTap: () => Navigator.pushNamed(context, '/privacy'),
            ),
            const SizedBox(height: 24),
            // Deskripsi SHEVA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF291B4D),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF4E2B7B)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SHEVA - SOLIDARITY HUB FOR EQUALITY, VOICE AND ACTION',
                    style: TextStyle(
                        color: Color(0xFFDAC4EB),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Perpaduan "she" (perempuan) dan "Eva" (kehidupan) - ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text:
                              'melambangkan bahwa kesetaraan adalah nafas kehidupan bagi semua manusia',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '"For She, For He, For All."',
                style: TextStyle(color: Color(0xFFDAC4EB), fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(
      BuildContext context, String gender, UserProvider userProvider) {
    final isSelected = userProvider.userGender == gender;
    return GestureDetector(
      onTap: () {
        userProvider.setUserGender(gender);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF4E2B7B) : const Color(0xFF290D36),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected
                  ? const Color(0xFF9B89EC)
                  : const Color(0xFFDB97FB),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF736C78),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: ShapeDecoration(
          color: const Color(0xFF1A1732),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0x7F744AC1)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Color(0xFFDAC4EB), fontSize: 10)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions(
      BuildContext context, UserProvider userProvider) {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF290D36),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Foto Profil',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text('Pilih dari Galeri',
                  style: TextStyle(color: Colors.white)),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 300,
                  maxHeight: 300,
                  imageQuality: 80,
                );
                if (image != null) {
                  userProvider.setProfileImage(image.path);
                }
              },
            ),
            if (userProvider.profileImagePath != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Hapus Foto',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  userProvider.setProfileImage(null);
                },
              ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.grey),
              title: const Text('Batal', style: TextStyle(color: Colors.grey)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _editName(BuildContext context, UserProvider userProvider) {
    final controller = TextEditingController(text: userProvider.userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Nama Panggilan',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF290D36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Color(0xFF2A283E)),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Masukkan nama baru',
            hintStyle: TextStyle(color: Color(0xFF736C78)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2A283E))),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2A283E))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Batal', style: TextStyle(color: Color(0xFF919191))),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                userProvider.setUserName(controller.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E2B7B),
              foregroundColor: Colors.white,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
