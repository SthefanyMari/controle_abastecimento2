import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'veiculo.dart';
import 'veiculo_repository.dart';

final veiculoRepositoryProvider = Provider((ref) => VeiculoRepository());

final veiculosProvider = StreamProvider<List<Veiculo>>((ref) {
  return ref.read(veiculoRepositoryProvider).listar();
});

class VeiculoController {
  final VeiculoRepository repo;
  VeiculoController(this.repo);

  Future<void> cadastrar(Veiculo v) => repo.cadastrar(v);
  Future<void> atualizar(Veiculo v) => repo.atualizar(v);
  Future<void> excluir(String id) => repo.excluir(id);
}

final veiculoControllerProvider = Provider((ref) {
  return VeiculoController(ref.read(veiculoRepositoryProvider));
});
