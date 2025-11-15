import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'abastecimento_controller.dart';
import 'package:abastecimento/shared/app_drawer.dart';

class HistoricoAbastecimentosScreen extends ConsumerWidget {
  const HistoricoAbastecimentosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAbastecimentosAsync = ref.watch(todosAbastecimentosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Abastecimentos')),
      drawer: const AppDrawer(),
      body: todosAbastecimentosAsync.when(
        data: (abastecimentos) {
          if (abastecimentos.isEmpty) {
            return const Center(child: Text('Nenhum abastecimento registrado.'));
          }
          return ListView.builder(
            itemCount: abastecimentos.length,
            itemBuilder: (_, i) {
              final a = abastecimentos[i];
              return ListTile(
                leading: const Icon(Icons.local_gas_station),
                title: Text('${a.data.toLocal()} - ${a.quantidadeLitros} L'),
                subtitle: Text('R\$${a.valorPago} | Km: ${a.quilometragem}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Erro ao carregar histórico')),
      ),
    );
  }
}
