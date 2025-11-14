import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; 
import 'veiculo.dart';

class VeiculoRepository {
  final _db = FirebaseFirestore.instance.collection('veiculos');

  Stream<List<Veiculo>> listar() {
    return _db.snapshots().map(
      (snap) => snap.docs.map((doc) => Veiculo.fromDoc(doc.id, doc.data())).toList(),
    );
  }

  Future<void> cadastrar(Veiculo v) async {
    try {
      final doc = _db.doc(); 
      await doc.set(v.toMap());
    } catch (e) {
      debugPrint('Erro ao salvar veículo: $e'); 
      rethrow;
    }
  }

  Future<void> atualizar(Veiculo v) async {
    await _db.doc(v.id).update(v.toMap());
  }

  Future<void> excluir(String id) async {
    await _db.doc(id).delete();
  }
}
