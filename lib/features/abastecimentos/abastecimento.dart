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

  factory Abastecimento.fromDoc(String id, Map<String, dynamic> doc) {
    return Abastecimento(
      id: id,
      data: DateTime.parse(doc['data']),
      quantidadeLitros: (doc['quantidadeLitros'] as num).toDouble(),
      valorPago: (doc['valorPago'] as num).toDouble(),
      quilometragem: doc['quilometragem'],
      tipoCombustivel: doc['tipoCombustivel'],
      veiculoId: doc['veiculoId'],
      consumo: (doc['consumo'] as num).toDouble(),
      observacao: doc['observacao'] ?? '',
    );
  }
}
