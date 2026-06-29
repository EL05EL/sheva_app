import 'package:flutter/material.dart';

class ShevaReportPage extends StatelessWidget {
  const ShevaReportPage({super.key});

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
              // Header background
              Positioned(
                left: 0,
                top: -4,
                child: Container(
                  width: 402,
                  height: 76,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF48336F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              // Tombol Kembali (yang sudah diperbaiki)
              Positioned(
                left: 16,
                top: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              // Judul SHEVA Report
              Positioned(
                left: 54,
                top: 20,
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'SHEVA Report\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Laporan aman & terenkripsi',
                        style: TextStyle(
                          color: Color(0xFFDAC4EB),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Kotak info "Semua laporan bersifat rahasia..."
              Positioned(
                left: 15,
                top: 86,
                child: Container(
                  width: 369,
                  height: 78,
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
                left: 32,
                top: 102,
                child: const Text(
                  'Semua laporan bersifat rahasia dan dienskripsi. Data anda \ntidak akan di bagikan tanpa persetujuan anda. Anda bisa \nmemilih untuk melapor secara anonim. ',
                  style: TextStyle(
                    color: Color(0xFF919191),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Label "Jenis Laporan*"
              Positioned(
                left: 17,
                top: 173,
                child: const Text(
                  'Jenis Laporan*',
                  style: TextStyle(
                    color: Color(0xFFE5CFF6),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Jenis Laporan buttons (baris 1)
              Positioned(
                left: 17,
                top: 197,
                child: Container(
                  width: 174,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 212,
                top: 198,
                child: Container(
                  width: 174,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 61,
                top: 205,
                child: const Text(
                  'KBG Fisik',
                  style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 248,
                top: 206,
                child: const Text(
                  'KBG Seksual',
                  style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Jenis Laporan buttons (baris 2)
              Positioned(
                left: 17,
                top: 243,
                child: Container(
                  width: 174,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 212,
                top: 244,
                child: Container(
                  width: 174,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 61,
                top: 251,
                child: const Text(
                  'KBG Psikologis',
                  style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 248,
                top: 251,
                child: const Text(
                  'KBG Online',
                  style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Jenis Laporan buttons (baris 3)
              Positioned(
                left: 17,
                top: 289,
                child: Container(
                  width: 174,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 212,
                top: 290,
                child: Container(
                  width: 174,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF240D2F),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF2A283E),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 298,
                child: const Text(
                  'Diskriminasi',
                  style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 248,
                top: 297,
                child: const Text(
                  'Perkawinan Anak',
                  style: TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Lokasi (scrollable horizontal)
              Positioned(
                left: 0,
                top: 363,
                child: Container(
                  width: 400,
                  height: 57,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(color: Color(0xFF290D36)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        _buildLocationChip('Rumah / Keluarga'),
                        const SizedBox(width: 8),
                        _buildLocationChip('Tempat Kerja'),
                        const SizedBox(width: 8),
                        _buildLocationChip('Sekolah / Kampus'),
                        const SizedBox(width: 8),
                        _buildLocationChip('Ruang Publik'),
                        const SizedBox(width: 8),
                        _buildLocationChip('Media Sosial / Internet'),
                        const SizedBox(width: 8),
                        _buildLocationChip('Lingkungan Masyarakat'),
                        const SizedBox(width: 8),
                        _buildLocationChip('Lainnya'),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
              ),
              // Label Deskripsi
              Positioned(
                left: 16,
                top: 433,
                child: const Text(
                  'Deskripsi Kejadian*',
                  style: TextStyle(
                    color: Color(0xFFE5CFF6),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Kotak Deskripsi
              Positioned(
                left: 16,
                top: 458,
                child: Container(
                  width: 369,
                  height: 87,
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
                left: 28,
                top: 475,
                child: const SizedBox(
                  width: 350,
                  height: 36,
                  child: Text(
                    'Ceritakan apa yang terjadi. Anda tidak perlu\nmenyertakan detail yang membuat Anda tidak nyaman...',
                    style: TextStyle(
                      color: Color(0xFF919191),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 336,
                top: 548,
                child: const Text(
                  '0 Karakter',
                  style: TextStyle(
                    color: Color(0xFFC4C5C8),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              // Garis pemisah Laporan Anonim
              Positioned(
                left: 17,
                top: 703,
                child: Container(
                  width: 368,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF2A283E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 745,
                child: Container(
                  width: 368,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF2A283E),
                      ),
                    ),
                  ),
                ),
              ),
              // Laporan Anonim
              Positioned(
                left: 48,
                top: 709,
                child: const SizedBox(
                  width: 180,
                  height: 33,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Laporan Anonim\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Nama anda tidak akan di cantumkan',
                          style: TextStyle(
                            color: Color(0xFF837F98),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Tombol Kirim Laporan
              Positioned(
                left: 15,
                top: 777,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Laporan Anda telah terkirim secara anonim!'),
                        backgroundColor: Color(0xFF493370),
                      ),
                    );
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
                        'Kirim Laporan',
                        style: TextStyle(
                          color: Color(0xFFF5F6FB),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Footer
              Positioned(
                left: 39,
                top: 844,
                child: const Text(
                  'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                  style: TextStyle(
                    color: Color(0xFF919191),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: const Color(0x7F744AC1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
