import 'package:flutter/material.dart';

class LoginPage1 extends StatelessWidget {
  const LoginPage1({super.key});

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
              // Background utama
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
              // 3 Kotak statistik
              Positioned(
                left: 16,
                top: 389,
                child: Container(
                  width: 118,
                  height: 78,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF322E51),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 142,
                top: 389,
                child: Container(
                  width: 118,
                  height: 78,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF322E51),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 269,
                top: 389,
                child: Container(
                  width: 118,
                  height: 78,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF322E51),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              // Kotak quote
              Positioned(
                left: 16,
                top: 497,
                child: Container(
                  width: 371,
                  height: 89,
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
              // LOGO
              Positioned(
                left: 127,
                top: 77,
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
              // Text quote
              Positioned(
                left: 5,
                top: 518,
                child: const SizedBox(
                  width: 392,
                  height: 60,
                  child: Text(
                    '“SHEVA hadir untuk mewujudkan masyarakat indonesia\n yang setara, adil, dan bebas dari kekerasan berbasis\ngender.”',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF919191),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Judul
              Positioned(
                left: 110,
                top: 179,
                child: SizedBox(
                  width: 182,
                  height: 180,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Selamat Datang di',
                          style: TextStyle(
                            color: Color(0xFF837F98),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '                          SHEVA\n',
                          style: TextStyle(
                            color: Color(0xFF9B89EC),
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              '\nSolidarity Hub For \nEquality,  Voice, And Action',
                          style: TextStyle(
                            color: Color(0xFF837F98),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Statistik 1
              Positioned(
                left: 35,
                top: 401,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '378K+\n',
                        style: TextStyle(
                          color: Color(0xFFA49AE2),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'Kasus KBG\nTercatat 2025',
                        style: TextStyle(
                          color: Color(0xFF837F98),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Statistik 2
              Positioned(
                left: 297,
                top: 401,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '100%\n',
                        style: TextStyle(
                          color: Color(0xFFA49AE2),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'Data\nTerenkripsi',
                        style: TextStyle(
                          color: Color(0xFF837F98),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Statistik 3
              Positioned(
                left: 154,
                top: 397,
                child: SizedBox(
                  width: 95,
                  height: 63,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '8\n',
                          style: TextStyle(
                            color: Color(0xFFA49AE2),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'Fitur Perlindungan',
                          style: TextStyle(
                            color: Color(0xFF837F98),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 🟢 TOMBOL MULAI
              Positioned(
                left: 16,
                top: 741,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login2');
                  },
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
                        'Mulai',
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
            ],
          ),
        ),
      ),
    );
  }
}
