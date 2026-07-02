import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../widgets/sos_button.dart';

class ShevaPrivacyPage extends StatelessWidget {
  const ShevaPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Kebijakan Privasi',
          style: AppTheme.h2Medium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: ShapeDecoration(
                color: AppTheme.surfaceCard,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Color(0xFF3F2A60)),
                  borderRadius: BorderRadius.circular(AppTheme.spacingLg),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.privacy_tip,
                      color: AppTheme.secondary, size: AppTheme.iconLarge),
                  const SizedBox(width: AppTheme.spacingSm),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'SHEVA dibangun dengan prinsip ',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          TextSpan(
                            text: 'privacy by design',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                '. Semua data tersimpan di perangkat Anda - kami tidak memiliki akses ke informasi pribadi Anda.',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            // Menu
            _buildMenuItem(
              context,
              icon: Icons.data_usage,
              title: 'Data yang Dikumpulkan',
              subtitle: 'Informasi yang disimpan di perangkat Anda',
              content: '''
SHEVA hanya menyimpan data yang Anda masukkan secara langsung di perangkat Anda, yaitu:

• Nama panggilan dan identitas gender (opsional)
• Riwayat modul yang telah diselesaikan
• Preferensi tampilan aplikasi

Semua data ini tersimpan secara lokal di perangkat Anda menggunakan SharedPreferences, dan tidak dikirimkan ke server eksternal mana pun.
''',
            ),
            _buildMenuItem(
              context,
              icon: Icons.security,
              title: 'Penyimpanan & Keamanan',
              subtitle: 'Standar keamanan yang kami terapkan',
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
            _buildMenuItem(
              context,
              icon: Icons.devices,
              title: 'Izin Perangkat',
              subtitle: 'Izin yang diminta dan cara mencabutnya',
              content: '''
SHEVA meminta izin berikut hanya saat dibutuhkan:

• Kamera — untuk merekam bukti di SHEVA Shield.
• Galeri/Media — untuk memilih foto dari galeri.
• Lokasi — untuk deteksi otomatis lokasi kejadian.
• Notifikasi — untuk pengingat harian (jika diaktifkan).

Anda dapat mencabut izin kapan saja melalui Pengaturan perangkat Anda. Pencabutan izin tidak akan mempengaruhi fitur inti SHEVA.
''',
            ),
            _buildMenuItem(
              context,
              icon: Icons.people,
              title: 'Hak Pengguna',
              subtitle: 'Hak Anda atas data pribadi',
              content: '''
Sebagai pengguna SHEVA, Anda memiliki hak penuh atas data Anda:

• Hak Akses — Anda dapat melihat semua data tersimpan di tab Profil.
• Hak Hapus — Gunakan tombol "Hapus Semua Data" di Pengaturan untuk menghapus seluruh data.
• Hak Portabilitas — Data Anda tersimpan di perangkat dan dapat Anda kendalikan sepenuhnya.
• Hak Koreksi — Ubah nama dan preferensi kapan saja di tab Profil.

Karena tidak ada server yang menyimpan data Anda, privasi Anda terlindungi secara inheren.
''',
            ),
            _buildMenuItem(
              context,
              icon: Icons.wifi_off,
              title: 'Mode Offline',
              subtitle: 'Aplikasi berfungsi tanpa internet',
              content: '''
SHEVA dirancang untuk berfungsi penuh tanpa koneksi internet:

• Semua konten edukatif tersedia offline.
• Fitur laporan, Shield, dan komunitas berjalan offline.
• Data statistik dikompilasi dari sumber terpercaya dan tersedia secara lokal.
• Peta layanan tersedia offline dengan nomor telepon yang bisa langsung dihubungi.

Koneksi internet hanya diperlukan untuk fitur yang secara eksplisit mengaksesnya.
''',
            ),
            _buildMenuItem(
              context,
              icon: Icons.child_care,
              title: 'Pengguna Anak-anak',
              subtitle: 'Kebijakan untuk pengguna di bawah 13 tahun',
              content: '''
SHEVA dirancang untuk pengguna berusia 13 tahun ke atas. Aplikasi ini membahas topik yang berkaitan dengan kekerasan berbasis gender, yang dapat sensitif bagi anak-anak yang lebih muda.

Kami mendorong orang tua dan wali untuk mendampingi anak-anak yang menggunakan SHEVA agar dapat memberikan konteks yang tepat untuk materi edukatif yang tersedia.
''',
            ),
            _buildMenuItem(
              context,
              icon: Icons.contact_mail,
              title: 'Hubungi Kami',
              subtitle: 'Pertanyaan atau kekhawatiran?',
              content: '''
Jika Anda memiliki pertanyaan atau kekhawatiran tentang kebijakan privasi ini, silakan hubungi:

• Email: shevahub24@gmail.com
• SAPA 129 – untuk bantuan dan darurat terkait KBG
• Komnas Perempuan: (021) 3903963

Kebijakan ini terakhir diperbarui pada 17 Juni 2026 dan berlaku untuk SHEVA versi 1.0 ke atas.
''',
            ),
            const SizedBox(height: AppTheme.spacingMd),
            const Center(
              child: Text(
                '"For She, For He, For All."',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            const Center(
              child: Text(
                'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                style: AppTheme.tiny,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: InkWell(
        onTap: () => _showDetailDialog(context, title, content),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        splashColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.05),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMd,
            vertical: AppTheme.spacingSm,
          ),
          decoration: ShapeDecoration(
            color: AppTheme.surfaceCard,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppTheme.borderLight),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.secondary, size: AppTheme.iconLarge),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    Text(subtitle,
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: Colors.white, size: AppTheme.iconMain),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: content.split('\n').map((line) {
              if (line.trim().isEmpty)
                return const SizedBox(height: AppTheme.spacingXs);
              if (line.trim().startsWith('•')) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: AppTheme.spacingXs, bottom: AppTheme.spacingXxs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ',
                          style: TextStyle(
                              color: AppTheme.secondary, fontSize: 14)),
                      Expanded(
                        child: Text(
                          line.trim().substring(1).trim(),
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacingXxs),
                child: Text(
                  line.trim(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
          ),
        ),
        backgroundColor: AppTheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          side: const BorderSide(color: AppTheme.borderDefault),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup',
                style: TextStyle(color: AppTheme.textMuted)),
          ),
        ],
      ),
    );
  }
}
