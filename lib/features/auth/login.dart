import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  Future<void> login() async {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // ================= VALIDASI LOKAL =================
    if (email.isEmpty) {
      setState(() => emailError = "Email tidak boleh kosong");
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() => emailError = "Format email tidak valid");
      return;
    }

    if (password.isEmpty) {
      setState(() => passwordError = "Password tidak boleh kosong");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      final user = response.user;

      if (user == null) {
        setState(() {
          passwordError = "Email atau password salah";
        });
        return;
      }

      final data = await Supabase.instance.client
          .from('users')
          .select('role')
          .eq('id', user.id)
          .maybeSingle();

      if (data == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Akun belum memiliki role")),
        );
        return;
      }

      final role = data['role'];

      if (!mounted) return;

      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardAdmin()),
        );
      } else if (role == 'petugas') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPetugas()),
        );
      } else if (role == 'peminjam') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPeminjam()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Role tidak dikenali")),
        );
      }
    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains("invalid login credentials")) {
        setState(() {
          passwordError = "Email atau password salah";
        });
      } else if (e.message.toLowerCase().contains("email not confirmed")) {
        setState(() {
          emailError = "Email belum dikonfirmasi";
        });
      } else {
        setState(() {
          passwordError = e.message;
        });
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan sistem")),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF405D72),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Image.asset('assets/logoukk.png', width: 120),
                  const SizedBox(height: 10),
                  const Text(
                    "SiPinjam",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF405D72),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Masukkan Email",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  if (emailError != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 5),
                      child: Text(
                        emailError!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Masukkan Sandi",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  if (passwordError != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 5),
                      child: Text(
                        passwordError!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Masuk",
                              style: TextStyle(
                                color: Color(0xFF405D72),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
