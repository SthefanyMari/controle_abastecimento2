import 'package:flutter/material.dart';                 
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:go_router/go_router.dart';              
import 'auth_controller.dart';                          

class SplashGate extends ConsumerWidget {
  const SplashGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);
    return auth.when(
      data: (user) {
        Future.microtask(() =>
            context.go(user == null ? '/login' : '/home'));
        return const SizedBox.shrink(); 
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Erro de autenticação')),
    );
  }
}
