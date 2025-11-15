import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'veiculo_controller.dart';
import 'veiculo_cadastro_dialog.dart';
import 'package:abastecimento/features/abastecimentos/abastecimento_screen.dart';

class VeiculoScreen extends ConsumerWidget {
  const VeiculoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veiculosAsync = ref.watch(veiculosProvider);
    final controller = ref.read(veiculoControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Veículos')),
      body: veiculosAsync.when(
        data: (veiculos) {
          if (veiculos.isEmpty) {
            return const Center(child: Text('Nenhum veículo cadastrado'));
          }
          return ListView.builder(
            itemCount: veiculos.length,
            itemBuilder: (_, i) {
              final v = veiculos[i];
              return ListTile(
                title: Text('${v.modelo} - ${v.marca}'),
                subtitle: Text('${v.placa} | ${v.ano} | ${v.tipoCombustivel}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.local_gas_station),
                      tooltip: 'Ver abastecimentos',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AbastecimentoScreen(veiculoId: v.id),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => controller.excluir(v.id),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => CadastroVeiculoDialog(
                      controller: controller,
                      veiculoExistente: v,
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Erro ao carregar veículos')),
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
