import 'package:flutter/material.dart';

class LoginPage3 extends StatelessWidget {
  const LoginPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF290D36),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                // LOGO
                Container(
                  width: 148,
                  height: 148,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: NetworkImage('https://placehold.co/148x148'),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'SHEVA hadir dengan',
                  style: TextStyle(
                    color: Color(0xFF9B89EC),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Informasi ini hanya tersimpan di perangkat Anda dan tidak dikirim ke mana pun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF7E7981),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),
                // Fitur 1
                _buildFeatureItem(
                  'Perlindungan',
                  'SHEVA hadir sebagai pelindung - memberikan akses cepat ke bantuan darurat dan pelaporan',
                ),
                const SizedBox(height: 16),
                // Fitur 2
                _buildFeatureItem(
                  'Edukasi',
                  'Pengetahuan adalah kekuatan. Pelajari hak-hak Anda dan bantu wujudkan kesetaraan',
                ),
                const SizedBox(height: 16),
                // Fitur 3
                _buildFeatureItem(
                  'Komunitas',
                  'Bersama kita lebih kuat. Bergabunglah dengan gerakan For She, For He, For All.',
                ),
                const SizedBox(height: 24),
                // Tagline
                const Text(
                  '"For She, For He, For All"',
                  style: TextStyle(
                    color: Color(0xFF744AC1),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Bergabunglah bersama ribuan individu yang memperjuangkan kesetaraan gender di Indonesia!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF837F98),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                // Tombol Mulai Perjalanan
                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF270F32),
                      foregroundColor: const Color(0xFFF5F6FB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xFF2A283E)),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Mulai Perjalanan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      color: Color(0xFF918DAE),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFF240D2F),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF2A283E)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF4E2B7B),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF837F98),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
