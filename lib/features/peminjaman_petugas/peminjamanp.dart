import 'package:alat_1/features/dashboard/dashboard_petugas.dart';
import 'package:alat_1/features/laporan_petugas/laporan.dart';
import 'package:alat_1/features/pengembalian_petugas/pengembalianp.dart';
import 'package:flutter/material.dart';

class PeminjamanPetugasPage extends StatelessWidget {
  const PeminjamanPetugasPage({super.key});


void _onNavTap(BuildContext context, int index) {
  if (index == 1) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) {
        switch (index) {
          case 0:
            return const DashboardPetugasPage();
          case 2:
            return const PengembalianPetugasPage();
          case 3:
            return const LaporanPage();
          default:
            return const PeminjamanPetugasPage();
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

            // ===== TITLE =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menunggu Persetujuan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ===== LIST =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  PeminjamanCardPending(),
                  SizedBox(height: 12),
                  PeminjamanCardPending(),
                  SizedBox(height: 12),
                  PeminjamanCardPending(),
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
        onTap: (index) => _onNavTap(context, index),
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

// ===== CARD PENDING =====
class PeminjamanCardPending extends StatelessWidget {
  const PeminjamanCardPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD7DDE2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.person),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bagus Wahyu', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Proyektor', style: TextStyle(fontSize: 12)),
                    SizedBox(height: 4),
                    Text(
                      '11 januari 2026 - 10 januari 2026',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Tolak', style: TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F5F73),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Setujui', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
