import 'package:flutter/material.dart';
import 'package:alat_1/features/akun/edita.dart';
import 'package:alat_1/features/akun/tambaha.dart';

class PenggunaPage extends StatelessWidget {
  const PenggunaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER =====
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF3F5F73),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'PENGGUNA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.person, color: Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ===== SEARCH =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Cari Pengguna',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== LIST USER =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  UserCard(
                    role: 'Admin',
                    email: 'admin@gmail.com',
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditPenggunaPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  UserCard(
                    role: 'Petugas',
                    email: 'petugas@gmail.com',
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditPenggunaPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  UserCard(
                    role: 'Peminjam',
                    email: 'orang@gmail.com',
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditPenggunaPage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ===== BUTTON TAMBAH =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TambahPenggunaPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F5F73),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Tambah'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== USER CARD =====
class UserCard extends StatelessWidget {
  final String role;
  final String email;
  final VoidCallback onEdit;

  const UserCard({
    super.key,
    required this.role,
    required this.email,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD7DDE2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(email, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onEdit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F5F73),
              minimumSize: const Size(60, 28),
            ),
            child: const Text('Edit', style: TextStyle(fontSize: 11)),
          ),
          const SizedBox(width: 6),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: const Size(60, 28),
            ),
            child: const Text('Hapus', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
