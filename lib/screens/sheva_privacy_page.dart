import 'package:flutter/material.dart';

class ShevaPrivacyPage extends StatefulWidget {
  const ShevaPrivacyPage({super.key});

  @override
  State<ShevaPrivacyPage> createState() => _ShevaPrivacyPageState();
}

class _ShevaPrivacyPageState extends State<ShevaPrivacyPage> {
  // Daftar topik kebijakan privasi
  final List<PrivacyTopic> _topics = [
    PrivacyTopic(
      id: 1,
      title: 'Data yang Dikumpulkan',
      icon: Icons.data_usage,
      content: '''
SHEVA hanya menyimpan data yang Anda masukkan secara langsung di perangkat Anda, yaitu:

• Nama panggilan dan identitas gender (opsional)
• Riwayat modul yang telah diselesaikan
• Preferensi tampilan aplikasi

Semua data ini tersimpan secara lokal di perangkat Anda menggunakan SharedPreferences, dan tidak dikirimkan ke server eksternal mana pun.
''',
    ),
    PrivacyTopic(
      id: 2,
      title: 'Penyimpanan & Keamanan',
      icon: Icons.security,
      content: '''
SHEVA menerapkan standar keamanan berikut:

• Data disimpan secara lokal di perangkat dengan enkripsi sistem operasional.
• Laporan darurat diproses secara lokal dan tidak dikirim ke cloud.
• Lokasi GPS hanya diakses saat Anda secara aktif membuka fitur SHEVA Map.
• Akses kamera hanya diaktifkan ketika Anda menekan tombol "Buka Kamera".
• Tidak ada pelacakan aktivitas, analitik, atau iklan tertarget.

Kami tidak menjual, menyewakan, atau membagikan data Anda kepada pihak ketiga.
''',
    ),
    PrivacyTopic(
      id: 3,
      title: 'Izin Perangkat',
      icon: Icons.devices,
      content: '''
SHEVA meminta izin berikut hanya saat dibutuhkan:

• Kamera — untuk merekam bukti di SHEVA Shield.
• Galeri/Media — untuk memilih foto dari galeri.
• Lokasi — untuk deteksi otomatis lokasi kejadian.
• Notifikasi — untuk pengingat harian (jika diaktifkan).

Anda dapat mencabut izin kapan saja melalui Pengaturan perangkat Anda. Pencabutan izin tidak akan mempengaruhi fitur inti SHEVA.
''',
    ),
    PrivacyTopic(
      id: 4,
      title: 'Hak Pengguna',
      icon: Icons.gavel,
      content: '''
Sebagai pengguna SHEVA, Anda memiliki hak penuh atas data Anda:

• Hak Akses — Anda dapat melihat semua data tersimpan di tab Profil.
• Hak Hapus — Gunakan tombol "Hapus Semua Data" di Pengaturan untuk menghapus seluruh data.
• Hak Portabilitas — Data Anda tersimpan di perangkat dan dapat Anda kendalikan sepenuhnya.
• Hak Koreksi — Ubah nama dan preferensi kapan saja di tab Profil.

Karena tidak ada server yang menyimpan data Anda, privasi Anda terlindungi secara inheren.
''',
    ),
    PrivacyTopic(
      id: 5,
      title: 'Mode Offline',
      icon: Icons.wifi_off,
      content: '''
SHEVA dirancang untuk berfungsi penuh tanpa koneksi internet:

• Semua konten edukatif tersedia offline.
• Fitur laporan, Shield, dan komunitas berjalan offline.
• Data statistik dikompilasi dari sumber tepercaya dan tersedia secara lokal.
• Peta layanan tersedia offline dengan nomor telepon yang bisa langsung dihubungi.

Koneksi internet hanya diperlukan untuk fitur yang secara eksplisit mengaksesnya (misalnya, panggilan telepon darurat).
''',
    ),
    PrivacyTopic(
      id: 6,
      title: 'Pengguna Anak-anak',
      icon: Icons.family_restroom,
      content: '''
SHEVA dirancang untuk pengguna berusia 13 tahun ke atas. Aplikasi ini membahas topik yang berkaitan dengan kekerasan berbasis gender, yang dapat sensitif bagi anak-anak yang lebih muda.

Kami mendorong orang tua dan wali untuk mendampingi anak-anak yang menggunakan SHEVA agar dapat memberikan konteks yang tepat untuk materi edukatif yang tersedia.
''',
    ),
    PrivacyTopic(
      id: 7,
      title: 'Hubungi Kami',
      icon: Icons.contact_support,
      content: '''
Jika Anda memiliki pertanyaan atau kekhawatiran tentang kebijakan privasi ini, silakan hubungi:

• Email: shevahub24@gmail.com
• SAPA 129 – untuk bantuan dan darurat terkait KBG
• Komnas Perempuan: (021) 3903963

Kebijakan ini terakhir diperbarui pada 17 Juni 2026 dan berlaku untuk SHEVA versi 1.0 ke atas.
''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17071F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Privacy by Design
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF1A1732),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xFF3F2A60),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: const Icon(
                      Icons.privacy_tip,
                      color: Color(0xFF9B89EC),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'SHEVA dibangun dengan prinsip ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'privacy by design',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                '. Semua data tersimpan di perangkat Anda - kami tidak memiliki akses ke informasi pribadi Anda.',
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Daftar topik kebijakan privasi
            const Text(
              'Daftar Kebijakan Privasi',
              style: TextStyle(
                color: Color(0xFFDAC4EB),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _topics.length,
              itemBuilder: (context, index) {
                final topic = _topics[index];
                return _buildTopicCard(topic);
              },
            ),
            const SizedBox(height: 16),
            // Footer
            const Center(
              child: Text(
                '"For She, For He, For All."',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tombol SOS
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/shield');
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const ShapeDecoration(
                      color: Color(0x7FFF0C0C),
                      shape: OvalBorder(
                        side: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    child: const Icon(
                      Icons.sos,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(PrivacyTopic topic) {
    return GestureDetector(
      onTap: () {
        _navigateToTopicDetail(topic);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: const Color(0xFF1A1732),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0x7F744AC1)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(),
              child: Icon(
                topic.icon,
                color: const Color(0xFF9B89EC),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                topic.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTopicDetail(PrivacyTopic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrivacyTopicDetailPage(topic: topic),
      ),
    );
  }
}

// Model PrivacyTopic
class PrivacyTopic {
  final int id;
  final String title;
  final IconData icon;
  final String content;

  PrivacyTopic({
    required this.id,
    required this.title,
    required this.icon,
    required this.content,
  });
}

// Halaman Detail Topik Kebijakan Privasi
class PrivacyTopicDetailPage extends StatelessWidget {
  final PrivacyTopic topic;

  const PrivacyTopicDetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17071F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          topic.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  topic.icon,
                  color: const Color(0xFF9B89EC),
                  size: 32,
                ),
                const SizedBox(width: 16),
                Text(
                  topic.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF1A1732),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0x7F744AC1)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                topic.content,
                style: const TextStyle(
                  color: Color(0xFFDAC4EB),
                  fontSize: 14,
                  height: 1.8,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                '"For She, For He, For All."',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
