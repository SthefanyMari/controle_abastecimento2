import 'package:flutter/material.dart';                      
import 'package:flutter_riverpod/flutter_riverpod.dart';     
import 'package:go_router/go_router.dart';                   
import 'auth_controller.dart';                              

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: (v) => v != null && v.contains('@') ? null : 'E-mail inválido',
            ),
            TextFormField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (v) => v != null && v.length >= 6 ? null : 'Mínimo 6 caracteres',
            ),
            const SizedBox(height: 12),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final err = await auth.register(emailCtrl.text, passCtrl.text);
                  if (err == null) context.go('/home');
                  else setState(() => error = err);
                }
              },
              child: const Text('Cadastrar'),
            ),
          ]),
        ),
      ),
    );
  }
}
