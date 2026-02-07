import 'package:flutter/material.dart';

class TambahPeminjamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4A657A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Tambah Data Peminjam", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField("Nama Peminjam", "Masukkan Nama peminjam"),
            _buildInputField("Alat", "Masukkan alat yang dipinjam"),
            _buildInputField("Tanggal Pinjaman", "Masukkan tanggal pinjaman"),
            _buildInputField("Tanggal Kembali", "Masukkan tanggal pinjaman"), // Sesuai placeholder di gambar
            _buildInputField("Status", "Masukkan tanggal pinjaman"), // Sesuai placeholder di gambar
            
            SizedBox(height: 40),
            
            // Tombol Tambahkan
            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4A657A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: Text("Tambahkan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk membuat label dan input field
  Widget _buildInputField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              filled: true,
              fillColor: Color(0xFFDDE2E6),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}