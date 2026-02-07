import 'package:flutter/material.dart';

class PeminjamanPage extends StatelessWidget {
  // Data dummy untuk list
  final List<Map<String, String>> dataPeminjaman = [
    {"nama": "Azzuraa", "alat": "Speaker", "tgl": "10 januari 2026", "kembali": "15 januari 2026", "status": "Dipinjam"},
    {"nama": "Azzuraa", "alat": "Speaker", "tgl": "10 januari 2026", "kembali": "", "status": "Dipinjam"},
    {"nama": "Azzuraa", "alat": "Speaker", "tgl": "10 januari 2026", "kembali": "", "status": "Dipinjam"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4A657A), // Background biru tua bagian bawah
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(25),
              color: Color(0xFF4A657A),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Data Peminjaman", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  Icon(Icons.account_circle, color: Colors.white, size: 45),
                ],
              ),
            ),
            
            // Konten Putih dengan Rounded Corner
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    // Search Bar
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Cari Alat",
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Color(0xFFE0E0E0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    // List Data
                    Expanded(
                      child: ListView.builder(
                        itemCount: dataPeminjaman.length,
                        itemBuilder: (context, index) {
                          return _buildCardPeminjaman(dataPeminjaman[index]);
                        },
                      ),
                    ),
                    
                    // Tombol Tambah
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF4A657A)),
                        onPressed: () {},
                        child: Text("Tambah", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF4A657A),
        unselectedItemColor: Colors.grey,
        currentIndex: 4, // Index Peminjaman
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Pengguna"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Alat"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Kategori"),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: "Peminjaman"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_return), label: "Pengembalian"),
        ],
      ),
    );
  }

  Widget _buildCardPeminjaman(Map<String, String> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFDDE2E6),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.person_outline, size: 40),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['nama']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text("Alat : ${data['alat']}"),
                Text("Dipinjam : ${data['tgl']}"),
                if (data['kembali'] != "") Text("kembali : ${data['kembali']}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.delete_outline, size: 20),
                    SizedBox(width: 10),
                    Icon(Icons.edit_outlined, size: 20),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Color(0xFF4A657A), borderRadius: BorderRadius.circular(5)),
            child: Text(data['status']!, style: TextStyle(color: Colors.white, fontSize: 10)),
          )
        ],
      ),
    );
  }
}