import 'dart:ui';
import 'package:abastecimento/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? error;

 @override
Widget build(BuildContext context) {
  final auth = ref.read(authControllerProvider);
  final loginTheme = Theme.of(context).extension<AppLoginTheme>()!;

  return Scaffold(
    body: Stack(
      children: [
        Container(decoration: BoxDecoration(gradient: loginTheme.loginGradient)),

        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: 380,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: loginTheme.glassColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: loginTheme.glassBorderColor,
                    width: 1.2,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: loginTheme.logoGradient,
                        ),
                        child: Icon(
                          Icons.local_gas_station_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 36,
                        ),
                      ),

                      const SizedBox(height: 22),

                      Text(
                        "Acesse sua conta",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: loginTheme.inputTextColor,
                        ),
                      ),

                      const SizedBox(height: 35),
                      _modernInput(
                        label: "E-mail",
                        controller: emailCtrl,
                        validator: (v) =>
                            v != null && v.contains('@') ? null : "E-mail inválido",
                      ),

                      const SizedBox(height: 18),
                      _modernInput(
                        label: "Senha",
                        controller: passCtrl,
                        obscure: true,
                        validator: (v) =>
                            v != null && v.length >= 6 ? null : "Mínimo 6 caracteres",
                      ),

                      const SizedBox(height: 20),

                      if (error != null)
                        Text(error!, style: const TextStyle(color: Colors.redAccent)),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: loginTheme.loginButtonGradient,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                final err = await auth.login(
                                    emailCtrl.text, passCtrl.text);
                                if (err == null) {
                                  context.go('/home');
                                } else {
                                  setState(() => error = err);
                                }
                              }
                            },
                            child: const Center(
                              child: Text(
                                "Entrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      GestureDetector(
                        onTap: () => context.go('/register'),
                        child: Text(
                          "Criar conta",
                          style: TextStyle(
                            color: loginTheme.linkColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _modernInput({
  required String label,
  required TextEditingController controller,
  required String? Function(String?) validator,
  bool obscure = false,
}) {
  final loginTheme = Theme.of(context).extension<AppLoginTheme>()!;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: loginTheme.labelColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 4),
      TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure,
        style: TextStyle(color: loginTheme.inputTextColor),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: loginTheme.inputLineColor, width: 1.2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: loginTheme.inputLineFocusedColor, width: 1.5),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    ],
  );
}
}