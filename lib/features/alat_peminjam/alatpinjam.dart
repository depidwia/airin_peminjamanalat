import 'package:flutter/material.dart';

// IMPORT HALAMAN
import 'package:alat_1/features/dashboard/dashboard_peminjam.dart';
import 'package:alat_1/features/pinjam_peminjam/pinjam.dart';
import 'package:alat_1/features/pengajuan_peminjam/pengajuan.dart';
import 'package:alat_1/features/kembali_peminjam/kembali.dart';

class AlatPinjamPage extends StatelessWidget {
  const AlatPinjamPage({super.key});

  void _onNavTap(BuildContext context, int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const DashboardPeminjamPage();
        break;
      case 1:
        return; // sudah di halaman alat
      case 2:
        page = const PinjamPage();
        break;
      case 3:
        page = const PengajuanPage();
        break;
      case 4:
        page = const PengembalianPeminjamPage(); // ganti nanti halaman laporan
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
                    'Alat',
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Alat',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== FILTER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  FilterChipItem(label: 'Proyektor', isActive: true),
                  SizedBox(width: 8),
                  FilterChipItem(label: 'Speaker'),
                  SizedBox(width: 8),
                  FilterChipItem(label: 'Stop Kontak'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== GRID ALAT =====
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                  children: const [
                    AlatCard(
                      name: 'EPSON',
                      stock: 5,
                      image: 'assets/images/epson.png',
                    ),
                    AlatCard(
                      name: 'ACER',
                      stock: 5,
                      image: 'assets/images/acer.png',
                    ),
                    AlatCard(
                      name: 'NOTOR',
                      stock: 5,
                      image: 'assets/images/notor.png',
                    ),
                    AlatCard(
                      name: 'BENQ',
                      stock: 5,
                      image: 'assets/images/benq.png',
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
        currentIndex: 1,
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

// ===== FILTER CHIP =====
class FilterChipItem extends StatelessWidget {
  final String label;
  final bool isActive;

  const FilterChipItem({
    super.key,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.shade400 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

// ===== CARD ALAT =====
class AlatCard extends StatelessWidget {
  final String name;
  final int stock;
  final String image;

  const AlatCard({
    super.key,
    required this.name,
    required this.stock,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD7DDE2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(image, fit: BoxFit.contain),
              ),
              const SizedBox(height: 6),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3F5F73),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Tersedia : $stock',
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ),
        ),

        // ===== BUTTON PLUS =====
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF3F5F73),
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
