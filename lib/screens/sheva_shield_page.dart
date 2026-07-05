import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';

class ShevaShieldPage extends StatefulWidget {
  const ShevaShieldPage({super.key});

  @override
  State<ShevaShieldPage> createState() => _ShevaShieldPageState();
}

class _ShevaShieldPageState extends State<ShevaShieldPage> {
  File? _imageFile;
  String _location = 'Menunggu deteksi lokasi...';
  bool _isLoadingLocation = false;
  bool _isLoading = false;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (image != null) setState(() => _imageFile = File(image.path));
    } catch (e) {
      _showSnackBar('Gagal membuka kamera: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (image != null) setState(() => _imageFile = File(image.path));
    } catch (e) {
      _showSnackBar('Gagal membuka galeri: $e');
    }
  }

  Future<void> _detectLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _location = 'Mendapatkan lokasi...';
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _location =
              'Layanan lokasi dimatikan. Silakan aktifkan di pengaturan.';
          _isLoadingLocation = false;
        });
        _showSnackBar('Aktifkan layanan lokasi di pengaturan HP Anda.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _location = 'Izin lokasi ditolak. Silakan ketik manual.';
            _isLoadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _location =
              'Izin lokasi ditolak permanen. Buka pengaturan HP untuk mengizinkan.';
          _isLoadingLocation = false;
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        String address = '';
        if (place.street != null && place.street!.isNotEmpty)
          address += '${place.street}, ';
        if (place.subLocality != null && place.subLocality!.isNotEmpty)
          address += '${place.subLocality}, ';
        if (place.locality != null && place.locality!.isNotEmpty)
          address += '${place.locality}, ';
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty)
          address += '${place.administrativeArea}, ';
        if (place.country != null && place.country!.isNotEmpty)
          address += place.country ?? '';
        if (address.isEmpty) {
          address = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
        }
        setState(() {
          _location = address;
          _locationController.text = address;
          _isLoadingLocation = false;
        });
      } else {
        setState(() {
          _location = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
          _locationController.text = _location;
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      setState(() {
        _location = 'Gagal deteksi lokasi. Silakan ketik manual.';
        _isLoadingLocation = false;
      });
      _showSnackBar('Gagal deteksi lokasi: $e');
    }
  }

  Future<void> _sendReportToHotline(String phoneNumber, String message,
      {bool withImage = false}) async {
    try {
      if (withImage && _imageFile != null && await _imageFile!.exists()) {
        final xFile = XFile(_imageFile!.path);
        await Share.shareXFiles(
          [xFile],
          text: message,
          subject: 'Laporan Darurat SHEVA',
        );
      } else {
        String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
        if (cleanPhone.startsWith('0')) {
          cleanPhone = '62${cleanPhone.substring(1)}';
        }
        final encodedMessage = Uri.encodeComponent(message);
        final url = 'https://wa.me/$cleanPhone?text=$encodedMessage';
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          _showSnackBar('Tidak dapat membuka WhatsApp.');
        }
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan: $e');
    }
  }

  void _showSendOptions(String phoneNumber, String message) {
    if (_imageFile == null) {
      _sendReportToHotline(phoneNumber, message, withImage: false);
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Text('Kirim Laporan', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Anda memiliki foto bukti. Pilih cara pengiriman:',
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: context.shevaColors.bgDeep,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          side: BorderSide(color: context.shevaColors.border),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _sendReportToHotline(phoneNumber, message, withImage: false);
            },
            child: const Text('Kirim Teks Saja',
                style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _sendReportToHotline(phoneNumber, message, withImage: true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.shevaColors.accent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Kirim dengan Gambar'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendEmergencyReport() async {
    if (_imageFile == null && _descriptionController.text.isEmpty) {
      _showSnackBar('Silakan tambahkan foto atau deskripsi kejadian.');
      return;
    }

    if (_isLoading) return;
    setState(() => _isLoading = true);

    final locationText = _locationController.text.isNotEmpty
        ? _locationController.text
        : _location;

    final message = '''
⚠️ LAPORAN DARURAT SHEVA SHIELD

📅 Tanggal: ${DateTime.now().toString().split(' ')[0]}
🕐 Waktu: ${DateTime.now().toString().split(' ')[1].substring(0, 5)}

📍 Lokasi: $locationText

📝 Deskripsi Kejadian:
${_descriptionController.text.isEmpty ? '(Tidak ada deskripsi)' : _descriptionController.text}

📸 Bukti: ${_imageFile != null ? 'Ada (foto terlampir)' : 'Tidak ada foto'}

---
Dikirim dari aplikasi SHEVA
Solidarity Hub for Equality, Voice, and Action
For She, For He, For All.
''';

    setState(() => _isLoading = false);

    showModalBottomSheet(
      context: context,
      backgroundColor: context.shevaColors.bgDeep,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppTheme.spacingLg)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Kirim Laporan ke:',
              style: TextStyle(
                color: context.shevaColors.text1,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _buildHotlineOption('SAPA 129', '129', message),
            Divider(color: context.shevaColors.border),
            _buildHotlineOption('Polisi 110', '110', message),
            Divider(color: context.shevaColors.border),
            _buildHotlineOption('Ambulance 118', '118', message),
            Divider(color: context.shevaColors.border),
            _buildHotlineOption('Komnas Perempuan', '(021) 3903963', message),
            Divider(color: context.shevaColors.border),
            _buildHotlineOption('CS SHEVA - Fadil', '081243265263', message),
            const SizedBox(height: AppTheme.spacingMd),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotlineOption(String name, String phoneNumber, String message) {
    final colors = context.shevaColors;
    return ListTile(
      leading: Icon(Icons.phone, color: Colors.green, size: AppTheme.iconMain),
      title: Text(name, style: TextStyle(color: colors.text1, fontSize: 16)),
      subtitle: Text(phoneNumber,
          style: TextStyle(color: colors.text3, fontSize: 14)),
      trailing: Icon(Icons.chevron_right,
          color: colors.text1, size: AppTheme.iconMain),
      onTap: () {
        Navigator.pop(context);
        _showSendOptions(phoneNumber, message);
      },
      splashColor: colors.text1.withOpacity(0.1),
    );
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

  @override
  Widget build(BuildContext context) {
    final colors = context.shevaColors;
    return Scaffold(
      backgroundColor: colors.bgDeep,
      appBar: AppBar(
        title:
            const Text('SHEVA Shield', style: TextStyle(color: Colors.white)),
        backgroundColor: colors.header,
        foregroundColor: colors.text1,
        elevation: 0,
        actions: [
          IconButton(
            icon:
                Icon(Icons.send, size: AppTheme.iconMain, color: colors.text1),
            onPressed: _isLoading ? null : _sendEmergencyReport,
            padding: const EdgeInsets.all(AppTheme.spacingXs),
            constraints: const BoxConstraints(
              minWidth: AppTheme.touchTarget,
              minHeight: AppTheme.touchTarget,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rekam Bukti',
                style: TextStyle(
                    color: colors.text1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: AppTheme.spacingXs),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickFromCamera,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    splashColor: colors.text1.withOpacity(0.1),
                    highlightColor: colors.text1.withOpacity(0.05),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.spacingMd),
                      decoration: ShapeDecoration(
                        color: colors.danger.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: colors.sosRed),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusXl),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,
                                color: colors.sosRed, size: AppTheme.iconMain),
                            const SizedBox(width: AppTheme.spacingXs),
                            Text('Buka kamera',
                                style: TextStyle(
                                    color: colors.sosRed, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(
                  child: InkWell(
                    onTap: _pickFromGallery,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    splashColor: colors.text1.withOpacity(0.1),
                    highlightColor: colors.text1.withOpacity(0.05),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.spacingMd),
                      decoration: ShapeDecoration(
                        color: colors.card,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusXl),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_library,
                                color: colors.text3, size: AppTheme.iconMain),
                            const SizedBox(width: AppTheme.spacingXs),
                            Text('Dari galeri',
                                style: TextStyle(
                                    color: colors.text3, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: colors.border),
              ),
              child: _imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      child: Image.file(_imageFile!,
                          fit: BoxFit.cover, width: double.infinity),
                    )
                  : Center(
                      child: Text('Belum ada foto/bukti',
                          style: TextStyle(color: colors.text3, fontSize: 14)),
                    ),
            ),
            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.spacingXs),
                child: InkWell(
                  onTap: () => setState(() => _imageFile = null),
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete,
                          color: colors.danger, size: AppTheme.iconSmall),
                      const SizedBox(width: AppTheme.spacingXxs),
                      Text('Hapus foto',
                          style: TextStyle(color: colors.danger, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: AppTheme.spacingLg),
            Text('Lokasi Kejadian',
                style: TextStyle(color: colors.text1, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingXs),
            InkWell(
              onTap: _detectLocation,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              splashColor: colors.text1.withOpacity(0.1),
              highlightColor: colors.text1.withOpacity(0.05),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                    vertical: AppTheme.spacingSm),
                decoration: ShapeDecoration(
                  color: colors.cardWarm,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: colors.accent2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    _isLoadingLocation
                        ? SizedBox(
                            width: AppTheme.spacingLg,
                            height: AppTheme.spacingLg,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: colors.accent),
                          )
                        : Icon(Icons.location_on,
                            color: colors.accent, size: AppTheme.spacingLg),
                    const SizedBox(width: AppTheme.spacingXs),
                    Expanded(
                      child: Text(
                        _isLoadingLocation
                            ? 'Mendapatkan lokasi...'
                            : _location,
                        style: TextStyle(color: colors.text1, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                  vertical: AppTheme.spacingXxs),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: colors.border),
              ),
              child: TextField(
                controller: _locationController,
                style: TextStyle(color: colors.text1, fontSize: 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'atau ketik lokasi manual...',
                  hintStyle: TextStyle(color: colors.text4, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Text('Deskripsi Kejadian',
                style: TextStyle(color: colors.text1, fontSize: 16)),
            const SizedBox(height: AppTheme.spacingXs),
            Container(
              height: 150,
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
                  hintText: 'Ceritakan kejadian secara detail...',
                  hintStyle: TextStyle(color: colors.text4, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),

            // ============================================================
            // 🔥 LAYANAN DARURAT - Posisi seimbang dengan Row dan Expanded
            // ============================================================
            Text('Layanan Darurat',
                style: TextStyle(
                    color: colors.text1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: AppTheme.spacingSm),
            // Gunakan Row dengan 4 card yang sama lebarnya
            Row(
              children: [
                Expanded(
                  child: _buildEmergencyCard(
                    'SAPA 129',
                    'Hotline Nasional 24 jam',
                    '129',
                    colors.sosRed, // merah
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(
                  child: _buildEmergencyCard(
                    'Polisi 110',
                    'Layanan Darurat',
                    '110',
                    colors.blue, // 🔥 BIRU
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Row(
              children: [
                Expanded(
                  child: _buildEmergencyCard(
                    'Ambulance 118',
                    'Unit Gawat Darurat',
                    '118',
                    colors.green, // hijau
                  ),
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(
                  child: _buildEmergencyCard(
                    'Into The Light',
                    'Krisis Mental 24 jam',
                    '189',
                    colors.iconProtection, // pink
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXl),

            Text('Panduan Keselamatan',
                style: TextStyle(
                    color: colors.text1,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: AppTheme.spacingSm),
            _buildSafetyGuide('1', 'Pergi ke tempat ramai'),
            _buildSafetyGuide('2', 'Hubungi orang yang anda percaya'),
            _buildSafetyGuide('3', 'Kunci pintu dan jendela'),
            _buildSafetyGuide(
                '4', 'Jangan kembali sendirian ke tempat berbahaya'),
            _buildSafetyGuide('5', 'Simpan bukti (foto rekaman)'),
            _buildSafetyGuide('6', 'Jika darurat hubungi pihak Berwajib'),
            const SizedBox(height: AppTheme.spacingMd),

            SizedBox(
              width: double.infinity,
              height: 53,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendEmergencyReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.sosRed,
                  foregroundColor: colors.text1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  elevation: AppTheme.elevationMedium,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send,
                              color: colors.text1, size: AppTheme.iconMain),
                          const SizedBox(width: AppTheme.spacingXs),
                          const Text('Kirim Laporan Darurat',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Center(
              child: Text(
                'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                style: TextStyle(color: colors.text3, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 WIDGET CARD LAYANAN DARURAT - Ukuran seragam
  Widget _buildEmergencyCard(
      String title, String subtitle, String phoneNumber, Color cardColor) {
    final colors = context.shevaColors;
    final message =
        'Halo, saya membutuhkan bantuan darurat. ${_descriptionController.text}';
    return InkWell(
      onTap: () => _showSendOptions(phoneNumber, message),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      splashColor: colors.text1.withOpacity(0.1),
      highlightColor: colors.text1.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacingMd, horizontal: AppTheme.spacingSm),
        decoration: ShapeDecoration(
          color: cardColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colors.text1.withOpacity(0.3), width: 1.5),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              phoneNumber,
              style: TextStyle(
                color: colors.text1,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                color: colors.text1,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: colors.text1.withOpacity(0.85),
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyGuide(String number, String text) {
    final colors = context.shevaColors;
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spacingSm, horizontal: AppTheme.spacingMd),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colors.border))),
      child: Row(
        children: [
          Text(number,
              style: TextStyle(
                  color: colors.danger,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          const SizedBox(width: AppTheme.spacingMd),
          Text(text, style: TextStyle(color: colors.text1, fontSize: 16)),
        ],
      ),
    );
  }
}
