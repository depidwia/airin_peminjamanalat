import 'package:flutter/material.dart';

class EditKategoriPage extends StatefulWidget {
  @override
  _EditKategoriPageState createState() => _EditKategoriPageState();
}

class _EditKategoriPageState extends State<EditKategoriPage> {
  // Inisialisasi controller dengan data yang sudah ada
  final TextEditingController _namaController = TextEditingController(text: "Speaker");
  final TextEditingController _deskripsiController = TextEditingController(
    text: "Speaker portabel dengan koneksi Bluetooth untuk memutar audio secara nirkabel. Cocok untuk presentasi dan kegiatan acara."
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4A657A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Edit Kategori", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            // Preview Gambar dengan Icon Plus
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://placeholder.com/speaker-image.jpg'), // Ganti dengan asset Anda
                      ),
                    ),
                  ),
                  Icon(Icons.add, size: 40, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 30),
            
            // Input Nama Kategori
            Align(alignment: Alignment.centerLeft, child: Text("Nama Kategori", style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(height: 8),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
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
              controller: _deskripsiController,
              maxLines: 6,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFDDE2E6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),

            SizedBox(height: 40),

            // Tombol Simpan
            SizedBox(
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A657A),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Logika simpan perubahan di sini
                },
                child: Text("Simpan", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}