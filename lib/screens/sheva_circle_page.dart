import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShevaCirclePage extends StatefulWidget {
  const ShevaCirclePage({super.key});

  @override
  State<ShevaCirclePage> createState() => _ShevaCirclePageState();
}

class _ShevaCirclePageState extends State<ShevaCirclePage> {
  String selectedCity = 'Semua Kota';

  final List<Community> communities = [
    Community(
      name: 'Yayasan Putih',
      city: 'Jakarta',
      address: 'Jakarta',
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Yayasan+Putih+Jakarta',
    ),
    Community(
      name: 'Rifka Annisa WCC',
      city: 'Yogyakarta',
      address: 'Yogyakarta',
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Rifka+Annisa+WCC+Yogyakarta',
    ),
    Community(
      name: 'LBH APIK',
      city: 'Jakarta',
      address: 'Jakarta',
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=LBH+APIK+Jakarta',
    ),
    Community(
      name: 'Mawar Balqis WCC',
      city: 'Semarang',
      address: 'Semarang',
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Mawar+Balqis+WCC+Semarang',
    ),
    Community(
      name: 'Perempuan Berkebaya',
      city: 'Surabaya',
      address: 'Surabaya',
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Perempuan+Berkebaya+Surabaya',
    ),
    Community(
      name: 'HeForShe Indonesia',
      city: 'Online / UN Woman',
      address: 'Online / UN Woman',
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=HeForShe+Indonesia',
    ),
    Community(
      name: 'Koalisi Perempuan Indonesia',
      city: 'Online / Nasional',
      address: 'Online / Nasional',
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=Koalisi+Perempuan+Indonesia',
    ),
    Community(
      name: 'SAFEnet Indonesia',
      city: 'Online / Nasional',
      address: 'Online / Nasional',
      mapUrl:
          'https://www.google.com/maps/search/?api=1&query=SAFEnet+Indonesia',
    ),
  ];

  List<Community> get filteredCommunities {
    if (selectedCity == 'Semua Kota') return communities;
    return communities.where((c) => c.city == selectedCity).toList();
  }

  void _openMap(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
      backgroundColor: const Color(0xFF290D36),
      floatingActionButton: _buildSOSButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: const Color(0xFF493370),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SHEVA Circle',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Filter Chip
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCityChip('Semua Kota'),
                const SizedBox(width: 8),
                _buildCityChip('Jakarta'),
                const SizedBox(width: 8),
                _buildCityChip('Surabaya'),
                const SizedBox(width: 8),
                _buildCityChip('Yogyakarta'),
                const SizedBox(width: 8),
                _buildCityChip('Semarang'),
                const SizedBox(width: 8),
                _buildCityChip('Online / Nasional'),
              ],
            ),
          ),
          // Daftar Komunitas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: filteredCommunities.length,
              itemBuilder: (context, index) {
                final community = filteredCommunities[index];
                return _buildCommunityCard(community);
              },
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(16),
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

  Widget _buildCityChip(String label) {
    final isSelected = selectedCity == label;
    return GestureDetector(
      onTap: () => setState(() => selectedCity = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF8A38F5) : const Color(0xFF4E2B7B),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF2A283E)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityCard(Community community) {
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
                  community.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  community.address,
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
            onTap: () => _openMap(community.mapUrl),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x7FFF0C0C),
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Community {
  final String name;
  final String city;
  final String address;
  final String mapUrl;

  Community({
    required this.name,
    required this.city,
    required this.address,
    required this.mapUrl,
  });
}
