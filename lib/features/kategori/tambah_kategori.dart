import 'package:flutter/material.dart';

class TambahKategoriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4A657A), // Warna biru keabuan sesuai gambar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Tambah Kategori", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Placeholder untuk upload gambar
            Center(
              child: Icon(Icons.add_photo_alternate_outlined, size: 100, color: Colors.black87),
            ),
            SizedBox(height: 30),
            
            // Input Nama Kategori
            Align(alignment: Alignment.centerLeft, child: Text("Nama Kategori", style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "Masukkan Kategori",
                filled: true,
                fillColor: Color(0xFFDDE2E6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            
            SizedBox(height: 20),

            // Input Deskripsi
            Align(alignment: Alignment.centerLeft, child: Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(height: 8),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Masukkan Deskripsi",
                filled: true,
                fillColor: Color(0xFFDDE2E6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),

            Spacer(),

            // Tombol Tambahkan
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A657A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: Text("Tambahkan", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}