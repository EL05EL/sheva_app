import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShevaProfilePage extends StatefulWidget {
  const ShevaProfilePage({super.key});

  @override
  State<ShevaProfilePage> createState() => _ShevaProfilePageState();
}

class _ShevaProfilePageState extends State<ShevaProfilePage> {
  String _userName = 'Famuh24_';
  String _userGender = 'Laki-laki';
  String _joinDate = 'Maret 2022';
  String? _profileImagePath;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Famuh24_';
      _userGender = prefs.getString('userGender') ?? 'Laki-laki';
      _joinDate = prefs.getString('joinDate') ?? 'Maret 2022';
      _profileImagePath = prefs.getString('profileImagePath');
    });
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    await prefs.setString('userGender', _userGender);
    if (_profileImagePath != null) {
      await prefs.setString('profileImagePath', _profileImagePath!);
    }
  }

  Future<void> _editName() async {
    final controller = TextEditingController(text: _userName);
    final result = await showDialog<String>(
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
              child: const Text('Batal',
                  style: TextStyle(color: Color(0xFF919191)))),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Navigator.pop(context, controller.text);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E2B7B),
                foregroundColor: Colors.white),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      setState(() => _userName = result);
      await _saveUserData();
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 80);
    if (image != null) {
      setState(() => _profileImagePath = image.path);
      await _saveUserData();
    }
  }

  Future<void> _removeImage() async {
    setState(() => _profileImagePath = null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profileImagePath');
  }

  void _navigateToSettings() => Navigator.pushNamed(context, '/settings');
  void _navigateToPrivacy() => Navigator.pushNamed(context, '/privacy');

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: _profileImagePath != null
                        ? FileImage(File(_profileImagePath!)) as ImageProvider
                        : null,
                    child: _profileImagePath == null
                        ? const Icon(Icons.person,
                            size: 60, color: Color(0xFF736C78))
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: const Color(0xFF290D36),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Foto Profil',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                ListTile(
                                  leading: const Icon(Icons.photo_library,
                                      color: Colors.white),
                                  title: const Text('Pilih dari Galeri',
                                      style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _pickImage();
                                  },
                                ),
                                if (_profileImagePath != null)
                                  ListTile(
                                    leading: const Icon(Icons.delete,
                                        color: Colors.red),
                                    title: const Text('Hapus Foto',
                                        style: TextStyle(color: Colors.red)),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _removeImage();
                                    },
                                  ),
                                ListTile(
                                  leading: const Icon(Icons.close,
                                      color: Colors.grey),
                                  title: const Text('Batal',
                                      style: TextStyle(color: Colors.grey)),
                                  onTap: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            color: Color(0xFF9B89EC), shape: BoxShape.circle),
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
                Text(_userName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _editName,
                  child: const Icon(Icons.edit,
                      color: Color(0xFF9B89EC), size: 18),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Bergabung sejak $_joinDate',
                style: const TextStyle(color: Color(0xFFDAC4EB), fontSize: 14)),
            const SizedBox(height: 20),
            // Gender
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Gender',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildGenderOption('Laki-laki'),
                const SizedBox(width: 16),
                _buildGenderOption('Perempuan'),
              ],
            ),
            const SizedBox(height: 24),
            // Pengaturan & Lainnya
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Pengaturan & Lainnya',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 8),
            // Pengaturan Aplikasi
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Pengaturan Aplikasi',
              subtitle: 'tema, ukuran teks, keamanan',
              onTap: _navigateToSettings,
            ),
            const SizedBox(height: 12),
            // Kebijakan Privasi
            _buildMenuItem(
              icon: Icons.privacy_tip,
              title: 'Kebijakan Privasi',
              subtitle: 'lihat cara kami melindungi data anda',
              onTap: _navigateToPrivacy,
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
                  Text('SHEVA - SOLIDARITY HUB FOR EQUALITY, VOICE AND ACTION',
                      style: TextStyle(
                          color: Color(0xFFDAC4EB),
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
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
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                            text:
                                'melambangkan bahwa kesetaraan adalah nafas kehidupan bagi semua manusia',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text('"For She, For He, For All."',
                  style: TextStyle(color: Color(0xFFDAC4EB), fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    final isSelected = _userGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() => _userGender = gender);
        _saveUserData();
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

  Widget _buildMenuItem(
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
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
}
