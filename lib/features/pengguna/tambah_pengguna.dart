import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TambahPenggunaPage extends StatefulWidget {
  const TambahPenggunaPage({super.key});

  @override
  State<TambahPenggunaPage> createState() => _TambahPenggunaPageState();
}

class _TambahPenggunaPageState extends State<TambahPenggunaPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  String? _selectedPosisi;
  bool _isPasswordVisible = false;
  final List<String> _posisiOptions = ['Petugas', 'Admin', 'Peminjam'];

  final supabase = Supabase.instance.client;

  // Fungsi untuk menyimpan data ke Supabase
  Future<void> tambahUser() async {
    if (_namaController.text.isEmpty || _emailController.text.isEmpty || _selectedPosisi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi!')),
      );
      return;
    }

    try {
      await supabase.from('users').insert({
        'nama': _namaController.text,
        'email': _emailController.text,
        'password': _passwordController.text, // Catatan: Sebaiknya gunakan Auth Supabase untuk keamanan
        'role': _selectedPosisi,
      });

      if (mounted) {
        Navigator.pop(context); // Kembali ke halaman daftar pengguna
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pengguna berhasil ditambahkan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tambah Pengguna',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Avatar Placeholder
            const Icon(Icons.account_circle_outlined, size: 120, color: Colors.black),
            const SizedBox(height: 30),

            // Input Nama
            _buildInputField('Nama', 'Masukkan Nama', _namaController, inputBgColor),

            // Input Email
            _buildInputField('Email', 'Masukkan Email', _emailController, inputBgColor),

            // Input Kata Sandi
            _buildPasswordField(inputBgColor),

            // Dropdown Posisi
            _buildDropdownField(inputBgColor),

            const SizedBox(height: 40),

            // Tombol Tambahkan
            SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: tambahUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 5,
                ),
                child: const Text(
                  'Tambahkan',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, Color bgColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              fillColor: bgColor,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPasswordField(Color bgColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kata Sandi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: 'Masukkan Sandi',
              fillColor: bgColor,
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdownField(Color bgColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Posisi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: DropdownButtonFormField<String>(
            value: _selectedPosisi,
            hint: const Text('Masukkan Posisi'),
            decoration: InputDecoration(
              fillColor: bgColor,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            ),
            items: _posisiOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() => _selectedPosisi = newValue);
            },
          ),
        ),
      ],
    );
  }
}