import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedGender = '';

  Future<void> _saveAndNavigate() async {
    if (_nameController.text.isEmpty || _selectedGender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi nama dan pilih gender!')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userGender', _selectedGender);

    if (mounted) {
      Navigator.pushNamed(context, '/login3');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 402,
          height: 874,
          child: Stack(
            children: [
              // Background
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 402,
                  height: 874,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF290D36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
              // Kotak input nama (background)
              Positioned(
                left: 16,
                top: 343,
                child: Container(
                  width: 371,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              // Kotak pilihan Laki-laki (background)
              Positioned(
                left: 8,
                top: 443,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGender = 'Laki-laki';
                    });
                  },
                  child: Container(
                    width: 179,
                    height: 55,
                    decoration: ShapeDecoration(
                      color: _selectedGender == 'Laki-laki'
                          ? const Color(0xFF3D1A4A)
                          : const Color(0xFF240D2F),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: _selectedGender == 'Laki-laki'
                              ? const Color(0xFF9B89EC)
                              : const Color(0xFF2A283E),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Laki-laki',
                        style: TextStyle(
                          color: Color(0xFF736C78),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Kotak pilihan Perempuan (background)
              Positioned(
                left: 208,
                top: 443,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGender = 'Perempuan';
                    });
                  },
                  child: Container(
                    width: 179,
                    height: 55,
                    decoration: ShapeDecoration(
                      color: _selectedGender == 'Perempuan'
                          ? const Color(0xFF3D1A4A)
                          : const Color(0xFF240D2F),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: _selectedGender == 'Perempuan'
                              ? const Color(0xFF9B89EC)
                              : const Color(0xFF2A283E),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Perempuan',
                        style: TextStyle(
                          color: Color(0xFF736C78),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Text "Informasi ini hanya tersimpan..."
              Positioned(
                left: 47,
                top: 244,
                child: const SizedBox(
                  width: 308,
                  height: 41,
                  child: Text(
                    'Informasi ini hanya tersimpan di perangkat Anda dan tidak dikirim ke mana pun',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7E7981),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Label "Nama Panggilan"
              Positioned(
                left: 35,
                top: 317,
                child: const SizedBox(
                  width: 173,
                  height: 26,
                  child: Text(
                    'Nama Panggilan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Label "Identitas gender"
              Positioned(
                left: 35,
                top: 417,
                child: const SizedBox(
                  width: 173,
                  height: 26,
                  child: Text(
                    'Identitas gender',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // 🟢 TextField Nama
              Positioned(
                left: 35,
                top: 358,
                child: SizedBox(
                  width: 330,
                  height: 30,
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukan nama anda',
                      hintStyle: TextStyle(
                        color: Color(0xFF736C78),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              // LOGO
              Positioned(
                left: 127,
                top: 75,
                child: Container(
                  width: 148,
                  height: 148,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: NetworkImage("https://placehold.co/148x148"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              // Judul "Kenalkan diri Anda"
              Positioned(
                left: 101,
                top: 214,
                child: const SizedBox(
                  width: 196,
                  height: 18,
                  child: Text(
                    'Kenalkan diri Anda',
                    style: TextStyle(
                      color: Color(0xFF9B89EC),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // 🟢 TOMBOL LANJUTKAN
              Positioned(
                left: 16,
                top: 739,
                child: GestureDetector(
                  onTap: _saveAndNavigate,
                  child: Container(
                    width: 371,
                    height: 53,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF270F32),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF2A283E),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Lanjutkan',
                        style: TextStyle(
                          color: Color(0xFFF5F6FB),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 🟢 TOMBOL KEMBALI
              Positioned(
                left: 155,
                top: 811,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const SizedBox(
                    width: 89,
                    height: 23,
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        color: Color(0xFF918DAE),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
