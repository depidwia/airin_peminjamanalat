import 'package:flutter/material.dart';

class AlatPage extends StatefulWidget {
  const AlatPage({super.key});

  @override
  State<AlatPage> createState() => _AlatPageState();
}

class _AlatPageState extends State<AlatPage> {
  String selectedCategory = 'Proyektor';

  final List<String> categories = ['Proyektor', 'Speaker', 'Stop Kontak'];

  final Map<String, List<Map<String, String>>> items = {
    'Proyektor': [
      {'name': 'EPSON', 'image': 'assets/epson.png'},
      {'name': 'ACER', 'image': 'assets/acer.png'},
      {'name': 'NOTOR', 'image': 'assets/notor.png'},
      {'name': 'BENQ', 'image': 'assets/benq.png'},
    ],
    'Speaker': [
      {'name': 'EDIFIER', 'image': 'assets/edifier.png'},
      {'name': 'ANKER', 'image': 'assets/anker.png'},
      {'name': 'DOSS', 'image': 'assets/doss.png'},
      {'name': 'MIATONE', 'image': 'assets/miatone.png'},
    ],
    'Stop Kontak': [
      {'name': 'LUBANG 3', 'image': 'assets/lubang3.png'},
      {'name': 'LUBANG 4', 'image': 'assets/lubang4.png'},
      {'name': 'LUBANG 5', 'image': 'assets/lubang5.png'},
      {'name': 'LUBANG 6', 'image': 'assets/lubang6.png'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2F4F5F),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _bottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _searchBar(),
            _categoryTabs(),
            Expanded(child: _gridItems()),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF425F73),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Text('Alat',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari Alat',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _categoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((e) {
          final bool active = selectedCategory == e;
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = e),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: active ? const Color(0xFF7B7B7B) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(e,
                  style: TextStyle(
                      color: active ? Colors.white : Colors.black)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _gridItems() {
    final data = items[selectedCategory]!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          return _itemCard(data[index]);
        },
      ),
    );
  }

  Widget _itemCard(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD5DBE0),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(item['image']!, fit: BoxFit.contain),
            ),
          ),
          Text(item['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF425F73),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Tersedia : 5',
                    style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
              Row(children: const [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 6),
                Icon(Icons.delete, size: 18)
              ])
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF425F73),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Pengguna'),
        BottomNavigationBarItem(icon: Icon(Icons.devices), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Kategori'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_return), label: 'Peminjaman'),
      ],
    );
  }
}
