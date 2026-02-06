import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlatPage extends StatefulWidget {
  const AlatPage({super.key});

  @override
  State<AlatPage> createState() => _AlatPageState();
}

class _AlatPageState extends State<AlatPage> {
  final supabase = Supabase.instance.client;
  String selectedKategori = 'Proyektor'; // Kategori default

  // Fungsi untuk mengambil data berdasarkan kategori
  Stream<List<Map<String, dynamic>>> get _alatStream => supabase
      .from('alat')
      .stream(primaryKey: ['id_alat'])
      .eq('kategori', selectedKategori);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4A6572);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Header Background
          Container(
            height: 210,
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
                const SizedBox(height: 20),
                _buildCategoryTabs(),
                
                // Grid View Data
                Expanded(
                  child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _alatStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("Tidak ada alat tersedia"));
                      }

                      final items = snapshot.data!;
                      return GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return _buildAlatCard(items[index]);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 80), // Space for Nav
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              SizedBox(
                  width: 250, child: Divider(color: Colors.white, thickness: 3)),
            ],
          ),
          Icon(Icons.account_circle, color: Colors.white, size: 50),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(25),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari Alat',
            prefixIcon: const Icon(Icons.search),
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    List<String> categories = ['Proyektor', 'Speaker', 'Stop Kontak'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categories.map((cat) {
        bool isSelected = selectedKategori == cat;
        return GestureDetector(
          onTap: () => setState(() => selectedKategori = cat),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey[400] : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              border: isSelected ? Border.all(color: Colors.black, width: 1.5) : null,
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Text(cat,
                style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAlatCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9E0E4),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: item['image_url'] != null 
                ? Image.network(item['image_url'], fit: BoxFit.contain)
                : const Icon(Icons.image, size: 50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Icon(Icons.edit, size: 16),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A6572),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Tersedia : ${item['tersedia']}',
                          style: const TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                    const Icon(Icons.delete_outline, size: 18),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF9EABB3),
          borderRadius: BorderRadius.circular(35),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: Icons.home_outlined, label: 'Beranda'),
            _NavItem(icon: Icons.person_outline, label: 'Pengguna'),
            _NavItem(icon: Icons.shopping_bag, label: 'Alat', isActive: true),
            _NavItem(icon: Icons.category_outlined, label: 'Kategori'),
            _NavItem(icon: Icons.label_outline, label: 'Peminjaman'),
            _NavItem(icon: Icons.history, label: 'Pengembalian'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _NavItem({required this.icon, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.black : Colors.black54),
        Text(label, style: TextStyle(fontSize: 8, color: isActive ? Colors.black : Colors.black54)),
      ],
    );
  }
}