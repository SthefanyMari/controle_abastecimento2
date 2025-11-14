import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:abastecimento/features/veiculos/veiculo_controller.dart';
import 'package:abastecimento/features/veiculos/veiculo_cadastro_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(veiculoControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text('Bem-vindo à Home!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CadastroVeiculoDialog(controller: controller),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
