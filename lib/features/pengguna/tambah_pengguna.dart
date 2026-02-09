import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TambahPenggunaPage extends StatefulWidget {
  const TambahPenggunaPage({super.key});

  @override
  State<TambahPenggunaPage> createState() => _TambahPenggunaPageState();
}

class _TambahPenggunaPageState extends State<TambahPenggunaPage> {
  final supabase = Supabase.instance.client;
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? selectedPosisi;

  // FUNGSI SIMPAN KE SUPABASE
  Future<void> simpanPengguna() async {
    if (_namaController.text.isEmpty || _emailController.text.isEmpty || selectedPosisi == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Isi semua data!")));
      return;
    }

    try {
      await supabase.from('users').insert({
        'nama': _namaController.text,
        'email': _emailController.text,
        'password': _passwordController.text, // Pastikan ada kolom password di DB
        'role': selectedPosisi?.toLowerCase(), // Menyisuaikan dengan data db kamu (peminjam, admin, dll)
      });
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data Berhasil Ditambah")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan desain UI yang sudah kita buat sebelumnya
    // Ganti TextField biasa dengan controller yang sudah dibuat:
    // Contoh: _buildInputField("Nama", controller: _namaController)
    
    return Scaffold(
      // ... (Bagian AppBar dan Icon Profil sama seperti sebelumnya)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // ... (Bagian Icon Profil)
            const SizedBox(height: 20),
            _buildInputField("Nama", "Masukkan Nama", controller: _namaController),
            _buildInputField("Email", "Masukkan Email", controller: _emailController),
            _buildInputField("Kata Sandi", "Masukkan Sandi", controller: _passwordController, isPassword: true),
            
            // Dropdown Posisi
            _buildDropdown(),

            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A6572)),
              onPressed: simpanPengguna, // Panggil fungsi simpan
              child: const Text("Tambahkan", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Edit Helper Widget agar menerima controller
  Widget _buildInputField(String label, String hint, {required TextEditingController controller, bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: const Color(0xFFCFD8DC), borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(hintText: hint, border: InputBorder.none, contentPadding: EdgeInsets.all(15)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(filled: true, fillColor: Color(0xFFCFD8DC)),
      items: ["Admin", "Petugas", "Peminjam"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (val) => setState(() => selectedPosisi = val),
    );
  }
}