import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      body: SingleChildScrollView(
        child: Container(
          width: 402,
          height: 874,
          decoration: const ShapeDecoration(
            color: Color(0xFF290D36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          child: Stack(
            children: [
              // Kotak merah (SHEVA Shield)
              Positioned(
                left: 13,
                top: 241,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 371,
                    height: 102,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD90000),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              // Kotak VISI SHEVA
              Positioned(
                left: 15,
                top: 616,
                child: Container(
                  width: 371,
                  height: 127,
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
              // Teks VISI SHEVA
              Positioned(
                left: 23,
                top: 625,
                child: const SizedBox(
                  width: 363,
                  height: 110,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'VISI SHEVA\n',
                          style: TextStyle(
                            color: Color(0xFF9B89EC),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text:
                              '“Mewujudkan masyarakat yang setarea, adil, dan bebas \ndari kekerasan berbasis gender - dimana setiap individu dapat\nhidup dengan martabat dan aman.”\n\n',
                          style: TextStyle(
                            color: Color(0xFF919191),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text:
                              '- Equality is not women’s issue. It’s a human issue.',
                          style: TextStyle(
                            color: Color(0xFF919191),
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Card SHEVA Circle
              Positioned(
                left: 214,
                top: 486,
                child: SizedBox(
                  width: 173,
                  height: 75,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Opacity(
                          opacity: 0.50,
                          child: Container(
                            width: 173,
                            height: 100,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF744AC1),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 8,
                        child: Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                        ),
                      ),
                      Positioned(
                        left: 11,
                        top: 35,
                        child: const SizedBox(
                          width: 152,
                          height: 30,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'SHEVA Circle\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'HeForShe - sekutu setara',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Card SHEVA Map
              Positioned(
                left: 16,
                top: 485,
                child: SizedBox(
                  width: 172,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Opacity(
                          opacity: 0.50,
                          child: Container(
                            width: 172,
                            height: 100,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFCB338F),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 4,
                        top: 9,
                        child: Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF7A2063),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 35,
                        child: const SizedBox(
                          width: 152,
                          height: 40,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'SHEVA Map\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Layanan bantuan terdekat',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Tombol SOS (Visual)
              Positioned(
                left: 325,
                top: 787,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: ShapeDecoration(
                            color: const Color(0x7FFF0C0C),
                            shape: const OvalBorder(
                              side: BorderSide(width: 1, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(width: 30, height: 30),
                      ),
                    ],
                  ),
                ),
              ),
              // Card SHEVA Learn
              Positioned(
                left: 213,
                top: 371,
                child: SizedBox(
                  width: 173,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Opacity(
                          opacity: 0.50,
                          child: Container(
                            width: 173,
                            height: 100,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF00829F),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 11,
                        top: 9,
                        child: Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 38,
                        child: const SizedBox(
                          width: 152,
                          height: 40,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'SHEVA Learn\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Edukasi gender equality',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Label SOS
              Positioned(
                left: 320,
                top: 250,
                child: Container(
                  width: 55,
                  height: 21,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 0.50, color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 333,
                top: 252,
                child: const SizedBox(
                  width: 34,
                  height: 15,
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // Card SHEVA Report
              Positioned(
                left: 16,
                top: 370,
                child: SizedBox(
                  width: 172,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Opacity(
                          opacity: 0.50,
                          child: Container(
                            width: 172,
                            height: 100,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF5139BE),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 10,
                        child: Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 40,
                        child: const SizedBox(
                          width: 152,
                          height: 40,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'SHEVA Report\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Laporan anonim KBG/O',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Header atas
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 402,
                  height: 76,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF493370),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 12,
                child: const SizedBox(
                  width: 178,
                  height: 52,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Halo!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '                          Famuh24_\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'For She, For He, For All.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Icon & teks SHEVA Shield
              Positioned(
                left: 33,
                top: 268,
                child: Container(width: 48, height: 48),
              ),
              Positioned(
                left: 88,
                top: 276,
                child: const SizedBox(
                  width: 152,
                  height: 40,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'SHEVA Shield\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'Darurat & Keselamatan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Ikon header
              Positioned(
                left: 320,
                top: 30,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 355,
                top: 30,
                child: Container(width: 24, height: 24),
              ),
              // Carousel statistik
              Positioned(
                left: 16,
                top: 106,
                child: SizedBox(
                  width: 373,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 370,
                          height: 100,
                          decoration: ShapeDecoration(
                            color: const Color(0x7F744AC1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 385,
                        top: 0,
                        child: Container(
                          width: 370,
                          height: 100,
                          decoration: ShapeDecoration(
                            color: const Color(0x7F744AC1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 770,
                        top: 0,
                        child: Container(
                          width: 370,
                          height: 100,
                          decoration: ShapeDecoration(
                            color: const Color(0x7F744AC1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 17,
                        child: const SizedBox(
                          width: 315,
                          height: 50,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '376.529\n',
                                  style: TextStyle(
                                    color: Color(0xB2FF0909),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Kasus KBG (2025)\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Komnas Perempuan CATAHU 2025',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 413,
                        top: 17,
                        child: const SizedBox(
                          width: 315,
                          height: 50,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '8.543\n',
                                  style: TextStyle(
                                    color: Color(0xB2005DFF),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Pengaduan KBGO (2025)\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Komnas Perempuan CATAHU 2025',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 797,
                        top: 17,
                        child: const SizedBox(
                          width: 315,
                          height: 50,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '15-19 Tahun\n',
                                  style: TextStyle(
                                    color: Color(0xB2FF6B09),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Usia Korban KBGO Terbanyak\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: 'SPHPN 2024',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Logo kecil
              Positioned(
                left: 13,
                top: 17,
                child: Container(width: 49, height: 49),
              ),
              // ===== NAVIGASI =====
              // 1. Shield (card merah)
              Positioned(
                left: 13,
                top: 241,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/shield'),
                  child: Container(
                    width: 371,
                    height: 102,
                    color: Colors.transparent,
                  ),
                ),
              ),
              // 2. SOS (bulat)
              Positioned(
                left: 325,
                top: 787,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/shield'),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.transparent,
                  ),
                ),
              ),
              // 3. Report
              Positioned(
                left: 16,
                top: 370,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/report'),
                  child: Container(
                    width: 172,
                    height: 100,
                    color: Colors.transparent,
                  ),
                ),
              ),
              // 4. Circle (BARU)
              Positioned(
                left: 214,
                top: 486,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/circle'),
                  child: Container(
                    width: 173,
                    height: 75,
                    color: Colors.transparent,
                  ),
                ),
              ),
              // 5. Map
              Positioned(
                left: 16,
                top: 485,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/map'),
                  child: Container(
                    width: 172,
                    height: 100,
                    color: Colors.transparent,
                  ),
                ),
              ),
             // 6. Learn
              Positioned(
                left: 213,
                top: 371,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/learn'),
                  child: Container(
                    width: 173,
                    height: 100,
                    color: Colors.transparent,
                  ),
                ),
              ),
              // 7. Profile (area header - klik untuk ke profil)
              Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                  child: Container(
                    width: 250,
                    height: 76,
                    color: Colors.transparent,
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
