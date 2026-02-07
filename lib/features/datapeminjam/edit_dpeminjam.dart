import 'package:flutter/material.dart';

class EditPeminjamPage extends StatefulWidget {
  const EditPeminjamPage({super.key});

  @override
  State<EditPeminjamPage> createState() => _EditPeminjamPageState();
}

class _EditPeminjamPageState extends State<EditPeminjamPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController =
      TextEditingController(text: 'Elingga');
  final TextEditingController alatController =
      TextEditingController(text: 'Epson');
  final TextEditingController tglPinjamController =
      TextEditingController(text: '10 Januari 2026');
  final TextEditingController tglKembaliController =
      TextEditingController(text: '15 Januari 2026');
  final TextEditingController statusController =
      TextEditingController(text: 'dipinjam');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF455A64),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Data Peminjam',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _inputField(
                label: 'Nama Peminjam',
                controller: namaController,
              ),
              _inputField(
                label: 'Alat',
                controller: alatController,
              ),
              _inputField(
                label: 'Tanggal Pinjaman',
                controller: tglPinjamController,
                readOnly: true,
                onTap: () {
                  // nanti bisa pakai DatePicker
                },
              ),
              _inputField(
                label: 'Tanggal Kembali',
                controller: tglKembaliController,
                readOnly: true,
                onTap: () {
                  // nanti bisa pakai DatePicker
                },
              ),
              _inputField(
                label: 'Status',
                controller: statusController,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 120,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF455A64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // aksi simpan
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data berhasil diperbarui'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label tidak boleh kosong';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
