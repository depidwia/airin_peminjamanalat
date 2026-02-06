import 'package:flutter/material.dart';

class DashboardPetugas extends StatelessWidget {
  const DashboardPetugas({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF405D72);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [

            /// HEADER
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),

            /// CONTENT
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 30),

                  /// TITLE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Petugas",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 40),

                  /// GRID MENU
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.2,
                    children: const [

                      _MenuCard(
                        icon: Icons.assignment,
                        label: "Permintaan Peminjaman",
                      ),

                      _MenuCard(
                        icon: Icons.assignment_return,
                        label: "Pengembalian barang",
                      ),

                      _MenuCard(
                        icon: Icons.build,
                        label: "15\nAlat Tersedia",
                      ),

                      _MenuCard(
                        icon: Icons.inventory,
                        label: "5\nAlat Dipinjam",
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// LIST TITLE
                  const Text(
                    "Daftar Peminjaman alat",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// LIST CARD
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: const [
                        _ListItem(initial: "D"),
                        _ListItem(initial: "A"),
                        _ListItem(initial: "A"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),

      /// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Peminjaman",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: "Pengembalian",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file),
            label: "Laporan",
          ),
        ],
      ),
    );
  }
}

/// MENU CARD
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MenuCard({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF405D72);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 40),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// LIST ITEM
class _ListItem extends StatelessWidget {
  final String initial;

  const _ListItem({required this.initial});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF405D72);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [

          /// AVATAR
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Text(
              initial,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// NAME
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Devi Dwi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Epson",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          /// BUTTON
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onPressed: null,
            child: Text("Proses"),
          ),
        ],
      ),
    );
  }
}
