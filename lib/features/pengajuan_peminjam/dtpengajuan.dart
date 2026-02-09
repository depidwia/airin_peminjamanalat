import 'package:flutter/material.dart';

class PengajuanDetailPage extends StatelessWidget {
  const PengajuanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== APP BAR =====
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF3F5F73),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Pengajuan Peminjaman',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== CARD ALAT =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFD7DDE2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/anker.png', width: 60),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('ANKER', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Speaker', style: TextStyle(fontSize: 12)),
                          SizedBox(height: 4),
                          Chip(
                            label: Text('Tersedia : 5'),
                            backgroundColor: Color(0xFF3F5F73),
                            labelStyle: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.remove_circle_outline),
                        SizedBox(width: 8),
                        Text('1'),
                        SizedBox(width: 8),
                        Icon(Icons.add_circle_outline),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            _inputLabel('Nama'),
            _inputField('Masukkan Nama peminjam'),

            _inputLabel('Tanggal Pinjaman'),
            _inputField('Masukkan Tanggal Pinjaman'),

            _inputLabel('Tanggal Kembali'),
            _inputField('Masukkan Tanggal Kembali'),

            const Spacer(),

            // ===== TOTAL & BUTTON =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total : 1 Alat'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F5F73),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Kirim Pengajuan'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Widget _inputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  static Widget _inputField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFD7DDE2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
