import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final List<Hotline> _hotlines = [
    Hotline(
        name: 'SAPA 129',
        phone: '129',
        description: 'Hotline Nasional 24 jam untuk korban kekerasan'),
    Hotline(
        name: 'Komnas Perempuan',
        phone: '08123456787',
        description: 'Komisi Nasional Anti Kekerasan terhadap Perempuan'),
    Hotline(
        name: 'LBH APIK',
        phone: '08123456786',
        description: 'Lembaga Bantuan Hukum untuk perempuan'),
    Hotline(
        name: 'Yayasan Pulih',
        phone: '08123456785',
        description: 'Layanan konseling dan pemulihan trauma'),
  ];

  Future<void> _sendReportToWhatsApp(Hotline hotline) async {
    if (_selectedReportType == null) {
      _showSnackBar('Silakan pilih jenis laporan terlebih dahulu.');
      return;
    }

    String message = '''
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

    String encodedMessage = Uri.encodeComponent(message);
    String url = 'https://wa.me/$cleanPhone?text=$encodedMessage';

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showSnackBar('Tidak dapat membuka WhatsApp.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF493370),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildSOSButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/shield'),
      backgroundColor: const Color(0xFFFF0C0C),
      foregroundColor: Colors.white,
      child: const Icon(Icons.sos, size: 32),
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      floatingActionButton: _buildSOSButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: const Color(0xFF48336F),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SHEVA Report',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
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
              children: _reportTypes.map((type) {
                final isSelected = _selectedReportType == type;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedReportType = type;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: ShapeDecoration(
                      color: isSelected
                          ? const Color(0xFF4E2B7B)
                          : const Color(0xFF240D2F),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF9B89EC)
                              : const Color(0xFF2A283E),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : const Color(0xFFDAC4EB),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Lokasi
            const Text(
              'Lokasi Kejadian',
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
                children: _locations.map((location) {
                  final isSelected = _selectedLocation == location;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLocation = location;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: ShapeDecoration(
                          color: isSelected
                              ? const Color(0x7F744AC1)
                              : const Color(0xFF240D2F),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isSelected
                                  ? const Color(0xFF9B89EC)
                                  : const Color(0xFF2A283E),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          location,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFFDAC4EB),
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
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                expands: true,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      'Ceritakan apa yang terjadi. Anda tidak perlu menyertakan detail yang membuat Anda tidak nyaman...',
                  hintStyle: TextStyle(color: Color(0xFF919191), fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_descriptionController.text.length} Karakter',
                style: const TextStyle(color: Color(0xFFC4C5C8), fontSize: 10),
              ),
            ),
            const SizedBox(height: 20),
            // Laporan Anonim
            Row(
              children: [
                Switch(
                  value: _isAnonym,
                  onChanged: (value) {
                    setState(() {
                      _isAnonym = value;
                    });
                  },
                  activeColor: const Color(0xFF9B89EC),
                  activeTrackColor: const Color(0xFF4E2B7B),
                ),
                const SizedBox(width: 8),
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
                            color: Color(0xFF837F98),
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
            const Divider(color: Color(0xFF2A283E)),
            const SizedBox(height: 8),
            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 53,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedReportType == null) {
                    _showSnackBar(
                        'Silakan pilih jenis laporan terlebih dahulu.');
                    return;
                  }
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: const Color(0xFF290D36),
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Kirim Laporan ke:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._hotlines
                              .map((hotline) => Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.phone,
                                            color: Colors.green),
                                        title: Text(
                                          hotline.name,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          hotline.description,
                                          style: const TextStyle(
                                              color: Color(0xFF919191),
                                              fontSize: 12),
                                        ),
                                        trailing: const Icon(
                                            Icons.chevron_right,
                                            color: Colors.white),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _sendReportToWhatsApp(hotline);
                                        },
                                      ),
                                      const Divider(color: Color(0xFF2A283E)),
                                    ],
                                  ))
                              .toList(),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Batal',
                              style: TextStyle(color: Color(0xFF919191)),
                            ),
                          ),
                        ],
                      ),
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
                child: const Text(
                  'Kirim Laporan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
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
