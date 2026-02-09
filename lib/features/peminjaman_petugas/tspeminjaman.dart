import 'package:flutter/material.dart';

class PeminjamanStatusPetugasPage extends StatelessWidget {
  const PeminjamanStatusPetugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER =====
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF3F5F73),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Peminjaman',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.person, color: Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ===== SEARCH =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Cari Pengguna',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== LIST =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  StatusCard(
                    text: 'Peminjaman Disetujui',
                    color: Color(0xFF3F5F73),
                  ),
                  SizedBox(height: 12),
                  StatusCard(
                    text: 'Peminjaman Ditolak',
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),

      // ===== NAVBAR =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF3F5F73),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Peminjaman'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_return), label: 'Pengembalian'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Laporan'),
        ],
      ),
    );
  }
}

// ===== STATUS CARD =====
class StatusCard extends StatelessWidget {
  final String text;
  final Color color;

  const StatusCard({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD7DDE2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Bagus Wahyu\nProyektor\n11 januari 2026 - 10 januari 2026',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
