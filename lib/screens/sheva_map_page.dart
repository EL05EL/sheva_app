import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _whatsApp(String phone) async {
    String cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (cleanPhone.startsWith('0')) {
      cleanPhone = '62${cleanPhone.substring(1)}';
    }
    if (cleanPhone == '129' || cleanPhone == '110' || cleanPhone == '118') {
      final Uri dialUri = Uri(scheme: 'tel', path: cleanPhone);
      if (await canLaunchUrl(dialUri)) {
        await launchUrl(dialUri);
      }
      return;
    }
    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanPhone');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      final Uri dialUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(dialUri)) {
        await launchUrl(dialUri);
      }
    }
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
      backgroundColor: const Color(0xFF17071F),
      floatingActionButton: _buildSOSButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SHEVA Map',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filters.map((filter) {
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedFilter = filter),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: ShapeDecoration(
                        color: isSelected
                            ? const Color(0xFF8A38F5)
                            : const Color(0xFF4E2B7B),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFF2A283E)),
                          borderRadius: BorderRadius.circular(20),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                return _buildServiceCard(service);
              },
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(12),
            child: const Text(
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
    );
  }

  Widget _buildServiceCard(Service service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFF4E2B7B),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFF270F32)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
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
                const SizedBox(height: 4),
                Text(
                  '${service.address}\n${service.hours}',
                  style: const TextStyle(
                    color: Color(0xFFDAC4EB),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _whatsApp(service.phone),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7FFF0C0C),
              ),
              child: const Icon(Icons.phone, color: Colors.white, size: 28),
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
