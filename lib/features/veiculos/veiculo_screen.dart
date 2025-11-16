import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'veiculo_controller.dart';
import 'veiculo_cadastro_dialog.dart';
import 'package:abastecimento/features/abastecimentos/abastecimento_screen.dart';
import 'package:abastecimento/shared/app_drawer.dart';

class VeiculoScreen extends ConsumerWidget {
  const VeiculoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final veiculosAsync = ref.watch(veiculosProvider);
    final controller = ref.read(veiculoControllerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Meus Veículos', style: TextStyle(color: Colors.white)),
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
          child: veiculosAsync.when(
            data: (veiculos) {
              if (veiculos.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum veículo cadastrado',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }

              return ListView.separated(
                itemCount: veiculos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) {
                  final v = veiculos[i];

                  return _buildGlassCard(
                    context: context,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => CadastroVeiculoDialog(
                            controller: controller,
                            veiculoExistente: v,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.25),
                              ),
                              child: const Icon(Icons.directions_car_rounded,
                                  color: Colors.white, size: 30),
                            ),

                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${v.modelo} - ${v.marca}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${v.placa} · ${v.ano} · ${v.tipoCombustivel}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.85),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 10),
                            Row(
                              children: [
                                _actionIcon(
                                  icon: Icons.local_gas_station,
                                  color: Colors.lightBlueAccent,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            AbastecimentoScreen(veiculoId: v.id),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                _actionIcon(
                                  icon: Icons.delete,
                                  color: Colors.redAccent,
                                  onTap: () => controller.excluir(v.id),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
            error: (_, __) =>
                const Center(child: Text('Erro ao carregar veículos', style: TextStyle(color: Colors.white))),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.30),
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CadastroVeiculoDialog(controller: controller),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  Widget _buildGlassCard({required BuildContext context, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.28)),
          ),
          child: child,
        ),
      ),
    );
  }
  Widget _actionIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.22),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, size: 22, color: color),
      ),
    );
  }
}
