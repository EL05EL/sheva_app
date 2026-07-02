import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF290D36),
                        child:
                            Icon(Icons.person, color: Colors.white, size: 24),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/profile'),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Famuh24_',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
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
              // Carousel Statistik
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildStatCard(
                      '376.529',
                      'Kasus KBG (2025)',
                      'Komnas Perempuan CATAHU 2025',
                      const Color(0xB2FF0909),
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      '8.543',
                      'Pengaduan KBGO (2025)',
                      'Komnas Perempuan CATAHU 2025',
                      const Color(0xB2005DFF),
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      '15-19 Tahun',
                      'Usia Korban KBGO Terbanyak',
                      'SPHPN 2024',
                      const Color(0xB2FF6B09),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Grid Menu
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
                      'SHEVA Shield',
                      'Darurat & Keselamatan',
                      const Color(0xFFD90000),
                      '/shield',
                      context,
                    ),
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
                    _buildMenuCard(
                      'SOS',
                      'Darurat & Keselamatan',
                      const Color(0x7FFF0C0C),
                      '/shield',
                      context,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VISI SHEVA',
                      style: TextStyle(
                        color: Color(0xFF9B89EC),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '"Mewujudkan masyarakat yang setara, adil, dan bebas dari kekerasan berbasis gender - dimana setiap individu dapat hidup dengan martabat dan aman."',
                      style: TextStyle(
                        color: Color(0xFF919191),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jika dalam bahaya sekarang, hubungi SAPA 129 atau polisi 110',
                      style: TextStyle(
                        color: Color(0xFF919191),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/shield'),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const ShapeDecoration(
                          color: Color(0x7FFF0C0C),
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                        child: const Icon(Icons.sos,
                            color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String subtitle, String source, Color color) {
    return Container(
      width: 280,
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
          // ignore: deprecated_member_use
          color: color.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            // ignore: deprecated_member_use
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
}
