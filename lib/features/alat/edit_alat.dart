import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditAlatPage extends StatefulWidget {
  final Map<String, dynamic> alat; // Menerima data alat dari halaman daftar

  const EditAlatPage({super.key, required this.alat});

  @override
  State<EditAlatPage> createState() => _EditAlatPageState();
}

class _EditAlatPageState extends State<EditAlatPage> {
  final _namaAlatController = TextEditingController();
  final _tersediaController = TextEditingController();
  final _kategoriController = TextEditingController();

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    // Mengisi input field dengan data yang sudah ada dari database
    _namaAlatController.text = widget.alat['nama'] ?? '';
    _tersediaController.text = (widget.alat['tersedia'] ?? 0).toString();
    _kategoriController.text = widget.alat['kategori'] ?? '';
  }

  // Fungsi untuk menyimpan perubahan ke Supabase
  Future<void> simpanPerubahan() async {
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
      // Melakukan update berdasarkan id_alat
      await supabase.from('alat').update({
        'nama': nama,
        'tersedia': tersedia,
        'kategori': kategori,
      }).eq('id_alat', widget.alat['id_alat']);

      if (mounted) {
        Navigator.pop(context); // Kembali ke halaman daftar alat
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perubahan berhasil disimpan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4A6572); // Biru keabuan sesuai desain
    const Color inputBgColor = Color(0xFFD9E0E4); // Abu-abu terang untuk input

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
          'Edit Alat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // Tampilan Gambar Alat (Preview)
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: widget.alat['image_url'] != null
                        ? Image.network(widget.alat['image_url'], fit: BoxFit.contain)
                        : const Icon(Icons.image_outlined, size: 100),
                  ),
                  // Icon Pensil untuk edit gambar sesuai desain
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.edit, size: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // Input Nama Alat
            _buildInputField('Nama Alat', _namaAlatController, inputBgColor),

            // Input Tersedia (Jumlah)
            _buildInputField('Tersedia', _tersediaController, inputBgColor, isNumber: true),

            // Input Kategori
            _buildInputField('Kategori', _kategoriController, inputBgColor),

            const SizedBox(height: 40),

            // Tombol Simpan
            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                onPressed: simpanPerubahan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, Color bgColor, {bool isNumber = false}) {
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
        const SizedBox(height: 20),
      ],
    );
  }
}