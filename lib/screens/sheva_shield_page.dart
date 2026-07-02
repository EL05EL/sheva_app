import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../app_theme.dart';

// 🔥 Import hotline_tile.dart TIDAK dipakai karena kita pakai _buildHotlineOption sendiri

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
      if (image != null) {
        setState(() => _imageFile = File(image.path));
      }
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
      if (image != null) {
        setState(() => _imageFile = File(image.path));
      }
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

  // 🔥 FUNGSI UTAMA: Kirim laporan ke hotline (parameter sudah non-nullable semua)
  Future<void> _sendReportToHotline(String phoneNumber, String message,
      {bool withImage = false}) async {
    try {
      if (withImage && _imageFile != null && await _imageFile!.exists()) {
        // Kirim dengan gambar menggunakan share_plus (akan muncul pilihan aplikasi)
        final xFile = XFile(_imageFile!.path);
        await Share.shareXFiles(
          [xFile],
          text: message,
          subject: 'Laporan Darurat SHEVA',
        );
      } else {
        // Kirim teks langsung via WhatsApp (tanpa pilihan aplikasi)
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

  // 🔥 MENAMPILKAN DIALOG PILIHAN jika ada gambar
  void _showSendOptions(String phoneNumber, String message) {
    if (_imageFile == null) {
      // Jika tidak ada gambar, langsung kirim teks
      _sendReportToHotline(phoneNumber, message, withImage: false);
      return;
    }

    // Jika ada gambar, tampilkan dialog pilihan
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Text('Kirim Laporan', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Anda memiliki foto bukti. Pilih cara pengiriman:',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        backgroundColor: AppTheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          side: const BorderSide(color: AppTheme.borderDefault),
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
              backgroundColor: AppTheme.secondary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Kirim dengan Gambar'),
          ),
        ],
      ),
    );
  }

  // 🔥 FUNGSI KIRIM LAPORAN DARURAT (membuka bottom sheet)
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
      backgroundColor: AppTheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppTheme.spacingLg)),
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
            _buildHotlineOption('SAPA 129', '129', message),
            const Divider(color: AppTheme.borderDefault),
            _buildHotlineOption('Polisi 110', '110', message),
            const Divider(color: AppTheme.borderDefault),
            _buildHotlineOption('Ambulance 118', '118', message),
            const Divider(color: AppTheme.borderDefault),
            _buildHotlineOption('Komnas Perempuan', '08123456787', message),
            const Divider(color: AppTheme.borderDefault),
            _buildHotlineOption('CS SHEVA - Fadil', '081243265263', message),
            const SizedBox(height: AppTheme.spacingMd),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: AppTheme.captionMuted),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 WIDGET HOTLINE OPTION dengan onTap yang memanggil dialog pilihan
  // 🔥 PERBAIKAN: Semua parameter bertipe String (non-nullable)
  Widget _buildHotlineOption(String name, String phoneNumber, String message) {
    return ListTile(
      leading:
          const Icon(Icons.phone, color: Colors.green, size: AppTheme.iconMain),
      title: Text(name, style: AppTheme.body),
      subtitle: Text(phoneNumber, style: AppTheme.captionMuted),
      trailing: const Icon(Icons.chevron_right,
          color: Colors.white, size: AppTheme.iconMain),
      onTap: () {
        Navigator.pop(context); // Tutup bottom sheet
        _showSendOptions(phoneNumber, message); // Tampilkan dialog pilihan
      },
      splashColor: Colors.white.withOpacity(0.1),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.primary,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title:
            const Text('SHEVA Shield', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.send, size: AppTheme.iconMain),
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
            // Rekam Bukti
            const Text(
              'Rekam Bukti',
              style: AppTheme.bodyBold,
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickFromCamera,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    splashColor: Colors.white.withOpacity(0.1),
                    highlightColor: Colors.white.withOpacity(0.05),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.spacingMd),
                      decoration: ShapeDecoration(
                        color: AppTheme.dangerBg,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppTheme.borderPink),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusXl),
                        ),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,
                                color: AppTheme.dangerLight,
                                size: AppTheme.iconMain),
                            SizedBox(width: AppTheme.spacingXs),
                            Text(
                              'Buka kamera',
                              style: TextStyle(
                                color: AppTheme.dangerLight,
                                fontSize: 14,
                              ),
                            ),
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
                    splashColor: Colors.white.withOpacity(0.1),
                    highlightColor: Colors.white.withOpacity(0.05),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.spacingMd),
                      decoration: ShapeDecoration(
                        color: AppTheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusXl),
                        ),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_library,
                                color: Color(0xFF8B85A6),
                                size: AppTheme.iconMain),
                            const SizedBox(width: AppTheme.spacingXs),
                            Text(
                              'Dari galeri',
                              style: TextStyle(
                                color: Color(0xFF8B85A6),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            // Preview Foto
            Container(
              width: double.infinity,
              height: 120,
              decoration: AppTheme.cardDecoration(),
              child: _imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : const Center(
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
            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.spacingXs),
                child: InkWell(
                  onTap: () => setState(() => _imageFile = null),
                  borderRadius: BorderRadius.circular(8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete,
                          color: Colors.red, size: AppTheme.iconSmall),
                      SizedBox(width: AppTheme.spacingXxs),
                      Text(
                        'Hapus foto',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: AppTheme.spacingLg),
            // Lokasi
            const Text(
              'Lokasi Kejadian',
              style: AppTheme.body,
            ),
            const SizedBox(height: AppTheme.spacingXs),
            InkWell(
              onTap: _detectLocation,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              splashColor: Colors.white.withOpacity(0.1),
              highlightColor: Colors.white.withOpacity(0.05),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                  vertical: AppTheme.spacingSm,
                ),
                decoration: ShapeDecoration(
                  color: AppTheme.locateBg,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppTheme.locateBorder),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    _isLoadingLocation
                        ? const SizedBox(
                            width: AppTheme.spacingLg,
                            height: AppTheme.spacingLg,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppTheme.accentPink,
                            ),
                          )
                        : const Icon(Icons.location_on,
                            color: AppTheme.accentPink,
                            size: AppTheme.spacingLg),
                    const SizedBox(width: AppTheme.spacingXs),
                    Expanded(
                      child: Text(
                        _isLoadingLocation
                            ? 'Mendapatkan lokasi...'
                            : _location,
                        style: const TextStyle(
                          color: Color(0xFFF6F3F7),
                          fontSize: 14,
                        ),
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
                vertical: AppTheme.spacingXxs,
              ),
              decoration: ShapeDecoration(
                color: const Color(0x26DAD3D8),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppTheme.background),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
              ),
              child: TextField(
                controller: _locationController,
                style: const TextStyle(color: Color(0xFFF6F3F7), fontSize: 14),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'atau ketik lokasi manual...',
                  hintStyle: TextStyle(color: AppTheme.textMuted, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),
            // Deskripsi
            const Text(
              'Deskripsi Kejadian',
              style: AppTheme.body,
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Container(
              height: 150,
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              decoration: AppTheme.cardDecoration(),
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                expands: true,
                style: AppTheme.body,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ceritakan kejadian secara detail...',
                  hintStyle: TextStyle(color: AppTheme.textMuted, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXl),
            // Layanan Darurat
            const Text(
              'Layanan Darurat',
              style: AppTheme.bodyBold,
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Wrap(
              spacing: AppTheme.spacingSm,
              runSpacing: AppTheme.spacingSm,
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
            const SizedBox(height: AppTheme.spacingXl),
            // Panduan Keselamatan
            const Text(
              'Panduan Keselamatan',
              style: AppTheme.bodyBold,
            ),
            const SizedBox(height: AppTheme.spacingSm),
            _buildSafetyGuide('1', 'Pergi ke tempat ramai'),
            _buildSafetyGuide('2', 'Hubungi orang yang anda percaya'),
            _buildSafetyGuide('3', 'Kunci pintu dan jendela'),
            _buildSafetyGuide(
                '4', 'Jangan kembali sendirian ke tempat berbahaya'),
            _buildSafetyGuide('5', 'Simpan bukti (foto rekaman)'),
            _buildSafetyGuide('6', 'Jika darurat hubungi pihak Berwajib'),
            const SizedBox(height: AppTheme.spacingMd),
            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 53,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendEmergencyReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.dangerDark,
                  foregroundColor: Colors.white,
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
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send,
                              color: Colors.white, size: AppTheme.iconMain),
                          SizedBox(width: AppTheme.spacingXs),
                          Text(
                            'Kirim Laporan Darurat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
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

  // 🔥 EMERGENCY CARD (langsung ke dialog pilihan)
  Widget _buildEmergencyCard(
      String title, String subtitle, String phoneNumber) {
    final message =
        'Halo, saya membutuhkan bantuan darurat. ${_descriptionController.text}';
    return InkWell(
      onTap: () => _showSendOptions(phoneNumber, message),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.05),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(AppTheme.spacingSm),
        decoration: ShapeDecoration(
          color: AppTheme.emergencyCardBg,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppTheme.borderEmergency),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
        ),
        child: Column(
          children: [
            Text(
              phoneNumber,
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
              style: AppTheme.labelMuted,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyGuide(String number, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.spacingSm,
        horizontal: AppTheme.spacingMd,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.borderDefault)),
      ),
      child: Row(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: AppTheme.danger,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Text(
            text,
            style: AppTheme.body,
          ),
        ],
      ),
    );
  }
}
