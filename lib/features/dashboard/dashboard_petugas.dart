import 'package:alat_1/features/laporan_petugas/laporan.dart';
import 'package:alat_1/features/pengembalian_petugas/pengembalianp.dart';
import 'package:flutter/material.dart';
import 'package:alat_1/features/peminjaman_petugas/peminjamanp.dart';

class DashboardPetugasPage extends StatelessWidget {
  const DashboardPetugasPage({super.key});


void _onNavTap(BuildContext context, int index) {
  if (index == 0) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) {
        switch (index) {
          case 1:
            return const PeminjamanPetugasPage();
          case 2:
            return const PengembalianPetugasPage();
          case 3:
            return const LaporanPage();
          default:
            return const DashboardPetugasPage();
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
              width: double.infinity,
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
                    'Petugas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Color(0xFF3F5F73)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== MENU UTAMA =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: const [
                  MenuCard(
                    icon: Icons.assignment,
                    title: 'Permintaan Peminjaman',
                  ),
                  MenuCard(
                    icon: Icons.assignment_return,
                    title: 'Pengembalian barang',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== STAT =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.4,
                children: const [
                  StatCard(title: '15', subtitle: 'Alat Tersedia'),
                  StatCard(title: '5', subtitle: 'Alat Dipinjam'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== DAFTAR =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daftar Peminjaman alat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6ECEF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView(
                  children: const [
                    PeminjamanTile(
                      initial: 'D',
                      name: 'Devi Dwi',
                      alat: 'Epson',
                    ),
                    PeminjamanTile(
                      initial: 'A',
                      name: 'Devi Dwi',
                      alat: 'Epson',
                    ),
                    PeminjamanTile(
                      initial: 'A',
                      name: 'Devi Dwi',
                      alat: 'Epson',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ===== NAVBAR =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF3F5F73),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _onNavTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Peminjaman',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_return),
            label: 'Pengembalian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Laporan',
          ),
        ],
      ),
    );
  }
}

// ===== MENU CARD =====
class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3F5F73),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 36),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ===== STAT CARD =====
class StatCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const StatCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3F5F73),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

// ===== LIST TILE =====
class PeminjamanTile extends StatelessWidget {
  final String initial;
  final String name;
  final String alat;

  const PeminjamanTile({
    super.key,
    required this.initial,
    required this.name,
    required this.alat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFBFC9D1),
            child: Text(initial),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(alat, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF3F5F73),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Proses',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
