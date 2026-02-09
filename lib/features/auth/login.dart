import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import sesuai path project kamu
import 'package:alat_1/features/dashboard/dashboard_admin.dart';
import 'package:alat_1/features/dashboard/dashboard_petugas.dart';
import 'package:alat_1/features/dashboard/dashboard_peminjam.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  String? emailError;
  String? passwordError;

  // --- FUNGSI LOGIN ---
  Future<void> login() async {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // 1. Validasi Input Lokal
    if (email.isEmpty) {
      setState(() => emailError = "Email tidak boleh kosong");
      return;
    }
    if (password.isEmpty) {
      setState(() => passwordError = "Password tidak boleh kosong");
      return;
    }

    setState(() => isLoading = true);

    try {
      // 2. Sign In ke Supabase Auth
      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      final user = response.user;

      if (user == null) return;

      // 3. Ambil Data dari tabel 'users' (disesuaikan dengan screenshot database)
      // Kita memanggil tabel 'users' dan kolom 'role'
      final data = await Supabase.instance.client
          .from('users') 
          .select('role')
          .eq('id_user', user.id)
          .maybeSingle();

      if (data == null) {
        await Supabase.instance.client.auth.signOut();
        if (!mounted) return;
        _showSnackBar("Data profil tidak ditemukan di tabel users", Colors.red);
        return;
      }

      // 4. Navigasi Berdasarkan Role
      final String role = data['role'].toString().toLowerCase();

      if (!mounted) return;

      if (role == 'admin') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardAdmin()));
      } else if (role == 'petugas') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  const DashboardPetugasPage()));
      } else if (role == 'peminjam') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  DashboardPeminjamPage()));
      } else {
        _showSnackBar("Role '$role' tidak dikenali", Colors.orange);
      }

    } on AuthException catch (e) {
      setState(() => passwordError = "Email atau password salah");
    } on PostgrestException catch (e) {
      // Menangani error jika tabel/kolom tidak ditemukan
      _showSnackBar("Kesalahan Database: ${e.message}", Colors.red);
    } catch (e) {
      _showSnackBar("Terjadi kesalahan: $e", Colors.red);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color, behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF405D72),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Putih Melengkung
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    Image.asset('assets/logoukk.png', width: 100, errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 80, color: Color(0xFF405D72))),
                    const SizedBox(height: 10),
                    const Text("SiPinjam", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF405D72))),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Form Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    _buildTextField(emailController, "Masukkan Email", Icons.person, errorText: emailError),
                    const SizedBox(height: 20),
                    _buildTextField(passwordController, "Masukkan Sandi", Icons.lock, 
                      isPassword: true, 
                      errorText: passwordError,
                      isObscured: obscurePassword,
                      onToggle: () => setState(() => obscurePassword = !obscurePassword)
                    ),
                    const SizedBox(height: 40),

                    // Tombol Masuk
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Color(0xFF405D72))
                            : const Text("Masuk", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF405D72))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, 
      {bool isPassword = false, String? errorText, bool isObscured = false, VoidCallback? onToggle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: isPassword ? isObscured : false,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFF405D72)),
            suffixIcon: isPassword ? IconButton(icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility), onPressed: onToggle) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(errorText, style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
          ),
      ],
    );
  }
}