import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:alat_1/features/pengguna/tambah_pengguna.dart';
import 'package:alat_1/features/pengguna/edit_pengguna.dart';


class PenggunaPage extends StatefulWidget {
  const PenggunaPage({super.key});

  @override
  State<PenggunaPage> createState() => _PenggunaPageState();
}

class _PenggunaPageState extends State<PenggunaPage> {
  final supabase = Supabase.instance.client;

  // Stream untuk sinkronisasi data Realtime dengan Supabase
  final Stream<List<Map<String, dynamic>>> _usersStream =
      Supabase.instance.client
          .from('users')
          .stream(primaryKey: ['id_user']);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4A6572); // Biru keabuan sesuai gambar
    const Color cardColor = Color(0xFFD9E0E4);   // Warna abu-abu kartu

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Header Biru
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),

                Expanded(
                  child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _usersStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("Tidak ada data pengguna"));
                      }

                      final users = snapshot.data!;

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return userCard(
                            cardColor,
                            primaryColor,
                            role: user['role'] ?? 'User',
                            nama: user['nama'] ?? 'Tanpa Nama',
                            email: user['email'] ?? '',
                            idUser: user['id_user'].toString(),
                          );
                        },
                      );
                    },
                  ),
                ),

                _buildAddButton(primaryColor),
                const SizedBox(height: 85), // Ruang agar tidak tertutup Navbar
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  // --- LOGIKA SUPABASE ---
  Future<void> deleteUser(String idUser) async {
    try {
      await supabase.from('users').delete().eq('id_user', idUser);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User berhasil dihapus')),
      );
    } catch (e) {
      print("Error deleting: $e");
    }
  }

  // --- WIDGET KOMPONEN ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PENGGUNA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Container(height: 3, width: 220, color: Colors.white),
            ],
          ),
          const Icon(Icons.account_circle, color: Colors.white, size: 55),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari Pengguna',
            prefixIcon: const Icon(Icons.search),
            fillColor: const Color(0xFFEBEBEB),
            filled: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(Color color) {
    return Padding(
    padding: const EdgeInsets.only(right: 25.0, bottom: 10),
    child: Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahPenggunaPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Tambah', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}

  Widget _buildBottomNav() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF9EABB3), // Warna navbar keabuan
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_outlined, 'Beranda'),
            _navItem(Icons.person, 'Pengguna', isActive: true),
            _navItem(Icons.shopping_bag_outlined, 'Alat'),
            _navItem(Icons.category_outlined, 'Kategori'),
            _navItem(Icons.label_outline, 'Peminjaman'),
            _navItem(Icons.history, 'Pengembalian'),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 26, color: isActive ? Colors.black : Colors.black45),
        Text(label, style: TextStyle(fontSize: 9, color: isActive ? Colors.black : Colors.black45)),
      ],
    );
  }

  Widget userCard(Color bgColor, Color btnColor,
      {required String role, required String nama, required String email, required String idUser}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.person, size: 50),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(role, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(nama),
                    Text(email, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              actionButton('Edit', btnColor, () {
                // Navigasi ke Edit
              }),
              const SizedBox(width: 10),
              actionButton('Hapus', btnColor, () => deleteUser(idUser)),
            ],
          ),
        ],
      ),
    );
  }

  Widget actionButton(String label, Color color, VoidCallback onPressed) {
    return SizedBox(
      height: 35,
      width: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 4,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }
}