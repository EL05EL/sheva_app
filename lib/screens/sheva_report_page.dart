import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../widgets/sos_button.dart';
import '../widgets/hotline_tile.dart';

class ShevaReportPage extends StatefulWidget {
  const ShevaReportPage({super.key});

  @override
  State<ShevaReportPage> createState() => _ShevaReportPageState();
}

class _ShevaReportPageState extends State<ShevaReportPage> {
  String? _selectedReportType;
  String? _selectedLocation;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isAnonym = true;
  bool _isLoading = false;

  final List<String> _reportTypes = [
    'KBG Fisik',
    'KBG Psikologis',
    'KBG Seksual',
    'KBG Online',
    'Diskriminasi',
    'Perkawinan Anak',
  ];

  final List<String> _locations = [
    'Rumah / Keluarga',
    'Tempat Kerja',
    'Sekolah / Kampus',
    'Ruang Publik',
    'Media Sosial / Internet',
    'Lingkungan Masyarakat',
    'Lainnya',
  ];

  // 🔥 TAMBAHKAN CS Fadil di daftar hotline
  final List<Hotline> _hotlines = [
    Hotline(
      name: 'SAPA 129',
      phone: '129',
      description: 'Hotline Nasional 24 jam untuk korban kekerasan',
    ),
    Hotline(
      name: 'Komnas Perempuan',
      phone: '08123456787',
      description: 'Komisi Nasional Anti Kekerasan terhadap Perempuan',
    ),
    Hotline(
      name: 'LBH APIK',
      phone: '08123456786',
      description: 'Lembaga Bantuan Hukum untuk perempuan',
    ),
    Hotline(
      name: 'Yayasan Pulih',
      phone: '08123456785',
      description: 'Layanan konseling dan pemulihan trauma',
    ),
    // 🔥 TAMBAHAN: CS SHEVA - Fadil
    Hotline(
      name: 'CS SHEVA - Fadil',
      phone: '081243265263',
      description: 'Customer Service SHEVA (24 jam)',
    ),
  ];

