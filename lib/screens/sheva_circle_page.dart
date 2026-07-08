import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../theme/theme_extension.dart';
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

  Future<void> _openMap(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar('Tidak dapat membuka peta.');
      }
    } catch (e) {
      _showSnackBar('Gagal membuka peta: $e');
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
        title: const Text(
          'SHEVA Circle',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // 🔥 CHIP FILTER – RAPI seperti SHEVA Learn
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd,
              vertical: AppTheme.spacingSm,
            ),
            child: SizedBox(
              height: 40,
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
            child: Text(
              'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
              style: TextStyle(
                color: colors.text3,
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
    final colors = context.shevaColors;
    final isSelected = selectedCity == label;
    return InkWell(
      onTap: () => setState(() => selectedCity = label),
      borderRadius: BorderRadius.circular(20),
      splashColor: colors.text1.withOpacity(0.1),
      highlightColor: colors.text1.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        decoration: ShapeDecoration(
          color: isSelected ? colors.accentMid : colors.card,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colors.border),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: colors.text1,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityCard(Community community) {
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
                  community.name,
                  style: TextStyle(
                    color: colors.text1,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.spacingXxs),
                Text(
                  community.address,
                  style: TextStyle(
                    color: colors.text2,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _openMap(community.mapUrl),
            icon: Icon(
              Icons.location_on,
              color: colors.accent,
              size: AppTheme.iconMain,
            ),
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
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
