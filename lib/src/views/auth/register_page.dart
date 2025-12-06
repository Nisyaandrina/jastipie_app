// lib/views/auth/register_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_vm.dart';
import '../../app_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

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
            if (authVM.loading) const CircularProgressIndicator(),
            if (authVM.error != null)
              Text(authVM.error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                await authVM.register(_emailCtrl.text, _passCtrl.text);
                if (authVM.user != null) {
                  Navigator.pushReplacementNamed(context, AppRouter.roleSelection);
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