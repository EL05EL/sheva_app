import 'package:flutter/material.dart';

class LoginPage3 extends StatelessWidget {
  const LoginPage3({super.key});

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
              // 4 Kotak fitur
              Positioned(
                left: 15,
                top: 276,
                child: Container(
                  width: 371,
                  height: 100,
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
              Positioned(
                left: 15,
                top: 387,
                child: Container(
                  width: 371,
                  height: 100,
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
              Positioned(
                left: 15,
                top: 498,
                child: Container(
                  width: 371,
                  height: 100,
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
              Positioned(
                left: 15,
                top: 610,
                child: Container(
                  width: 371,
                  height: 100,
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
              // Teks "For She, For He, For All"
              Positioned(
                left: 29,
                top: 633,
                child: SizedBox(
                  width: 345,
                  height: 67,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '“For She, For He, For All”\n',
                          style: TextStyle(
                            color: Color(0xFF744AC1),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Bergabunglah bersama ribuan individu yang memperjuangkan kesetaraan gender di Indonesia!',
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
              // Teks fitur 1
              Positioned(
                left: 108,
                top: 291,
                child: SizedBox(
                  width: 278,
                  height: 67,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Perlindungan\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              'iSHEVA hadir sebagai pelindung - memberikan akses cepat ke bantuan darurat dan pelaporan',
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
              // Teks fitur 2
              Positioned(
                left: 108,
                top: 403,
                child: SizedBox(
                  width: 278,
                  height: 67,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Edukasi\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Pengetahuan adalah kekuatan. Pelajari hak-hak Anda dan bantu wujudkan kesetaraan',
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
              // Teks fitur 3
              Positioned(
                left: 108,
                top: 519,
                child: SizedBox(
                  width: 278,
                  height: 67,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Komunitas\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Bersama kita lebih kuat. Bergabunglah dengan gerakan For She, For He, For All.',
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
              // Icon placeholder
              Positioned(
                left: 45,
                top: 306,
                child: const SizedBox(width: 40, height: 40),
              ),
              Positioned(
                left: 45,
                top: 417,
                child: const SizedBox(width: 40, height: 40),
              ),
              Positioned(
                left: 45,
                top: 528,
                child: const SizedBox(width: 40, height: 40),
              ),
              // Text "Informasi ini..."
              Positioned(
                left: 47,
                top: 235,
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
              // LOGO
              Positioned(
                left: 127,
                top: 78,
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
              // Judul
              Positioned(
                left: 102,
                top: 207,
                child: const SizedBox(
                  width: 203,
                  height: 18,
                  child: Text(
                    'SHEVA hadir dengan',
                    style: TextStyle(
                      color: Color(0xFF9B89EC),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // TOMBOL MULAI PERJALANAN
              Positioned(
                left: 15,
                top: 741,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home');
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
                        'Mulai Perjalanan',
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
              // TOMBOL KEMBALI
              Positioned(
                left: 150,
                top: 810,
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
