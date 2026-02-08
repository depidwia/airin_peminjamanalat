import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PenggunaPage extends StatefulWidget {
  const PenggunaPage({super.key});

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
    final data = await supabase.from('users').select().order('role');
    setState(() {
      users = data;
      loading = false;
    });
  }

  Future<void> deleteUser(String id) async {
    await supabase.from('users').delete().eq('id', id);
    fetchUsers();
  }

  void showForm({Map? user}) {
    final nama = TextEditingController(text: user?['nama']);
    final email = TextEditingController(text: user?['email']);
    String role = user?['role'] ?? 'Peminjam';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(user == null ? 'Tambah Pengguna' : 'Edit Pengguna'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nama,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            DropdownButtonFormField(
              value: role,
              items: ['Admin', 'Petugas', 'Peminjam']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => role = val!,
              decoration: const InputDecoration(labelText: 'Role'),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (user == null) {
                await supabase.from('users').insert({
                  'nama': nama.text,
                  'email': email.text,
                  'role': role,
                });
              } else {
                await supabase.from('users').update({
                  'nama': nama.text,
                  'email': email.text,
                  'role': role,
                }).eq('id', user['id']);
              }
              Navigator.pop(context);
              fetchUsers();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      body: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF3E5C6E),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: const Text(
              'PENGGUNA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // SEARCH
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari Pengguna',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // LIST USER
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: users.length,
                    itemBuilder: (context, i) {
                      final user = users[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9E0E6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person, size: 40),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user['role'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(user['nama']),
                                  Text(user['email']),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFF3E5C6E),
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () =>
                                        showForm(user: user),
                                    child: const Text('Edit',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  width: 70,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () =>
                                        deleteUser(user['id']),
                                    child: const Text('Hapus',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // TOMBOL TAMBAH
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E5C6E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => showForm(),
                child: const Text('Tambah'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
