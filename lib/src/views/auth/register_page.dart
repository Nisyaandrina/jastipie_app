import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jastipie_app/src/viewmodels/auth_vm.dart';
import 'package:jastipie_app/app_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  /// Handler sinkron untuk navigasi 
  void _onRegisterSuccess() {
    Navigator.of(context).pushReplacementNamed(AppRouter.roleSelectionRoute);
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),

            /// Loading indicator
            if (authVM.loading) const CircularProgressIndicator(),

            /// Error display
            if (authVM.error != null)
              Text(
                authVM.error!,
                style: const TextStyle(color: Colors.red),
              ),

            ElevatedButton(
              onPressed: authVM.loading
                  ? null
                  : () async {
                      final email = _emailCtrl.text.trim();
                      final pass = _passCtrl.text.trim();

                      // optional validation
                      if (email.isEmpty || pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Email dan password tidak boleh kosong")),
                        );
                        return;
                      }

                      await authVM.register(email, pass);

                      if (!mounted) return;

                      if (authVM.user != null) {
                        _onRegisterSuccess(); 
                      }
                    },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
