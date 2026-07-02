import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../widgets/sos_button.dart';

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

  // 🔥 PERBAIKAN: Fungsi buka Google Maps dengan penanganan error
  Future<void> _openMap(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      // Cek apakah bisa dibuka
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: coba buka dengan browser
        final browserUri = Uri.parse(url);
        if (await canLaunchUrl(browserUri)) {
          await launchUrl(browserUri, mode: LaunchMode.platformDefault);
        } else {
          _showSnackBar(
              'Tidak dapat membuka peta. Silakan buka browser dan cari alamat ini.');
        }
      }
    } catch (e) {
      _showSnackBar('Gagal membuka peta: $e');
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
      backgroundColor: AppTheme.background,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryLight,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SHEVA Circle',
          style: AppTheme.h2Medium,
        ),
      ),
      body: Column(
        children: [
          // Filter Chip
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCityChip('Semua Kota'),
                const SizedBox(width: AppTheme.spacingXs),
                _buildCityChip('Jakarta'),
                const SizedBox(width: AppTheme.spacingXs),
                _buildCityChip('Surabaya'),
                const SizedBox(width: AppTheme.spacingXs),
                _buildCityChip('Yogyakarta'),
                const SizedBox(width: AppTheme.spacingXs),
                _buildCityChip('Semarang'),
                const SizedBox(width: AppTheme.spacingXs),
                _buildCityChip('Online / Nasional'),
              ],
            ),
          ),
          // Daftar Komunitas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd,
                vertical: AppTheme.spacingSm,
              ),
              itemCount: filteredCommunities.length,
              itemBuilder: (context, index) {
                final community = filteredCommunities[index];
                return _buildCommunityCard(community);
              },
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: const Text(
              'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
              style: AppTheme.tiny,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityChip(String label) {
    final isSelected = selectedCity == label;
    return InkWell(
      onTap: () => setState(() => selectedCity = label),
      borderRadius: BorderRadius.circular(AppTheme.spacingLg),
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingXs,
        ),
        decoration: ShapeDecoration(
          color: isSelected ? AppTheme.accentPurpleDark : AppTheme.surfaceCard2,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppTheme.borderDefault),
            borderRadius: BorderRadius.circular(AppTheme.spacingLg),
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
                  community.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.spacingXxs),
                Text(
                  community.address,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // 🔥 PERBAIKAN: Tombol Map dengan InkWell dan onTap
          InkWell(
            onTap: () => _openMap(community.mapUrl),
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
              child: const Icon(Icons.location_on,
                  color: Colors.white, size: AppTheme.iconLarge),
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
