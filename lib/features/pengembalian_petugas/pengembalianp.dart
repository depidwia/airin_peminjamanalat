import 'package:alat_1/features/dashboard/dashboard_petugas.dart';
import 'package:alat_1/features/laporan_petugas/laporan.dart';
import 'package:flutter/material.dart';
import 'package:alat_1/features/pengembalian_petugas/konfirmasi.dart';
import 'package:alat_1/features/peminjaman_petugas/peminjamanp.dart';

class PengembalianPetugasPage extends StatelessWidget {
  const PengembalianPetugasPage({super.key});


 void _onNavTap(BuildContext context, int index) {
  if (index == 2) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) {
        switch (index) {
          case 0:
            return const DashboardPetugasPage();
          case 1:
            return const PeminjamanPetugasPage();
          case 3:
            return const LaporanPage();
          default:
            return const PengembalianPetugasPage();
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
                    'Pengembalian',
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

            const SizedBox(height: 12),

            // ===== SEARCH =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, size: 18),
                    hintText: 'Cari Pengguna',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== LIST =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  PengembalianCard(
                    status: 'Konfirmasi pengembalian',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const KonfirmasiPengembalianPage(hasDenda: false),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  PengembalianCard(
                    status: 'Konfirmasi pengembalian terlambat',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const KonfirmasiPengembalianPage(hasDenda: true),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  PengembalianCard(
                    status: 'Konfirmasi pengembalian selesai',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ===== BOTTOM NAV =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFF3F5F73),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _onNavTap(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Peminjaman'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_return), label: 'Pengembalian'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Laporan'),
        ],
      ),
    );
  }
}

// ===== CARD =====
class PengembalianCard extends StatelessWidget {
  final String status;
  final VoidCallback onTap;

  const PengembalianCard({
    super.key,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFD7DDE2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(child: Icon(Icons.person)),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bagus Wahyu',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Proyektor', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            const Row(
              children: [
                Icon(Icons.calendar_month, size: 14),
                SizedBox(width: 4),
                Text(
                  '1 Januari 2026 - 10 Januari 2026',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF3F5F73),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
