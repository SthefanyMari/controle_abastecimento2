import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'abastecimento_controller.dart';
import 'abastecimento_cadastro_dialog.dart';

class AbastecimentoScreen extends ConsumerWidget {
  final String veiculoId;
  const AbastecimentoScreen({super.key, required this.veiculoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abastecimentosAsync = ref.watch(abastecimentosProvider(veiculoId));
    final controller = ref.read(abastecimentoControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Abastecimentos')),
      body: abastecimentosAsync.when(
        data: (abastecimentos) {
          if (abastecimentos.isEmpty) {
            return const Center(child: Text('Nenhum abastecimento registrado'));
          }
          return ListView.builder(
            itemCount: abastecimentos.length,
            itemBuilder: (_, i) {
              final a = abastecimentos[i];
              return ListTile(
                title: Text('${a.data.toLocal()} - ${a.quantidadeLitros} L'),
                subtitle: Text('R\$${a.valorPago} | Km: ${a.quilometragem}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => controller.excluir(a.id),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AbastecimentoCadastroDialog(
                      controller: controller,
                      veiculoId: veiculoId,
                      abastecimentoExistente: a,
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Erro ao carregar abastecimentos')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AbastecimentoCadastroDialog(
              controller: controller,
              veiculoId: veiculoId,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
