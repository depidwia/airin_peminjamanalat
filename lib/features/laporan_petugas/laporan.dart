import 'package:alat_1/features/dashboard/dashboard_petugas.dart';
import 'package:alat_1/features/peminjaman_petugas/peminjamanp.dart';
import 'package:alat_1/features/pengembalian_petugas/pengembalianp.dart';
import 'package:flutter/material.dart';

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});


void _onNavTap(BuildContext context, int index) {
  if (index == 3) return; // ✅ sudah di laporan

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) {
        switch (index) {
          case 0:
            return const DashboardPetugasPage();
          case 1:
            return const PeminjamanPetugasPage();
          case 2:
            return const PengembalianPetugasPage();
          default:
            return const LaporanPage();
        }
      },
    ),
  );
}

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
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Laporan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.person, color: Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ===== CARD LAPORAN =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFD7DDE2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.description,
                      size: 50,
                      color: Colors.black54,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Laporan Aktivitas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Rekapan Peminjaman &\nPengembalian Alat',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F5F73),
                        minimumSize: const Size(140, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Cetak Laporan',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ===== BOTTOM NAV =====
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: const Color(0xFF3F5F73),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _onNavTap(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz), label: 'Peminjaman'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_return), label: 'Pengembalian'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Laporan'),
        ],
      ),
    );
  }
}