  Future<void> _sendReportToWhatsApp(Hotline hotline) async {
    if (_selectedReportType == null) {
      _showSnackBar('Silakan pilih jenis laporan terlebih dahulu.');
      return;
    }

    if (_isLoading) return;
    setState(() => _isLoading = true);

    final message = '''
📋 LAPORAN SHEVA REPORT

📅 Tanggal: ${DateTime.now().toString().split(' ')[0]}
🕐 Waktu: ${DateTime.now().toString().split(' ')[1].substring(0, 5)}

📌 Jenis Laporan: $_selectedReportType
📍 Lokasi: ${_selectedLocation ?? 'Tidak disebutkan'}
📝 Deskripsi Kejadian:
${_descriptionController.text.isEmpty ? '(Tidak ada deskripsi)' : _descriptionController.text}

🔒 Laporan Anonim: ${_isAnonym ? 'Ya' : 'Tidak'}

---
Dikirim dari aplikasi SHEVA
Solidarity Hub for Equality, Voice, and Action
For She, For He, For All.
''';

    String cleanPhone = hotline.phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (cleanPhone.startsWith('0')) {
      cleanPhone = '62${cleanPhone.substring(1)}';
    }

    final encodedMessage = Uri.encodeComponent(message);
    final url = 'https://wa.me/$cleanPhone?text=$encodedMessage';
    final uri = Uri.parse(url);

    setState(() => _isLoading = false);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar('Tidak dapat membuka WhatsApp.');
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryLight,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SHEVA Report',
          style: AppTheme.h2Medium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              decoration: AppTheme.cardDecoration(),
              child: const Text(
                'Semua laporan bersifat rahasia dan dienkripsi. Data anda tidak akan dibagikan tanpa persetujuan anda. Anda bisa memilih untuk melapor secara anonim.',
                style: AppTheme.label,
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            // Jenis Laporan
            const Text(
              'Jenis Laporan*',
              style: TextStyle(
                color: AppTheme.textPurpleLight,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Wrap(
              spacing: AppTheme.spacingXs,
              runSpacing: AppTheme.spacingXs,
              children: _reportTypes.map((type) {
                final isSelected = _selectedReportType == type;
                return InkWell(
                  onTap: () => setState(() => _selectedReportType = type),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  splashColor: Colors.white.withOpacity(0.1),
                  highlightColor: Colors.white.withOpacity(0.05),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingXs,
                    ),
                    decoration: ShapeDecoration(
                      color:
                          isSelected ? AppTheme.surfaceCard2 : AppTheme.surface,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isSelected
                              ? AppTheme.secondary
                              : AppTheme.borderDefault,
                        ),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : AppTheme.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            // Lokasi
            const Text(
              'Lokasi Kejadian',
              style: TextStyle(
                color: AppTheme.textPurpleLight,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _locations.map((location) {
                  final isSelected = _selectedLocation == location;
                  return Padding(
                    padding: const EdgeInsets.only(right: AppTheme.spacingXs),
                    child: InkWell(
                      onTap: () => setState(() => _selectedLocation = location),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      splashColor: Colors.white.withOpacity(0.1),
                      highlightColor: Colors.white.withOpacity(0.05),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingSm,
                          vertical: AppTheme.spacingXs,
                        ),
                        decoration: ShapeDecoration(
                          color:
                              isSelected ? AppTheme.chipBg : AppTheme.surface,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isSelected
                                  ? AppTheme.secondary
                                  : AppTheme.borderDefault,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusMd),
                          ),
                        ),
                        child: Text(
                          location,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppTheme.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            // Deskripsi
            const Text(
              'Deskripsi Kejadian*',
              style: TextStyle(
                color: AppTheme.textPurpleLight,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Container(
              height: 120,
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              decoration: AppTheme.cardDecoration(),
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                expands: true,
                style: AppTheme.body,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      'Ceritakan apa yang terjadi. Anda tidak perlu menyertakan detail yang membuat Anda tidak nyaman...',
                  hintStyle: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_descriptionController.text.length} Karakter',
                style: const TextStyle(
                  color: Color(0xFFC4C5C8),
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            // Laporan Anonim
            Row(
              children: [
                Switch(
                  value: _isAnonym,
                  onChanged: (value) => setState(() => _isAnonym = value),
                  activeColor: AppTheme.secondary,
                  activeTrackColor: AppTheme.surfaceCard2,
                ),
                const SizedBox(width: AppTheme.spacingXs),
                const Expanded(
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
                          text: 'Nama anda tidak akan dicantumkan',
                          style: TextStyle(
                            color: AppTheme.textPurpleMuted,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: AppTheme.borderDefault),
            const SizedBox(height: AppTheme.spacingXs),
            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 53,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_selectedReportType == null) {
                          _showSnackBar(
                              'Silakan pilih jenis laporan terlebih dahulu.');
                          return;
                        }
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: AppTheme.background,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(AppTheme.spacingLg)),
                          ),
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(AppTheme.spacingLg),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Kirim Laporan ke:',
                                  style: AppTheme.h2,
                                ),
                                const SizedBox(height: AppTheme.spacingMd),
                                ..._hotlines.map((hotline) => Column(
                                      children: [
                                        HotlineTile(
                                          name: hotline.name,
                                          phone: hotline.phone,
                                          description: hotline.description,
                                          onTap: () {
                                            Navigator.pop(context);
                                            _sendReportToWhatsApp(hotline);
                                          },
                                        ),
                                        const Divider(
                                            color: AppTheme.borderDefault),
                                      ],
                                    )),
                                const SizedBox(height: AppTheme.spacingXs),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Batal',
                                      style: AppTheme.captionMuted),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.surfaceCardDark,
                  foregroundColor: const Color(0xFFF5F6FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    side: const BorderSide(color: AppTheme.borderDefault),
                  ),
                  elevation: AppTheme.elevationMedium,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Kirim Laporan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
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
}

class Hotline {
  final String name;
  final String phone;
  final String description;

  Hotline({
    required this.name,
    required this.phone,
    required this.description,
  });
}
