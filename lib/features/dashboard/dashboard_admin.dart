import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int _currentIndex = 0;
  final Color primaryColor = const Color(0xFF4A6572);

  // Fungsi untuk berpindah halaman konten
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildBerandaContent(); // Konten Beranda asli kamu
      case 1:
        return  PenggunaPage(); // Halaman Pengguna yang baru
      default:
        return _buildBerandaContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Body sekarang dinamis mengikuti index navbar
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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

  // --- KONTEN BERANDA ASLI (UI TIDAK BERUBAH) ---
  Widget _buildBerandaContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
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
    );
  }

  // --- WIDGET HELPER ---
  Widget _buildStatCard(String count, String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
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

// --- HALAMAN PENGGUNA (CRUD) ---
class PenggunaPage extends StatelessWidget {
   PenggunaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF4A6572);

    return Column(
      children: [
        // Header Pengguna (Desain disamakan dengan Beranda)
        Container(
          padding: const EdgeInsets.only(top: 60, left: 25, right: 25, bottom: 40),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DATA PENGGUNA",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Divider(color: Colors.white, thickness: 2, endIndent: 200),
            ],
          ),
        ),
        
        // Contoh List Pengguna (CRUD)
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: 5, // Ganti dengan data asli nanti
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text("User Nama $index"),
                  subtitle: const Text("Role: Admin/Peminjam"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {}),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}