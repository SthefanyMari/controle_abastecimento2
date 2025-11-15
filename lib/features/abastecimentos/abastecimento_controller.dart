import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'abastecimento.dart';
import 'abastecimento_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



final abastecimentoRepositoryProvider = Provider((ref) => AbastecimentoRepository());

final abastecimentosProvider = StreamProvider.family<List<Abastecimento>, String>((ref, veiculoId) {
  return ref.read(abastecimentoRepositoryProvider).listarPorVeiculo(veiculoId);
});

class AbastecimentoController {
  final AbastecimentoRepository repo;
  AbastecimentoController(this.repo);

  Future<void> cadastrar(Abastecimento a) => repo.cadastrar(a);
  Future<void> atualizar(Abastecimento a) => repo.atualizar(a);
  Future<void> excluir(String id) => repo.excluir(id);
}

final abastecimentoControllerProvider = Provider((ref) {
  return AbastecimentoController(ref.read(abastecimentoRepositoryProvider));
});

final todosAbastecimentosProvider = FutureProvider((ref) async {
  final firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('abastecimentos').orderBy('data', descending: true).get();
  return snapshot.docs.map((doc) => Abastecimento.fromFirestore(doc)).toList();
});