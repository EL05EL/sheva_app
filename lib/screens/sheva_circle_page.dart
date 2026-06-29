import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShevaCirclePage extends StatefulWidget {
  const ShevaCirclePage({super.key});

  @override
  State<ShevaCirclePage> createState() => _ShevaCirclePageState();
}

class _ShevaCirclePageState extends State<ShevaCirclePage> {
  String selectedCity = 'Semua Kota';

  // Data komunitas
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
    if (selectedCity == 'Semua Kota') {
      return communities;
    }
    return communities.where((c) => c.city == selectedCity).toList();
  }

  void _openMap(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      body: SingleChildScrollView(
        child: Container(
          width: 402,
          height: 1198,
          decoration: const ShapeDecoration(
            color: Color(0xFF290D36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          child: Stack(
            children: [
              // Header
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 402,
                  height: 76,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF493370),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              // Tombol Kembali
              Positioned(
                left: 16,
                top: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              // Judul
              Positioned(
                left: 54,
                top: 12,
                child: const SizedBox(
                  width: 223,
                  height: 54,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'SHEVA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' Circle\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Komunitas Pro Gender Equality Indonesia ',
                          style: TextStyle(
                            color: Color(0xFFDAC4EB),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Filter Kota (horizontal scroll)
              Positioned(
                left: 0,
                top: 88,
                child: SizedBox(
                  width: 398,
                  height: 77,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
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
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
              ),
              // Daftar Komunitas (dalam container scroll)
              Positioned(
                left: -5,
                top: 165,
                child: Container(
                  width: 411,
                  height: 986,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ListView.builder(
                    itemCount: filteredCommunities.length,
                    itemBuilder: (context, index) {
                      final community = filteredCommunities[index];
                      return _buildCommunityCard(community);
                    },
                  ),
                ),
              ),
              // Footer
              Positioned(
                left: 35,
                top: 1163,
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
        ),
      ),
    );
  }

  Widget _buildCityChip(String label) {
    final isSelected = selectedCity == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCity = label;
        });
      },
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
      margin: const EdgeInsets.only(bottom: 20),
      width: 371,
      height: 102,
      decoration: ShapeDecoration(
        color: const Color(0xFF4E2B7B),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFF270F32)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          // Nama komunitas
          Positioned(
            left: 30,
            top: 25,
            child: SizedBox(
              width: 280,
              height: 29,
              child: Text(
                community.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Kota
          Positioned(
            left: 60,
            top: 60,
            child: SizedBox(
              width: 180,
              height: 15,
              child: Text(
                community.address,
                style: const TextStyle(
                  color: Color(0xFFDAC4EB),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // Ikon Maps (klik untuk buka Google Maps)
          Positioned(
            right: 20,
            top: 30,
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }
}

// Model data komunitas
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
