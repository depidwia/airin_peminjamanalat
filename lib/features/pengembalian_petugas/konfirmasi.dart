import 'package:flutter/material.dart';

class KonfirmasiPengembalianPage extends StatelessWidget {
  final bool hasDenda;

  const KonfirmasiPengembalianPage({
    super.key,
    required this.hasDenda,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F5F73),
        title: const Text('Konfirmasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFD7DDE2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, size: 32),
              ),
              const SizedBox(height: 12),

              _info('Nama', 'rara'),
              _info('Alat', 'Epson'),
              _info('Tanggal Pinjam', '27 Januari 2026'),
              _info('Tanggal Kembali', '28 Januari 2026'),
              _info('Tanggal Pengembalian', '30 Januari 2026'),

              const SizedBox(height: 10),

              if (hasDenda)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB0BEC5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Denda (opsional)\n10.000 (telat 2 hari)',
                    style: TextStyle(fontSize: 12),
                  ),
                ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F5F73),
                  minimumSize: const Size(140, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  hasDenda ? 'Kirim Denda' : 'Konfirmasi',
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
