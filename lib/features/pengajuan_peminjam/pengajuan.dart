import 'package:flutter/material.dart';
import 'package:alat_1/features/pengajuan_peminjam/dtpengajuan.dart';
import 'package:alat_1/features/alat_peminjam/alatpinjam.dart';
import 'package:alat_1/features/kembali_peminjam/kembali.dart';
import 'package:alat_1/features/pinjam_peminjam/pinjam.dart';
import 'package:alat_1/features/dashboard/dashboard_peminjam.dart';

class PengajuanPage extends StatelessWidget {
  const PengajuanPage({super.key});


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
        return; // sudah di halaman Pengajuan
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
                    'Pengajuan',
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

            // ===== LIST ALAT =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _alatItem(
                    context,
                    image: 'assets/images/anker.png',
                    name: 'ANKER',
                    type: 'Speaker',
                  ),
                  const SizedBox(height: 12),
                  _alatItem(
                    context,
                    image: 'assets/images/acer.png',
                    name: 'ACER',
                    type: 'Proyektor',
                  ),
                ],
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


  Widget _alatItem(
    BuildContext context, {
    required String image,
    required String name,
    required String type,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD7DDE2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Image.asset(image, width: 60),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(type, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PengajuanDetailPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3F5F73),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ajukan Peminjaman',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
