import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

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
      color: Color(0xB2FF0909),
    ),
    StatCardData(
      title: '8.543',
      subtitle: 'Pengaduan KBGO (2025)',
      source: 'Komnas Perempuan CATAHU 2025',
      color: Color(0xB2005DFF),
    ),
    StatCardData(
      title: '15-19 Tahun',
      subtitle: 'Usia Korban KBGO Terbanyak',
      source: 'SPHPN 2024',
      color: Color(0xB2FF6B09),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll setiap 4 detik
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
      backgroundColor: const Color(0xFF290D36),
      floatingActionButton: _buildSOSButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF493370),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFF290D36),
                        backgroundImage: userProvider.profileImagePath != null
                            ? FileImage(File(userProvider.profileImagePath!))
                            : null,
                        child: userProvider.profileImagePath == null
                            ? const Icon(Icons.person,
                                color: Colors.white, size: 24)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/profile'),
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
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none,
                              color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.more_vert, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // ===== CAROUSEL STATISTIK (AUTO-SCROLL) =====
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: _statCards.length,
                      itemBuilder: (context, index) {
                        final card = _statCards[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildStatCard(
                            card.title,
                            card.subtitle,
                            card.source,
                            card.color,
                          ),
                        );
                      },
                    ),
                    // Indikator dot
                    Positioned(
                      bottom: 4,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _statCards.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 24 : 8,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? const Color(0xFF9B89EC)
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
              const SizedBox(height: 16),
              // ===== SHEVA SHIELD - FULL WIDTH CARD =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/shield'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD90000).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
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
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
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
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Grid Menu (4 item: Report, Learn, Map, Circle)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                  children: [
                    _buildMenuCard(
                      'SHEVA Report',
                      'Laporan anonim KBG/O',
                      const Color(0xFF5139BE),
                      '/report',
                      context,
                    ),
                    _buildMenuCard(
                      'SHEVA Learn',
                      'Edukasi gender equality',
                      const Color(0xFF00829F),
                      '/learn',
                      context,
                    ),
                    _buildMenuCard(
                      'SHEVA Map',
                      'Layanan bantuan terdekat',
                      const Color(0xFFCB338F),
                      '/map',
                      context,
                    ),
                    _buildMenuCard(
                      'SHEVA Circle',
                      'HeForShe - sekutu setara',
                      const Color(0xFF744AC1),
                      '/circle',
                      context,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // VISI SHEVA
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: const Color(0xFF240D2F),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF2A283E)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VISI SHEVA',
                      style: TextStyle(
                        color: Color(0xFF9B89EC),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '"Mewujudkan masyarakat yang setara, adil, dan bebas dari kekerasan berbasis gender - dimana setiap individu dapat hidup dengan martabat dan aman."',
                      style: TextStyle(
                        color: Color(0xFF919191),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '- Equality is not women\'s issue. It\'s a human issue.',
                      style: TextStyle(
                        color: Color(0xFF919191),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Footer
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: const Text(
                  'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                  style: TextStyle(
                    color: Color(0xFF919191),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String subtitle, String source, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0x7F744AC1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            source,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, String subtitle, Color color,
      String route, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          color: color.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.white.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
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
