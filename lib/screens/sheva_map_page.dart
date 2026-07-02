import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../widgets/sos_button.dart';

class ShevaMapPage extends StatefulWidget {
  const ShevaMapPage({super.key});

  @override
  State<ShevaMapPage> createState() => _ShevaMapPageState();
}

class _ShevaMapPageState extends State<ShevaMapPage> {
  String selectedFilter = 'Semua Kota';

  final List<Service> services = [
    Service(
      name: 'Hotline SAPA 129',
      city: 'Seluruh Indonesia',
      address: 'Seluruh Indonesia',
      hours: '24 Jam',
      phone: '129',
      isEmergency: true,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=SAPA+129+Indonesia',
    ),
    Service(
      name: 'Into The Light IDN',
      city: 'Jakarta',
      address: 'Jakarta',
      hours: '24 Jam',
      phone: '08123456789',
      isEmergency: true,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Into+The+Light+IDN+Jakarta',
    ),
    Service(
      name: 'SAFEnet',
      city: 'Jakarta',
      address: 'Jakarta',
      hours: 'Senin-Jumat, 09.00-17.00',
      phone: '08123456788',
      isEmergency: false,
      mapUrl: 'https://www.google.com/maps/search/?api=1&query=SAFEnet+Jakarta',
    ),
    Service(
      name: 'Komnas Perempuan',
      city: 'Jakarta Pusat',
      address: 'Jakarta Pusat',
      hours: 'Senin-Jumat, 09.00-17.00',
      phone: '08123456787',
      isEmergency: false,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Komnas+Perempuan+Jakarta',
    ),
    Service(
      name: 'LBH Jakarta',
      city: 'Jakarta Pusat',
      address: 'Jakarta Pusat',
      hours: 'Senin-Jumat, 09.00-17.00',
      phone: '08123456786',
      isEmergency: false,
      mapUrl: 'https://www.google.com/maps/search/?api=1&query=LBH+Jakarta',
    ),
    Service(
      name: 'Yayasan Pulih',
      city: 'Jakarta Utara',
      address: 'Jakarta Utara',
      hours: 'Senin-Sabtu, 09.00-18.00',
      phone: '08123456785',
      isEmergency: false,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Yayasan+Pulih+Jakarta',
    ),
    Service(
      name: 'Rifka Annisa WCC',
      city: 'Yogyakarta',
      address: 'Yogyakarta',
      hours: 'Senin-Jumat, 08.39-16.30',
      phone: '08123456784',
      isEmergency: false,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Rifka+Annisa+WCC+Yogyakarta',
    ),
    Service(
      name: 'WCC Cahaya Perempuan',
      city: 'Bengkulu',
      address: 'Bengkulu',
      hours: 'Senin-Jumat, 08.00-17.00',
      phone: '08123456783',
      isEmergency: false,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=WCC+Cahaya+Perempuan+Bengkulu',
    ),
    Service(
      name: 'YLBHI',
      city: 'Jakarta Pusat',
      address: 'Jakarta Pusat',
      hours: 'Senin-Jumat, 09.00-17.00',
      phone: '08123456782',
      isEmergency: false,
      mapUrl: 'https://www.google.com/maps/search/?api=1&query=YLBHI+Jakarta',
    ),
  ];

  List<String> get filters {
    Set<String> cities = {};
    for (var s in services) {
      if (s.isEmergency) {
        cities.add('Hotline Darurat');
      } else {
        cities.add(s.city);
      }
    }
    return ['Semua Kota', ...cities.toList()];
  }

  List<Service> get filteredServices {
    if (selectedFilter == 'Semua Kota') return services;
    if (selectedFilter == 'Hotline Darurat') {
      return services.where((s) => s.isEmergency).toList();
    }
    return services.where((s) => s.city == selectedFilter).toList();
  }

  // 🔥 PERBAIKAN: Fungsi WhatsApp dengan penanganan error dan fallback
  Future<void> _whatsApp(String phone) async {
    try {
      String cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
      if (cleanPhone.startsWith('0')) {
        cleanPhone = '62${cleanPhone.substring(1)}';
      }

      // Untuk hotline darurat (129, 110, 118) gunakan dial telepon
      if (cleanPhone == '129' || cleanPhone == '110' || cleanPhone == '118') {
        final dialUri = Uri(scheme: 'tel', path: cleanPhone);
        if (await canLaunchUrl(dialUri)) {
          await launchUrl(dialUri);
        } else {
          _showSnackBar('Tidak dapat melakukan panggilan.');
        }
        return;
      }

      // Coba WhatsApp terlebih dahulu
      final whatsappUri = Uri.parse('https://wa.me/$cleanPhone');
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: coba telepon biasa
        final dialUri = Uri(scheme: 'tel', path: phone);
        if (await canLaunchUrl(dialUri)) {
          await launchUrl(dialUri);
        } else {
          _showSnackBar('Tidak dapat membuka WhatsApp atau panggilan.');
        }
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
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryLight,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SHEVA Map',
          style: AppTheme.h2Medium,
        ),
      ),
      body: Column(
        children: [
          // Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filters.map((filter) {
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingXxs),
                  child: InkWell(
                    onTap: () => setState(() => selectedFilter = filter),
                    borderRadius: BorderRadius.circular(AppTheme.spacingLg),
                    splashColor: Colors.white.withOpacity(0.1),
                    highlightColor: Colors.white.withOpacity(0.05),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMd,
                        vertical: AppTheme.spacingXs,
                      ),
                      decoration: ShapeDecoration(
                        color: isSelected
                            ? AppTheme.accentPurpleDark
                            : AppTheme.surfaceCard2,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppTheme.borderDefault),
                          borderRadius:
                              BorderRadius.circular(AppTheme.spacingLg),
                        ),
                      ),
                      child: Text(
                        filter,
                        style: const TextStyle(
                          color: Colors.white,
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
          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd,
                vertical: AppTheme.spacingSm,
              ),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                return _buildServiceCard(service);
              },
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            child: const Text(
              'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
              style: AppTheme.tiny,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Service service) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: AppTheme.cardDecorationHeavy(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.spacingXxs),
                Text(
                  '${service.address}\n${service.hours}',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // 🔥 PERBAIKAN: Tombol Telepon dengan InkWell dan onTap
          InkWell(
            onTap: () => _whatsApp(service.phone),
            borderRadius: BorderRadius.circular(25),
            splashColor: Colors.white.withOpacity(0.2),
            highlightColor: Colors.white.withOpacity(0.1),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.dangerBgSoft,
              ),
              child: const Icon(Icons.phone,
                  color: Colors.white, size: AppTheme.iconLarge),
            ),
          ),
        ],
      ),
    );
  }
}

class Service {
  final String name;
  final String city;
  final String address;
  final String hours;
  final String phone;
  final bool isEmergency;
  final String mapUrl;

  Service({
    required this.name,
    required this.city,
    required this.address,
    required this.hours,
    required this.phone,
    required this.isEmergency,
    required this.mapUrl,
  });
}
