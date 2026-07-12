import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';
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
      whatsapp: '08111129129',
      isEmergency: true,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=SAPA+129+Indonesia',
    ),
    Service(
      name: 'Komnas Perempuan',
      city: 'Jakarta Pusat',
      address: 'Jakarta Pusat',
      hours: 'Senin-Jumat, 09.00-17.00',
      phone: '0213903963',
      whatsapp: '08179323375',
      isEmergency: false,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Komnas+Perempuan+Jakarta',
    ),
    Service(
      name: 'LBH APIK',
      city: 'Jakarta Pusat',
      address: 'Jakarta Pusat',
      hours: 'Senin-Jumat, 09.00-17.00',
      phone: '02187797289',
      whatsapp: '08138882669',
      isEmergency: false,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=LBH+APIK+Jakarta',
    ),
    Service(
      name: 'Yayasan Pulih',
      city: 'Jakarta Utara',
      address: 'Jakarta Utara',
      hours: 'Senin-Sabtu, 09.00-18.00',
      phone: '02178842580',
      whatsapp: '08118436633',
      isEmergency: false,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Yayasan+Pulih+Jakarta',
    ),
    Service(
      name: 'SEJIWA',
      city: 'Seluruh Indonesia',
      address: 'Layanan Kesehatan Jiwa',
      hours: '24 Jam',
      phone: '119',
      whatsapp: '081380073120',
      isEmergency: true,
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=SEJIWA+Indonesia',
    ),
    Service(
      name: 'CS SHEVA - Fadil',
      city: 'Online',
      address: 'Customer Service SHEVA',
      hours: '24 Jam',
      phone: '081243265263',
      whatsapp: '081243265263',
      isEmergency: false,
      mapUrl: 'https://www.google.com/maps/search/?api=1&query=CS+SHEVA',
    ),
    Service(
      name: 'Rifka Annisa WCC',
      city: 'Yogyakarta',
      address: 'Yogyakarta',
      hours: 'Senin-Jumat, 08.39-16.30',
      phone: '08123456784',
      whatsapp: '08123456784',
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
      whatsapp: '08123456783',
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
      whatsapp: '08123456782',
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

  Future<void> _whatsApp(String phone) async {
    try {
      String cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
      if (cleanPhone.startsWith('0')) {
        cleanPhone = '62${cleanPhone.substring(1)}';
      }
      if (cleanPhone == '129' || cleanPhone == '110' || cleanPhone == '118') {
        final dialUri = Uri(scheme: 'tel', path: phone);
        if (await canLaunchUrl(dialUri)) {
          await launchUrl(dialUri);
        } else {
          _showSnackBar('Tidak dapat melakukan panggilan.');
        }
        return;
      }
      final whatsappUri = Uri.parse('https://wa.me/$cleanPhone');
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
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
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: colors.header,
        foregroundColor: colors.text1,
        elevation: 0,
        title: const Text('SHEVA Map',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          // 🔥 CHIP SELECTOR – gaya konsisten dengan Sheva Learn
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filters.map((filter) {
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: AppTheme.spacingSm),
                  child: InkWell(
                    onTap: () => setState(() => selectedFilter = filter),
                    borderRadius: BorderRadius.circular(AppTheme.spacingLg),
                    splashColor: colors.text1.withOpacity(0.1),
                    highlightColor: colors.text1.withOpacity(0.05),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingLg,
                        vertical: AppTheme.spacingXs,
                      ),
                      decoration: ShapeDecoration(
                        color: isSelected ? colors.accentMid : colors.card,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: colors.border),
                          borderRadius:
                              BorderRadius.circular(AppTheme.spacingLg),
                        ),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: colors.text1,
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
          // Daftar Layanan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd, vertical: AppTheme.spacingSm),
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
            child: Text(
              'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
              style: TextStyle(color: colors.text3, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Service service) {
    final colors = context.shevaColors;
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: colors.cardWarm,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: colors.borderStrong),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: TextStyle(
                      color: colors.text1,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.spacingXxs),
                Text(
                  '${service.address}\n${service.hours}',
                  style: TextStyle(color: colors.text2, fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _whatsApp(service.whatsapp ?? service.phone),
            icon: Icon(Icons.phone,
                color: colors.accent, size: AppTheme.iconMain),
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
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
  final String? whatsapp;
  final bool isEmergency;
  final String mapUrl;
  Service({
    required this.name,
    required this.city,
    required this.address,
    required this.hours,
    required this.phone,
    this.whatsapp,
    required this.isEmergency,
    required this.mapUrl,
  });
}
