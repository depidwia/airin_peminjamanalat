import 'package:flutter/material.dart';

import 'package:alat_1/features/alat_peminjam/alatpinjam.dart';
import 'package:alat_1/features/pinjam_peminjam/pinjam.dart';
import 'package:alat_1/features/pengajuan_peminjam/pengajuan.dart';
import 'package:alat_1/features/kembali_peminjam/kembali.dart';

class DashboardPeminjamPage extends StatelessWidget {
  const DashboardPeminjamPage({super.key}); 

  

  void _onNavTap(BuildContext context, int index) {
    if (index == 0) return;

    Widget targetPage;

    switch (index) {
      case 1:
        targetPage = const AlatPinjamPage();
        break;
      case 2:
        targetPage = const PinjamPage();
        break;
      case 3:
        targetPage = const PengajuanPage();
        break;
      case 4:
        targetPage = const PengembalianPeminjamPage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => targetPage),
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
                children: [
                  const Text(
                    'Peminjam',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: Color(0xFF3F5F73)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== STATISTIC =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  StatCard(title: 'Pengguna Aktif', value: '3'),
                  StatCard(title: 'Jumlah Alat', value: '10'),
                  StatCard(title: 'Alat Tersedia', value: '12'),
                  StatCard(title: 'Alat Dipinjam', value: '7'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== RIWAYAT =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Riwayat Peminjaman',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  HistoryTile(
                    initial: 'D',
                    name: 'Devi Dwi',
                    date: '10 Januari 2026',
                  ),
                  HistoryTile(
                    initial: 'A',
                    name: 'Adella W',
                    date: '10 Januari 2026',
                  ),
                  HistoryTile(
                    initial: 'A',
                    name: 'Ardiansyah',
                    date: '10 Januari 2026',
                  ),
                ],
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
            icon: Icon(Icons.inventory_2),
            label: 'Alat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Pinjam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Pengajuan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Laporan',
          ),
        ],
      ),
    );
  }
}

// ===== STAT CARD =====
class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3F5F73),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ===== HISTORY TILE =====
class HistoryTile extends StatelessWidget {
  final String initial;
  final String name;
  final String date;

  const HistoryTile({
    super.key,
    required this.initial,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF3F5F73),
          child: Text(initial, style: const TextStyle(color: Colors.white)),
        ),
        title: Text(name),
        subtitle: Text(date),
      ),
    );
  }
}
