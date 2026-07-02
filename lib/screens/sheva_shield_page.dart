import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class ShevaShieldPage extends StatefulWidget {
  const ShevaShieldPage({super.key});

  @override
  State<ShevaShieldPage> createState() => _ShevaShieldPageState();
}

class _ShevaShieldPageState extends State<ShevaShieldPage> {
  File? _imageFile;
  String _location = 'Menunggu deteksi lokasi...';
  bool _isLoadingLocation = false;
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
        setState(() {
          _imageFile = File(image.path);
        });
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
        setState(() {
          _imageFile = File(image.path);
        });
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
          _location = 'Izin lokasi ditolak permanen. Silakan ketik manual.';
          _isLoadingLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _location =
              '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
          _locationController.text = _location;
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
      _showSnackBar('Gagal deteksi lokasi. Silakan ketik manual.');
    }
  }

  Future<void> _sendToWhatsApp(String phoneNumber, String message) async {
    String cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    if (cleanPhone.startsWith('0')) {
      cleanPhone = '62${cleanPhone.substring(1)}';
    }

    String encodedMessage = Uri.encodeComponent(message);
    String url = 'https://wa.me/$cleanPhone?text=$encodedMessage';

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final Uri smsUri =
          Uri(scheme: 'sms', path: phoneNumber, query: 'body=$encodedMessage');
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        _showSnackBar('Tidak dapat membuka WhatsApp atau SMS.');
      }
    }
  }

  Future<void> _sendEmergencyReport() async {
    if (_imageFile == null && _descriptionController.text.isEmpty) {
      _showSnackBar('Silakan tambahkan foto atau deskripsi kejadian.');
      return;
    }

    String locationText = _locationController.text.isNotEmpty
        ? _locationController.text
        : _location;

    String message = '''
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

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF290D36),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            _buildHotlineOption('SAPA 129', '129', message),
            const Divider(color: Color(0xFF2A283E)),
            _buildHotlineOption('Polisi 110', '110', message),
            const Divider(color: Color(0xFF2A283E)),
            _buildHotlineOption('Ambulance 118', '118', message),
            const Divider(color: Color(0xFF2A283E)),
            _buildHotlineOption('Komnas Perempuan', '08123456787', message),
            const SizedBox(height: 16),
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
  }

  Widget _buildHotlineOption(String name, String phone, String message) {
    return ListTile(
      leading: const Icon(Icons.phone, color: Colors.green),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        phone,
        style: const TextStyle(color: Color(0xFF919191)),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {
        Navigator.pop(context);
        _sendToWhatsApp(phone, message);
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF493370),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      // TIDAK ADA FloatingActionButton di halaman Shield
      appBar: AppBar(
        title:
            const Text('SHEVA Shield', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendEmergencyReport,
          ),
        ],
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
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _pickFromCamera,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,
                                color: Color(0xFFDF0D0D), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Buka kamera',
                              style: TextStyle(
                                color: Color(0xFFDF0D0D),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _pickFromGallery,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF240D2F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_library,
                                color: Color(0xFF8B85A6), size: 20),
                            SizedBox(width: 8),
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
              child: _imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
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
                padding: const EdgeInsets.only(top: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _imageFile = null;
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Colors.red, size: 16),
                      SizedBox(width: 4),
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
            GestureDetector(
              onTap: _detectLocation,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0x267A2062),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF7A2062)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  children: [
                    _isLoadingLocation
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFF30DB6),
                            ),
                          )
                        : const Icon(Icons.location_on,
                            color: Color(0xFFF30DB6), size: 20),
                    const SizedBox(width: 8),
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
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: ShapeDecoration(
                color: const Color(0x26DAD3D8),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF290D36)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: TextField(
                controller: _locationController,
                style: const TextStyle(color: Color(0xFFF6F3F7), fontSize: 14),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'atau ketik lokasi manual...',
                  hintStyle: TextStyle(color: Color(0xFF919191), fontSize: 14),
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
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                expands: true,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
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
            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 53,
              child: ElevatedButton.icon(
                onPressed: _sendEmergencyReport,
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text(
                  'Kirim Laporan Darurat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD90000),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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

  Widget _buildEmergencyCard(String title, String subtitle, String number) {
    return GestureDetector(
      onTap: () {
        _sendToWhatsApp(number,
            'Halo, saya membutuhkan bantuan darurat. ${_descriptionController.text}');
      },
      child: Container(
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
