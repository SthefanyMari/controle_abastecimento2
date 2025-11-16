import 'dart:ui';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Histórico de Abastecimentos',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const AppDrawer(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.only(top: 90, left: 16, right: 16),
          child: todosAbastecimentosAsync.when(
            data: (abastecimentos) {
              if (abastecimentos.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum abastecimento registrado.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }

              return ListView.separated(
                itemCount: abastecimentos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) {
                  final a = abastecimentos[i];

                  return _glassCard(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          // Ícone estilizado
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.28),
                            ),
                            child: const Icon(
                              Icons.local_gas_station_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Informações
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${a.data}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${a.quantidadeLitros} L  •  R\$ ${a.valorPago}  •  Km: ${a.quilometragem}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.85),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },

            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

            error: (_, __) => const Center(
              child: Text(
                'Erro ao carregar histórico',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- CARTÃO COM GLASSMORPHISM ----------
  Widget _glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.28)),
          ),
          child: child,
        ),
      ),
    );
  }
}
