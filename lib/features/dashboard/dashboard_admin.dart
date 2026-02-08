import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Catatan: Pastikan kamu sudah memiliki file atau class PenggunaPage() 
// atau ganti sementara ke Container() agar tidak error.

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int _currentIndex = 0;
  final Color primaryColor = const Color(0xFF4A6572);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Header Biru Gelap ---
            Container(
              padding: const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 40),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                  const Text(
                    "BERANDA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Divider(color: Colors.white, thickness: 2, endIndent: 220),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- Bagian Grafik Peminjaman ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Peminjaman Minggu Ini",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 250,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 10,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
                                if (value.toInt() >= 0 && value.toInt() < days.length) {
                                  return Text(days[value.toInt()], 
                                    style: const TextStyle(color: Colors.white, fontSize: 10));
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.white.withOpacity(0.2),
                            strokeWidth: 1,
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          _makeGroupData(0, 10),
                          _makeGroupData(1, 3),
                          _makeGroupData(2, 2),
                          _makeGroupData(3, 4),
                          _makeGroupData(4, 6),
                          _makeGroupData(5, 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- Grid Statistik ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.6,
                children: [
                  _buildStatCard("5", "Pengguna", Icons.person_outline),
                  _buildStatCard("3", "Aktivitas", Icons.history),
                  _buildStatCard("3", "Alat", Icons.business_center_outlined),
                  _buildStatCard("4", "Peminjaman", Icons.sell_outlined),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // --- PERBAIKAN: BottomNavigationBar sekarang berada di dalam Scaffold ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Logika navigasi bisa ditambahkan di sini
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Pengguna"),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: "Alat"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Kategori"),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: "Peminjaman"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_return), label: "Pengembalian"),
        ],
      ),
    );
  }

  // Widget Helper tetap di dalam State class
  Widget _buildStatCard(String count, String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A6572),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(count, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          Icon(icon, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.white,
          width: 20,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}