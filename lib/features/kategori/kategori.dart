import 'package:flutter/material.dart';

class KategoriPage extends StatelessWidget {
  // Data dummy untuk daftar kategori
  final List<Map<String, String>> categories = [
    {
      "title": "Speaker",
      "desc": "Speaker portabel dengan koneksi Bluetooth untuk memutar audio secara nirkabel.",
      "image": "assets/speaker.png"
    },
    {
      "title": "Proyektor",
      "desc": "Alat untuk menampilkan gambar atau presentasi ke layar besar.",
      "image": "assets/proyektor.png"
    },
    {
      "title": "Stop Kontak",
      "desc": "Alat untuk membagi sumber listrik ke beberapa perangkat elektronik.",
      "image": "assets/stop_kontak.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Biru
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
            decoration: BoxDecoration(
              color: Color(0xFF4A6572), // Warna sesuai gambar
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daftar Kategori",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.account_circle, color: Colors.white, size: 40),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari kategori",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),

          // List Kategori
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  title: categories[index]['title']!,
                  desc: categories[index]['desc']!,
                );
              },
            ),
          ),

          // Tombol Tambah
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF4A6572), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: Text("Tambah", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF4A6572),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Pengguna"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Kategori"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Peminjaman"),
        ],
      ),
    );
  }
}

// Widget untuk Card Kategori
class CategoryCard extends StatelessWidget {
  final String title;
  final String desc;

  CategoryCard({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFCFD8DC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Placeholder Gambar
          Container(width: 80, height: 80, color: Colors.grey[400], child: Icon(Icons.image)),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(desc, style: TextStyle(fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Column(
            children: [
              Icon(Icons.edit, size: 20),
              SizedBox(height: 10),
              Icon(Icons.delete, size: 20),
            ],
          )
        ],
      ),
    );
  }
}