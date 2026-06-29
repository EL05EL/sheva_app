import 'package:flutter/material.dart';

class ShevaShieldPage extends StatelessWidget {
  const ShevaShieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      appBar: AppBar(
        title: const Text('SHEVA Shield'),
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 402,
          height: 1260,
          clipBehavior: Clip.antiAlias,
          decoration: const ShapeDecoration(
            color: Color(0xFF290D36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          child: Stack(
            children: [
              // Kotak foto/bukti
              Positioned(
                left: 15,
                top: 99,
                child: Container(
                  width: 379,
                  height: 112,
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
              // Kotak deskripsi
              Positioned(
                left: 7,
                top: 449,
                child: Container(
                  width: 379,
                  height: 150,
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
              // Panduan keselamatan (6 item)
              Positioned(
                left: 10,
                top: 908,
                child: Container(
                  width: 379,
                  height: 51,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 11,
                top: 959,
                child: Container(
                  width: 379,
                  height: 51,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 11,
                top: 1010,
                child: Container(
                  width: 379,
                  height: 51,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 11,
                top: 1056,
                child: Container(
                  width: 379,
                  height: 51,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 11,
                top: 1105,
                child: Container(
                  width: 379,
                  height: 51,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 11,
                top: 1153,
                child: Container(
                  width: 379,
                  height: 51,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                    ),
                  ),
                ),
              ),
              // Input lokasi
              Positioned(
                left: 15,
                top: 324,
                child: Container(
                  width: 379,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0x267A2062),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF7A2062),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 372,
                child: Container(
                  width: 379,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0x26DAD3D8),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF290D36),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              // Teks "Belum ada foto/bukti"
              Positioned(
                left: 123,
                top: 155,
                child: const SizedBox(
                  width: 156,
                  height: 25,
                  child: Text(
                    'Belum ada foto/bukti',
                    style: TextStyle(
                      color: Color(0xFF8B85A6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Icon di header
              Positioned(
                left: 180,
                top: 114,
                child: Container(
                  width: 41,
                  height: 41,
                  color: const Color(0xFF240D2F),
                ),
              ),
              // Label lokasi
              Positioned(
                left: 24,
                top: 295,
                child: Container(
                  width: 21,
                  height: 21,
                  color: const Color(0xFF290D36),
                ),
              ),
              Positioned(
                left: 22,
                top: 383,
                child: Container(
                  width: 21,
                  height: 21,
                  color: const Color(0xFF442B4E),
                ),
              ),
              Positioned(
                left: 45,
                top: 299,
                child: const SizedBox(
                  width: 105,
                  height: 9,
                  child: Text(
                    'lokasi kejadian',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 115,
                top: 335,
                child: const SizedBox(
                  width: 172,
                  height: 18,
                  child: Text(
                    'Deteksi Lokasi Otomatis',
                    style: TextStyle(
                      color: Color(0xFFF30DB6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 43,
                top: 383,
                child: const SizedBox(
                  width: 186,
                  height: 17,
                  child: Text(
                    'atau ketik lokasi manual.....',
                    style: TextStyle(
                      color: Color(0xFFF6F3F7),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 19,
                top: 427,
                child: const SizedBox(
                  width: 137,
                  height: 22,
                  child: Text(
                    'Deskripsi kejadian',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Nomor darurat (kotak-kotak)
              Positioned(
                left: 21,
                top: 919,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 20,
                    height: 29,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF411616),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFFF0909),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 970,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 20,
                    height: 29,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF411616),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFFF0909),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 1018,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 20,
                    height: 29,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF411616),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFFF0909),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 1067,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 20,
                    height: 29,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF411616),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFFF0909),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 1116,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 20,
                    height: 29,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF411616),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFFF0909),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 1164,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 20,
                    height: 29,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF411616),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFFF0909),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // Card layanan darurat (SAPA 129, Into The Light, dll)
              Positioned(
                left: 15,
                top: 740,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 172,
                    height: 113,
                    decoration: ShapeDecoration(
                      color: const Color(0x66F30DB6),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFF30DB6),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 263,
                top: 797,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 73,
                    height: 19,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF1FFF1F),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF1FFF1F),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 64,
                top: 797,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 73,
                    height: 19,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFF52A1),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFFF52A1),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 263,
                top: 675,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 73,
                    height: 19,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF14379A),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF241E7E),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 214,
                top: 740,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 172,
                    height: 113,
                    decoration: ShapeDecoration(
                      color: const Color(0x7F2BFF1E),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF00FF2A),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 214,
                top: 612,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 172,
                    height: 113,
                    decoration: ShapeDecoration(
                      color: const Color(0x4C450AF6),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF0061FF),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              // Label teks layanan
              Positioned(
                left: 64,
                top: 779,
                child: const SizedBox(
                  width: 73,
                  height: 11,
                  child: Text(
                    'Into The Light',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 263,
                top: 655,
                child: const SizedBox(
                  width: 73,
                  height: 11,
                  child: Text(
                    'Polisi 110',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 257,
                top: 780,
                child: const SizedBox(
                  width: 84,
                  height: 11,
                  child: Text(
                    'Ambulance 118',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 82,
                top: 797,
                child: const SizedBox(
                  width: 39,
                  height: 19,
                  child: Text(
                    '189',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 280,
                top: 675,
                child: const SizedBox(
                  width: 39,
                  height: 19,
                  child: Text(
                    '110',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 818,
                child: const SizedBox(
                  width: 89,
                  height: 11,
                  child: Text(
                    'Krisis Mental 24 jam',
                    style: TextStyle(
                      color: Color(0xFF919191),
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 259,
                top: 820,
                child: const SizedBox(
                  width: 87,
                  height: 11,
                  child: Text(
                    'Unit Gawat Darurat',
                    style: TextStyle(
                      color: Color(0xFF919191),
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 280,
                top: 797,
                child: const SizedBox(
                  width: 39,
                  height: 19,
                  child: Text(
                    '118',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 271,
                top: 698,
                child: const SizedBox(
                  width: 118,
                  height: 27,
                  child: Text(
                    'Layanan Darurat',
                    style: TextStyle(
                      color: Color(0xFF919191),
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Icon di card polisi
              Positioned(
                left: 286,
                top: 626,
                child: Container(
                  width: 28,
                  height: 28,
                  color: const Color(0xFF2D0C53),
                ),
              ),
              // Judul Panduan Keselamatan
              Positioned(
                left: 15,
                top: 882,
                child: const SizedBox(
                  width: 203,
                  height: 18,
                  child: Text(
                    'Panduan Keselamatan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // Teks panduan 1-6
              Positioned(
                left: 50,
                top: 925,
                child: const SizedBox(
                  width: 201,
                  height: 18,
                  child: Text(
                    'Pergi ke tempat ramai',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 976,
                child: const SizedBox(
                  width: 291,
                  height: 18,
                  child: Text(
                    'Hubungi orang yang anda percaya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 1024,
                child: const SizedBox(
                  width: 291,
                  height: 18,
                  child: Text(
                    'Kunci pintu dan jendela',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 47,
                top: 1073,
                child: const SizedBox(
                  width: 349,
                  height: 18,
                  child: Text(
                    'Jangan kembali sendiran ke tempat berbahaya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 47,
                top: 1122,
                child: SizedBox(
                  width: 291,
                  height: 18,
                  child: Text.rich(
                    const TextSpan(
                      children: [
                        TextSpan(
                          text: 'S',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: 'impan bukti (foto rekaman)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 1170,
                child: const SizedBox(
                  width: 291,
                  height: 18,
                  child: Text(
                    'Jika darurat hubungi pihak Berwajib',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Angka panduan
              Positioned(
                left: 10,
                top: 925,
                child: const SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '     1',
                    style: TextStyle(
                      color: Color(0xFFFF0C0C),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 976,
                child: const SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '     2',
                    style: TextStyle(
                      color: Color(0xFFFF0C0C),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 1024,
                child: const SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '     3',
                    style: TextStyle(
                      color: Color(0xFFFF0C0C),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 1073,
                child: const SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '     4',
                    style: TextStyle(
                      color: Color(0xFFFF0C0C),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 1122,
                child: const SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '     5',
                    style: TextStyle(
                      color: Color(0xFFFF0C0C),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 1170,
                child: const SizedBox(
                  width: 43,
                  height: 18,
                  child: Text(
                    '     6',
                    style: TextStyle(
                      color: Color(0xFFFF0C0C),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // SAPA 129 card (bagian dari layanan)
              Positioned(
                left: 85,
                top: 626,
                child: SizedBox(
                  width: 27,
                  height: 27,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 27,
                          height: 27,
                        ),
                      ),
                      Positioned(
                        left: -70,
                        top: -14,
                        child: Container(
                          width: 172,
                          height: 113,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 172,
                                  height: 113,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 49,
                                        top: 62,
                                        child: Opacity(
                                          opacity: 0.50,
                                          child: Container(
                                            width: 73,
                                            height: 19,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFF0202),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFFF0909),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Opacity(
                                          opacity: 0.50,
                                          child: Container(
                                            width: 172,
                                            height: 113,
                                            decoration: ShapeDecoration(
                                              color: const Color(0x66CB0A41),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFFF034B),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 49,
                                        top: 41,
                                        child: const SizedBox(
                                          width: 73,
                                          height: 11,
                                          child: Text(
                                            'SAPA 129',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 66,
                                        top: 62,
                                        child: const SizedBox(
                                          width: 39,
                                          height: 19,
                                          child: Text(
                                            '129',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 35,
                                        top: 85,
                                        child: const SizedBox(
                                          width: 101,
                                          height: 11,
                                          child: Text(
                                            'Hotline Nasional 24 jam',
                                            style: TextStyle(
                                              color: Color(0xFF919191),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Header "Rekam Bukti"
              Positioned(
                left: 19,
                top: 49,
                child: SizedBox(
                  width: 152,
                  height: 20,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 31,
                        top: 0,
                        child: const SizedBox(
                          width: 121,
                          height: 20,
                          child: Text(
                            'Rekam Bukti',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 15,
                        child: Transform.rotate(
                          angle: 3.14,
                          child: Container(
                            width: 19,
                            height: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Tombol buka kamera & galeri
              Positioned(
                left: 27,
                top: 226,
                child: Container(
                  width: 168,
                  height: 52,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF401515),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF4F0970),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 53,
                top: 240,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 245,
                child: const SizedBox(
                  width: 60,
                  height: 14,
                  child: Text(
                    'Buka kamera',
                    style: TextStyle(
                      color: Color(0xFFDF0D0D),
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 245,
                top: 237,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 271,
                top: 247,
                child: const SizedBox(
                  width: 49,
                  height: 14,
                  child: Text(
                    'Dari galeri',
                    style: TextStyle(
                      color: Color(0xFF8B85A6),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
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
