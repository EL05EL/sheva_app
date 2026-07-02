import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../providers/settings_provider.dart';
import '../widgets/sos_button.dart';
import '../widgets/stat_card.dart';
import '../widgets/menu_grid_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<StatCardData> _statCards = [
    StatCardData(
      title: '376.529',
      subtitle: 'Kasus KBG (2025)',
      source: 'Komnas Perempuan CATAHU 2025',
      color: const Color(0xB2FF0909),
    ),
    StatCardData(
      title: '8.543',
      subtitle: 'Pengaduan KBGO (2025)',
      source: 'Komnas Perempuan CATAHU 2025',
      color: const Color(0xB2005DFF),
    ),
    StatCardData(
      title: '15-19 Tahun',
      subtitle: 'Usia Korban KBGO Terbanyak',
      source: 'SPHPN 2024',
      color: const Color(0xB2FF6B09),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1) % _statCards.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: const SosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                  vertical: AppTheme.spacingSm,
                ),
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppTheme.spacingXl),
                    bottomRight: Radius.circular(AppTheme.spacingXl),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      borderRadius: BorderRadius.circular(20),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppTheme.background,
                        backgroundImage: userProvider.profileImagePath != null
                            ? FileImage(File(userProvider.profileImagePath!))
                            : null,
                        child: userProvider.profileImagePath == null
                            ? const Icon(Icons.person,
                                color: Colors.white, size: AppTheme.iconMain)
                            : null,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingSm),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, '/profile'),
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Halo!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              userProvider.userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'For She, For He, For All.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Popup Menu
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert,
                          color: Colors.white, size: AppTheme.iconMain),
                      onSelected: (value) {
                        if (value == 'settings') {
                          Navigator.pushNamed(context, '/settings');
                        } else if (value == 'privacy') {
                          Navigator.pushNamed(context, '/privacy');
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem<String>(
                          value: 'settings',
                          child: Text('Pengaturan'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'privacy',
                          child: Text('Kebijakan Privasi'),
                        ),
                      ],
                      padding: const EdgeInsets.all(AppTheme.spacingXs),
                      constraints: const BoxConstraints(
                        minWidth: AppTheme.touchTarget,
                        minHeight: AppTheme.touchTarget,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              // Carousel Statistik
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemCount: _statCards.length,
                      itemBuilder: (context, index) {
                        final card = _statCards[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingMd),
                          child: StatCard(
                            title: card.title,
                            subtitle: card.subtitle,
                            source: card.source,
                            color: card.color,
                          ),
                        );
                      },
                    ),
                    // Indikator dot
                    Positioned(
                      bottom: AppTheme.spacingXxs,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _statCards.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: AppTheme.spacingXxs),
                            width: _currentPage == index ? 24 : 8,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? AppTheme.secondary
                                  : Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              // SHEVA Shield
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/shield'),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  splashColor: Colors.white.withOpacity(0.1),
                  highlightColor: Colors.white.withOpacity(0.05),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.spacingLg,
                      horizontal: AppTheme.spacingMd,
                    ),
                    decoration: ShapeDecoration(
                      color: AppTheme.dangerDark.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shield,
                            color: Colors.white,
                            size: AppTheme.iconLarge,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SHEVA Shield',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                'Darurat & Keselamatan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: AppTheme.iconLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              // Grid Menu
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: AppTheme.spacingSm,
                  mainAxisSpacing: AppTheme.spacingSm,
                  childAspectRatio: 1.2,
                  children: const [
                    MenuGridCard(
                      title: 'SHEVA Report',
                      subtitle: 'Laporan anonim KBG/O',
                      color: Color(0xFF5139BE),
                      route: '/report',
                    ),
                    MenuGridCard(
                      title: 'SHEVA Learn',
                      subtitle: 'Edukasi gender equality',
                      color: Color(0xFF00829F),
                      route: '/learn',
                    ),
                    MenuGridCard(
                      title: 'SHEVA Map',
                      subtitle: 'Layanan bantuan terdekat',
                      color: Color(0xFFCB338F),
                      route: '/map',
                    ),
                    MenuGridCard(
                      title: 'SHEVA Circle',
                      subtitle: 'HeForShe - sekutu setara',
                      color: Color(0xFF744AC1),
                      route: '/circle',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              // Visi
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                decoration: AppTheme.cardDecoration(
                  color: AppTheme.surface,
                  borderColor: AppTheme.borderDefault,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VISI SHEVA',
                      style: TextStyle(
                        color: AppTheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXs),
                    const Text(
                      '"Mewujudkan masyarakat yang setara, adil, dan bebas dari kekerasan berbasis gender - dimana setiap individu dapat hidup dengan martabat dan aman."',
                      style: TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXs),
                    const Text(
                      '- Equality is not women\'s issue. It\'s a human issue.',
                      style: TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              // Footer
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                  vertical: AppTheme.spacingSm,
                ),
                child: const Text(
                  'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                  style: AppTheme.tiny,
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

// Data class untuk stat card
class StatCardData {
  final String title;
  final String subtitle;
  final String source;
  final Color color;

  StatCardData({
    required this.title,
    required this.subtitle,
    required this.source,
    required this.color,
  });
}
