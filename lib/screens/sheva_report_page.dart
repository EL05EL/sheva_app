import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/supabase_service.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';
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

  // ============================================================
  // 🔥 HOTLINE DENGAN NOMOR WHATSAPP ASLI (SUDAH DIVERIFIKASI)
  // ============================================================
  final List<Hotline> _hotlines = [
    Hotline(
      name: 'SAPA 129',
      phone: '129',
      whatsapp: '08111129129',
      description: 'Hotline Nasional 24 jam KemenPPPA',
    ),
    Hotline(
      name: 'Komnas Perempuan',
      phone: '0213903963',
      whatsapp: '08179323375',
      description: 'Komisi Nasional Anti Kekerasan terhadap Perempuan',
    ),
    Hotline(
      name: 'LBH APIK',
      phone: '02187797289',
      whatsapp: '08138882669',
      description: 'Lembaga Bantuan Hukum untuk perempuan',
    ),
    Hotline(
      name: 'Yayasan Pulih',
      phone: '02178842580',
      whatsapp: '08118436633',
      description: 'Konseling psikologis & pemulihan trauma',
    ),
    Hotline(
      name: 'SEJIWA',
      phone: '119',
      whatsapp: '081380073120',
      description: 'Layanan kesehatan jiwa & pencegahan bunuh diri',
    ),
  ];

  final SupabaseService _supabase = SupabaseService();

  // ============================================================
  // FUNGSI KIRIM KE WHATSAPP
  // ============================================================
  Future<void> _sendToWhatsApp(String phone, String message) async {
    try {
      String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
      if (cleanPhone.startsWith('0')) {
        cleanPhone = '62${cleanPhone.substring(1)}';
      }
      final url =
          'https://wa.me/$cleanPhone?text=${Uri.encodeComponent(message)}';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar('Tidak dapat membuka WhatsApp.');
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan: $e');
    }
  }

  // ============================================================
  // SIMPAN LAPORAN KE SUPABASE
  // ============================================================
  Future<void> _sendReportToSupabase(String message) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;
    if (userId == null) {
      _showSnackBar('User ID tidak ditemukan, laporan tidak tersimpan.');
      return;
    }
    try {
      await _supabase.createReport({
        'user_id': userId,
        'type': _selectedReportType,
        'location': _selectedLocation ?? 'Tidak disebutkan',
        'description': message,
        'is_anonymous': _isAnonym,
        'created_at': DateTime.now().toIso8601String(),
      });
      _showSnackBar('✅ Laporan berhasil disimpan di server.');
    } catch (e) {
      _showSnackBar('⚠️ Gagal menyimpan laporan: $e');
    }
  }

  // ============================================================
  // KIRIM LAPORAN KE WHATSAPP + SUPABASE
  // ============================================================
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

    setState(() => _isLoading = false);

    // Kirim ke WhatsApp
    await _sendToWhatsApp(hotline.whatsapp ?? hotline.phone, message);

    // Simpan ke Supabase
    await _sendReportToSupabase(message);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.shevaColors.header,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return Scaffold(
      backgroundColor: colors.bgDeep,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: colors.header,
        foregroundColor: colors.text1,
        elevation: 0,
        title: const Text(
          'SHEVA Report',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: colors.border),
              ),
              child: Text(
                'Semua laporan bersifat rahasia dan dienkripsi. Data anda tidak akan dibagikan tanpa persetujuan anda. Anda bisa memilih untuk melapor secara anonim.',
                style: TextStyle(
                  color: colors.text2,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Text(
              'Jenis Laporan*',
              style: TextStyle(
                color: colors.accent,
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
                  splashColor: colors.text1.withOpacity(0.1),
                  highlightColor: colors.text1.withOpacity(0.05),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingXs,
                    ),
                    decoration: ShapeDecoration(
                      color: isSelected ? colors.accentMid : colors.card,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isSelected ? colors.accent : colors.border,
                        ),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        color: isSelected ? colors.text1 : colors.text2,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Text(
              'Lokasi Kejadian',
              style: TextStyle(
                color: colors.accent,
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
                      splashColor: colors.text1.withOpacity(0.1),
                      highlightColor: colors.text1.withOpacity(0.05),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingSm,
                          vertical: AppTheme.spacingXs,
                        ),
                        decoration: ShapeDecoration(
                          color: isSelected ? colors.accentMid : colors.card,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isSelected ? colors.accent : colors.border,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusMd),
                          ),
                        ),
                        child: Text(
                          location,
                          style: TextStyle(
                            color: isSelected ? colors.text1 : colors.text2,
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
            Text(
              'Deskripsi Kejadian*',
              style: TextStyle(
                color: colors.accent,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Container(
              height: 120,
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: colors.border),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                expands: true,
                style: TextStyle(color: colors.text1, fontSize: 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ceritakan apa yang terjadi...',
                  hintStyle: TextStyle(color: colors.text4, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_descriptionController.text.length} Karakter',
                style: TextStyle(
                  color: colors.text4,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Row(
              children: [
                Switch(
                  value: _isAnonym,
                  onChanged: (value) => setState(() => _isAnonym = value),
                  activeColor: colors.accent,
                  activeTrackColor: colors.accentMid,
                ),
                const SizedBox(width: AppTheme.spacingXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Laporan Anonim',
                        style: TextStyle(
                          color: colors.text1,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Nama anda tidak akan dicantumkan',
                        style: TextStyle(
                          color: colors.text4,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: AppTheme.spacingXs),
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
                          backgroundColor: colors.bgDeep,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(AppTheme.spacingLg)),
                          ),
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(AppTheme.spacingLg),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Kirim Laporan ke:',
                                  style: TextStyle(
                                    color: colors.text1,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacingMd),
                                ..._hotlines.map((hotline) => Column(
                                      children: [
                                        HotlineTile(
                                          name: hotline.name,
                                          phone: hotline.phone,
                                          whatsapp: hotline.whatsapp,
                                          description: hotline.description,
                                          onTap: () {
                                            Navigator.pop(context);
                                            _sendReportToWhatsApp(hotline);
                                          },
                                        ),
                                        Divider(color: colors.border),
                                      ],
                                    )),
                                const SizedBox(height: AppTheme.spacingXs),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Batal',
                                    style: TextStyle(color: colors.text3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentMid,
                  foregroundColor: colors.text1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    side: BorderSide(color: colors.border),
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
            Center(
              child: Text(
                'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                style: TextStyle(
                  color: colors.text3,
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
}

// ============================================================
// MODEL HOTLINE
// ============================================================
class Hotline {
  final String name;
  final String phone;
  final String? whatsapp;
  final String description;

  Hotline({
    required this.name,
    required this.phone,
    this.whatsapp,
    required this.description,
  });
}
