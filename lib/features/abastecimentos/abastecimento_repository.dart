import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'abastecimento.dart';

class AbastecimentoRepository {
  final _db = FirebaseFirestore.instance.collection('abastecimentos');

  Stream<List<Abastecimento>> listarPorVeiculo(String veiculoId) {
    return _db.where('veiculoId', isEqualTo: veiculoId).snapshots().map(
      (snap) => snap.docs.map((doc) => Abastecimento.fromDoc(doc.id, doc.data())).toList(),
    );
  }

  Future<void> cadastrar(Abastecimento a) async {
    try {
      final doc = _db.doc();
      await doc.set(a.toMap());
    } catch (e) {
      debugPrint('Erro ao salvar abastecimento: $e');
      rethrow;
    }
  }

  Future<void> atualizar(Abastecimento a) async {
    await _db.doc(a.id).update(a.toMap());
  }

  Future<void> excluir(String id) async {
    await _db.doc(id).delete();
  }
}
