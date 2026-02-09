import 'package:flutter/material.dart'; 
import 'package:alat_1/features/alat_peminjam/alatpinjam.dart';
import 'package:alat_1/features/kembali_peminjam/kembali.dart';
import 'package:alat_1/features/pengajuan_peminjam/pengajuan.dart';
import 'package:alat_1/features/dashboard/dashboard_peminjam.dart';
class PinjamPage extends StatelessWidget {
  const PinjamPage({super.key});

  void _onNavTap(BuildContext context, int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const DashboardPeminjamPage();
        break;
      case 1:
        page = const AlatPinjamPage();
        break;
      case 2:
        return; // sudah di halaman Pinjam
      case 3:
        page = const PengajuanPage();
        break;
      case 4:
        page = const PengembalianPeminjamPage(); // sementara laporan
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
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
                    'Pinjaman',
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

            const SizedBox(height: 20),

            // ===== LIST PINJAMAN =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  PinjamCard(
                    image: 'assets/images/anker.png',
                    nama: 'Bagus Saputra',
                    alat: 'ANKER',
                    jenis: 'Speaker',
                    tanggal: '14–16 Januari 2026',
                    status: 'Menunggu',
                    statusColor: Color(0xFF7A8C99),
                  ),
                  SizedBox(height: 12),
                  PinjamCard(
                    image: 'assets/images/acer.png',
                    nama: 'Bagus Saputra',
                    alat: 'ACER',
                    jenis: 'Proyektor',
                    tanggal: '14–16 Januari 2026',
                    status: 'Disetujui',
                    statusColor: Color(0xFF3F5F73),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ===== BOTTOM NAVIGATION =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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

// ===== CARD PINJAMAN =====
class PinjamCard extends StatelessWidget {
  final String image;
  final String nama;
  final String alat;
  final String jenis;
  final String tanggal;
  final String status;
  final Color statusColor;

  const PinjamCard({
    super.key,
    required this.image,
    required this.nama,
    required this.alat,
    required this.jenis,
    required this.tanggal,
    required this.status,
    required this.statusColor,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, width: 60),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  alat,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  jenis,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      tanggal,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
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
