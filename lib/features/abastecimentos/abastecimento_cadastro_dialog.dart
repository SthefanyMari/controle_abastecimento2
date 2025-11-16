import 'package:flutter/material.dart';
import 'abastecimento.dart';
import 'abastecimento_controller.dart';

class AbastecimentoCadastroDialog extends StatefulWidget {
  final AbastecimentoController controller;
  final String veiculoId;
  final Abastecimento? abastecimentoExistente;

  const AbastecimentoCadastroDialog({
    super.key,
    required this.controller,
    required this.veiculoId,
    this.abastecimentoExistente,
  });
  

  @override
  State<AbastecimentoCadastroDialog> createState() => _AbastecimentoCadastroDialogState();
}

class _AbastecimentoCadastroDialogState extends State<AbastecimentoCadastroDialog> {
  final _formKey = GlobalKey<FormState>();
  final dataCtrl = TextEditingController();
  final litrosCtrl = TextEditingController();
  final valorCtrl = TextEditingController();
  final kmCtrl = TextEditingController();
  final tipoCtrl = TextEditingController();
  final consumoCtrl = TextEditingController();
  final obsCtrl = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final a = widget.abastecimentoExistente;
    if (a != null) {
      dataCtrl.text = a.data.toIso8601String().substring(0, 10);
      litrosCtrl.text = a.quantidadeLitros.toString();
      valorCtrl.text = a.valorPago.toString();
      kmCtrl.text = a.quilometragem.toString();
      tipoCtrl.text = a.tipoCombustivel;
      consumoCtrl.text = a.consumo.toString();
      obsCtrl.text = a.observacao;
    }
  }

  @override
  void dispose() {
    dataCtrl.dispose();
    litrosCtrl.dispose();
    valorCtrl.dispose();
    kmCtrl.dispose();
    tipoCtrl.dispose();
    consumoCtrl.dispose();
    obsCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSalvar() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final data = DateTime.tryParse(dataCtrl.text.trim());
      final litros = double.tryParse(litrosCtrl.text.trim());
      final valor = double.tryParse(valorCtrl.text.trim());
      final km = int.tryParse(kmCtrl.text.trim());
      final consumo = double.tryParse(consumoCtrl.text.trim());

      if (data == null || litros == null || valor == null || km == null || consumo == null) {
        throw Exception('Campos inválidos');
      }

      final a = Abastecimento(
        id: widget.abastecimentoExistente?.id ?? '',
        data: data,
        quantidadeLitros: litros,
        valorPago: valor,
        quilometragem: km,
        tipoCombustivel: tipoCtrl.text.trim(),
        veiculoId: widget.veiculoId,
        consumo: consumo,
        observacao: obsCtrl.text.trim(),
      );

      if (widget.abastecimentoExistente == null) {
        await widget.controller.cadastrar(a);
      } else {
        await widget.controller.atualizar(a);
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.abastecimentoExistente == null ? 'Registrar Abastecimento' : 'Editar Abastecimento'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: dataCtrl,
                decoration: const InputDecoration(labelText: 'Data (AAAA-MM-DD)'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe a data' : null,
              ),
              TextFormField(
                controller: litrosCtrl,
                decoration: const InputDecoration(labelText: 'Quantidade de Litros'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || double.tryParse(v) == null ? 'Informe os litros' : null,
              ),
              TextFormField(
                controller: valorCtrl,
                decoration: const InputDecoration(labelText: 'Valor Pago'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || double.tryParse(v) == null ? 'Informe o valor' : null,
              ),
              TextFormField(
                controller: kmCtrl,
                decoration: const InputDecoration(labelText: 'Quilometragem'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null ? 'Informe a quilometragem' : null,
              ),
              TextFormField(
                controller: tipoCtrl,
                decoration: const InputDecoration(labelText: 'Tipo de Combustível'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe o combustível' : null,
              ),
              TextFormField(
                controller: consumoCtrl,
                decoration: const InputDecoration(labelText: 'Consumo (km/L)'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || double.tryParse(v) == null ? 'Informe o consumo' : null,
              ),
              TextFormField(
                controller: obsCtrl,
                decoration: const InputDecoration(labelText: 'Observação'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton.icon(
          onPressed: _isSaving ? null : _onSalvar,
          icon: _isSaving
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.save),
          label: const Text('Salvar'),
        ),
      ],
    );
  }
}
