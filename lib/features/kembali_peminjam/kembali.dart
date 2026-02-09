import 'package:flutter/material.dart';
import 'package:alat_1/features/kembali_peminjam/bayar.dart';
import 'package:alat_1/features/dashboard/dashboard_peminjam.dart';
import 'package:alat_1/features/alat_peminjam/alatpinjam.dart';
import 'package:alat_1/features/pengajuan_peminjam/pengajuan.dart';
import 'package:alat_1/features/pinjam_peminjam/pinjam.dart';
class PengembalianPeminjamPage extends StatelessWidget {
  const PengembalianPeminjamPage({super.key});

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
        page = const PinjamPage();
        break;
      case 3:
        page = const PengajuanPage();
        break;
      case 4:
        return; // sudah di halaman Pengembalian
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

            const SizedBox(height: 16),

            // ===== LIST =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  PengembalianCard(
                    name: 'Bagus Saputra',
                    alat: 'ANKER',
                    kategori: 'Speaker',
                    tanggal: '14 - 16 Januari 2026',
                    status: 'Denda',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BayarDendaPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  PengembalianCard(
                    name: 'Bagus Saputra',
                    alat: 'ACER',
                    kategori: 'Proyektor',
                    tanggal: '14 - 16 Januari 2026',
                    status: 'Kembalikan',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
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


    
  


// ===== CARD =====
class PengembalianCard extends StatelessWidget {
  final String name;
  final String alat;
  final String kategori;
  final String tanggal;
  final String status;
  final VoidCallback onPressed;

  const PengembalianCard({
    super.key,
    required this.name,
    required this.alat,
    required this.kategori,
    required this.tanggal,
    required this.status,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD7DDE2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('$alat\n$kategori', style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            tanggal,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F5F73),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                status,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
