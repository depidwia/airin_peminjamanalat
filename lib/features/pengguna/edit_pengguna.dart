import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPenggunaPage extends StatefulWidget {
  final Map<String, dynamic> user; // Menerima data user dari halaman sebelumnya

  const EditPenggunaPage({super.key, required this.user});

  @override
  State<EditPenggunaPage> createState() => _EditPenggunaPageState();
}

class _EditPenggunaPageState extends State<EditPenggunaPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  String? _selectedPosisi;
  bool _isPasswordVisible = false;
  final List<String> _posisiOptions = ['Petugas', 'Admin', 'Peminjam'];

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    // Mengisi input field dengan data yang sudah ada
    _namaController.text = widget.user['nama'] ?? '';
    _emailController.text = widget.user['email'] ?? '';
    _passwordController.text = widget.user['password'] ?? '';
    _selectedPosisi = widget.user['role'];
  }

  // Fungsi untuk update data ke Supabase
  Future<void> updateUser() async {
    try {
      await supabase.from('users').update({
        'nama': _namaController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'role': _selectedPosisi,
      }).eq('id_user', int.parse(widget.user['id_user'].toString()));


      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perubahan berhasil disimpan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupdate: $e')),
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
          'Edit Pengguna',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.account_circle_outlined, size: 120, color: Colors.black),
            const SizedBox(height: 30),

            _buildInputField('Nama', _namaController, inputBgColor),
            _buildInputField('Email', _emailController, inputBgColor),
            _buildPasswordField(inputBgColor),
            _buildDropdownField(inputBgColor),

            const SizedBox(height: 40),

            // Tombol Simpan
            SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: updateUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 5,
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, Color bgColor) {
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