import 'package:flutter/material.dart';

class ShevaReportPage extends StatelessWidget {
  const ShevaReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      appBar: AppBar(
        backgroundColor: const Color(0xFF48336F),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SHEVA Report',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sos, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/shield'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: const Color(0xFF240D2F),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF2A283E)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Semua laporan bersifat rahasia dan dienkripsi. Data anda tidak akan dibagikan tanpa persetujuan anda. Anda bisa memilih untuk melapor secara anonim.',
                style: TextStyle(
                  color: Color(0xFF919191),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Jenis Laporan
            const Text(
              'Jenis Laporan*',
              style: TextStyle(
                color: Color(0xFFE5CFF6),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildReportTypeChip('KBG Fisik'),
                _buildReportTypeChip('KBG Seksual'),
                _buildReportTypeChip('KBG Psikologis'),
                _buildReportTypeChip('KBG Online'),
                _buildReportTypeChip('Diskriminasi'),
                _buildReportTypeChip('Perkawinan Anak'),
              ],
            ),
            const SizedBox(height: 20),
            // Lokasi
            const Text(
              'Lokasi Kejadian*',
              style: TextStyle(
                color: Color(0xFFE5CFF6),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Deskripsi
            const Text(
              'Deskripsi Kejadian*',
              style: TextStyle(
                color: Color(0xFFE5CFF6),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 120,
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: const Color(0xFF240D2F),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF2A283E)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const TextField(
                maxLines: null,
                expands: true,
                style: TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      'Ceritakan apa yang terjadi. Anda tidak perlu menyertakan detail yang membuat Anda tidak nyaman...',
                  hintStyle: TextStyle(color: Color(0xFF919191), fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('0 Karakter',
                  style: TextStyle(color: Color(0xFFC4C5C8), fontSize: 10)),
            ),
            const SizedBox(height: 20),
            // Laporan Anonim
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Laporan Anonim\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: 'Nama anda tidak akan dicantumkan',
                        style:
                            TextStyle(color: Color(0xFF837F98), fontSize: 10)),
                  ],
                ),
              ),
            ),
            const Divider(color: Color(0xFF2A283E)),
            const SizedBox(height: 8),
            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 53,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Laporan Anda telah terkirim secara anonim!'),
                      backgroundColor: Color(0xFF493370),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF270F32),
                  foregroundColor: const Color(0xFFF5F6FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFF2A283E)),
                  ),
                  elevation: 4,
                ),
                child: const Text('Kirim Laporan',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
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
    );
  }

  Widget _buildReportTypeChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFF240D2F),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF2A283E)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFDAC4EB),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLocationChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
