import 'package:cloud_firestore/cloud_firestore.dart';

class Abastecimento {
  final String id;
  final DateTime data;
  final double quantidadeLitros;
  final double valorPago;
  final int quilometragem;
  final String tipoCombustivel;
  final String veiculoId;
  final double consumo;
  final String observacao;

  Abastecimento({
    required this.id,
    required this.data,
    required this.quantidadeLitros,
    required this.valorPago,
    required this.quilometragem,
    required this.tipoCombustivel,
    required this.veiculoId,
    required this.consumo,
    required this.observacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data.toIso8601String(),
      'quantidadeLitros': quantidadeLitros,
      'valorPago': valorPago,
      'quilometragem': quilometragem,
      'tipoCombustivel': tipoCombustivel,
      'veiculoId': veiculoId,
      'consumo': consumo,
      'observacao': observacao,
    };
  }

factory Abastecimento.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Abastecimento(
      id: doc.id,
      data: DateTime.parse(data['data']),
      quantidadeLitros: (data['quantidadeLitros'] as num).toDouble(),
      valorPago: (data['valorPago'] as num).toDouble(),
      quilometragem: data['quilometragem'],
      tipoCombustivel: data['tipoCombustivel'],
      veiculoId: data['veiculoId'],
      consumo: (data['consumo'] as num).toDouble(),
      observacao: data['observacao'] ?? '',
    );
  }

}