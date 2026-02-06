import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardPeminjam extends StatefulWidget {
  const DashboardPeminjam({super.key});

  @override
  State<DashboardPeminjam> createState() => _DashboardPeminjamState();
}

class _DashboardPeminjamState extends State<DashboardPeminjam> {
  final supabase = Supabase.instance.client;

  // Fungsi logout yang aman
  Future<void> signOut() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5B5B5), // Warna background sesuai desain
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER SECTION ---
            Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Color(0xFFD48F9F), // Warna pink gelap header
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(35)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "KulinaRent",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Dashboard Peminjam",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: signOut,
                    icon: const Icon(Icons.account_circle, size: 35, color: Colors.black87),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- STATISTICS GRID ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildStatCard("Alat Tersedia", "10", Colors.pink),
                  _buildStatCard("Sedang Dipinjam", "2", Colors.pink),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- HISTORY SECTION ---
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Riwayat Peminjaman Anda:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildHistoryItem("Peminjaman 02", "10.34 20 Januari 2026", true),
                          _buildHistoryItem("Peminjaman 01", "08.20 15 Januari 2026", true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFD48F9F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.handyman), label: 'Alat'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Pengajuan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Kembali'),
        ],
      ),
    );
  }

  // Widget Helper untuk Kartu Statistik
  Widget _buildStatCard(String title, String count, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            count,
            style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Item Riwayat
  Widget _buildHistoryItem(String title, String date, bool isSuccess) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle_outline : Icons.pending_outlined,
            color: Colors.green,
            size: 30,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}