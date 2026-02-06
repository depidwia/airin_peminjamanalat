import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TambahAlatPage extends StatefulWidget {
  const TambahAlatPage({super.key});

  @override
  State<TambahAlatPage> createState() => _TambahAlatPageState();
}

class _TambahAlatPageState extends State<TambahAlatPage> {
  final _namaAlatController = TextEditingController();
  final _tersediaController = TextEditingController();
  final _kategoriController = TextEditingController();

  final supabase = Supabase.instance.client;

  // Fungsi untuk menambah data alat ke Supabase
  Future<void> tambahAlat() async {
    final nama = _namaAlatController.text;
    final tersedia = int.tryParse(_tersediaController.text) ?? 0;
    final kategori = _kategoriController.text;

    if (nama.isEmpty || kategori.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua kolom!')),
      );
      return;
    }

    try {
      await supabase.from('alat').insert({
        'nama': nama,
        'tersedia': tersedia,
        'kategori': kategori,
        // 'image_url': '' // Tambahkan logika upload gambar jika diperlukan
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alat berhasil ditambahkan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4A6572);
    const Color inputBgColor = Color(0xFFD9E0E4);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tambah Alat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 40),
            
            // Placeholder Gambar (Icon Tambah Gambar)
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.image_outlined, size: 100),
                  ),
                  const Icon(Icons.add, size: 40, color: Colors.black),
                ],
              ),
            ),
            
            const SizedBox(height: 40),

            // Input Nama Alat
            _buildInputField('Nama Alat', 'Masukkan Nama Alat', _namaAlatController, inputBgColor),

            // Input Tersedia
            _buildInputField('Tersedia', 'Masukkan Tersedia Alat', _tersediaController, inputBgColor, isNumber: true),

            // Input Kategori
            _buildInputField('Kategori', 'Masukan Kategori', _kategoriController, inputBgColor),

            const SizedBox(height: 50),

            // Tombol Tambahkan
            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                onPressed: tambahAlat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Tambahkan',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, Color bgColor, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Material(
          elevation: 4,
          shadowColor: Colors.black45,
          borderRadius: BorderRadius.circular(10),
          child: TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              fillColor: bgColor,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}