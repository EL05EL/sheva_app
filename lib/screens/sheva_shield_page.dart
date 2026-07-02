import 'package:flutter/material.dart';

class ShevaShieldPage extends StatelessWidget {
  const ShevaShieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      appBar: AppBar(
        title:
            const Text('SHEVA Shield', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rekam Bukti
            const Text(
              'Rekam Bukti',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            // Tombol Kamera & Galeri
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF401515),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xFF4F0970)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Buka kamera',
                        style: TextStyle(
                          color: Color(0xFFDF0D0D),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF240D2F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Dari galeri',
                        style: TextStyle(
                          color: Color(0xFF8B85A6),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Preview Foto
            Container(
              width: double.infinity,
              height: 120,
              decoration: ShapeDecoration(
                color: const Color(0xFF240D2F),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF2A283E)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Center(
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
            const SizedBox(height: 20),
            // Lokasi
            const Text(
              'Lokasi Kejadian',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: ShapeDecoration(
                color: const Color(0x267A2062),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF7A2062)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFFF30DB6), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Deteksi Lokasi Otomatis',
                    style: TextStyle(
                      color: Color(0xFFF30DB6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: ShapeDecoration(
                color: const Color(0x26DAD3D8),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF290D36)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const TextField(
                style: TextStyle(color: Color(0xFFF6F3F7), fontSize: 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'atau ketik lokasi manual.....',
                  hintStyle: TextStyle(color: Color(0xFFF6F3F7), fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Deskripsi
            const Text(
              'Deskripsi Kejadian',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 150,
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
                style: TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ceritakan kejadian secara detail...',
                  hintStyle: TextStyle(color: Color(0xFF919191), fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Layanan Darurat
            const Text(
              'Layanan Darurat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildEmergencyCard(
                    'SAPA 129', 'Hotline Nasional 24 jam', '129'),
                _buildEmergencyCard('Polisi 110', 'Layanan Darurat', '110'),
                _buildEmergencyCard(
                    'Ambulance 118', 'Unit Gawat Darurat', '118'),
                _buildEmergencyCard(
                    'Into The Light', 'Krisis Mental 24 jam', '189'),
              ],
            ),
            const SizedBox(height: 24),
            // Panduan Keselamatan
            const Text(
              'Panduan Keselamatan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _buildSafetyGuide('1', 'Pergi ke tempat ramai'),
            _buildSafetyGuide('2', 'Hubungi orang yang anda percaya'),
            _buildSafetyGuide('3', 'Kunci pintu dan jendela'),
            _buildSafetyGuide(
                '4', 'Jangan kembali sendirian ke tempat berbahaya'),
            _buildSafetyGuide('5', 'Simpan bukti (foto rekaman)'),
            _buildSafetyGuide('6', 'Jika darurat hubungi pihak Berwajib'),
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

  Widget _buildEmergencyCard(String title, String subtitle, String number) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0x4C450AF6),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF0061FF)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF919191),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyGuide(String number, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF2A283E))),
      ),
      child: Row(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFFFF0C0C),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
