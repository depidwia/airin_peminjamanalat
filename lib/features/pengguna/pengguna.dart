import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:alat_1/features/pengguna/tambah_pengguna.dart';
import 'package:alat_1/features/pengguna/edit_pengguna.dart';


class PenggunaPage extends StatefulWidget {
  PenggunaPage({super.key});

  @override
  State<PenggunaPage> createState() => _PenggunaPageState();
}

class _PenggunaPageState extends State<PenggunaPage> {
  final supabase = Supabase.instance.client;
  List users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final data = await supabase
        .from('users')
        .select()
        .order('role', ascending: true);

    setState(() {
      users = data;
      loading = false;
    });
  }

  Future<void> deleteUser(String id) async {
    await supabase.from('users').delete().eq('id', id);
    fetchUsers();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 26),
            decoration: const BoxDecoration(
              color: Color(0xFF3E5C6E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'PENGGUNA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.person,
                      color: Colors.white, size: 20),
                ),
              ],
            ),
          ),

          // ================= SEARCH =================
          Container(
            margin: const EdgeInsets.fromLTRB(16, 18, 16, 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Cari Pengguna',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

<<<<<<< HEAD
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
=======
          // ================= LIST =================
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return _userCard(user);
                    },
                  ),
          ),
>>>>>>> eeffdd29cb1ed076031f0c22e0a1fa053e279478

          // ================= BUTTON TAMBAH =================
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: 120,
              height: 36,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E5C6E),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Tambah',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= USER CARD =================
  Widget _userCard(Map user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFD9E0E6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['role'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user['nama'],
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  user['email'],
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 72,
                height: 28,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E5C6E),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 72,
                height: 28,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () => deleteUser(user['id']),
                  child: const Text(
                    'Hapus',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
