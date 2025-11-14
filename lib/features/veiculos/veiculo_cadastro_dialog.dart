import 'package:flutter/material.dart';
import 'veiculo.dart';
import 'veiculo_controller.dart';

class CadastroVeiculoDialog extends StatefulWidget {
  final VeiculoController controller;
  final Veiculo? veiculoExistente; 

  const CadastroVeiculoDialog({
    super.key,
    required this.controller,
    this.veiculoExistente,
  });

  @override
  State<CadastroVeiculoDialog> createState() => _CadastroVeiculoDialogState();
}

class _CadastroVeiculoDialogState extends State<CadastroVeiculoDialog> {
  final _formKey = GlobalKey<FormState>();
  final modeloCtrl = TextEditingController();
  final marcaCtrl = TextEditingController();
  final placaCtrl = TextEditingController();
  final anoCtrl = TextEditingController();
  final tipoCtrl = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final v = widget.veiculoExistente;
    if (v != null) {
      modeloCtrl.text = v.modelo;
      marcaCtrl.text = v.marca;
      placaCtrl.text = v.placa;
      anoCtrl.text = v.ano.toString();
      tipoCtrl.text = v.tipoCombustivel;
    }
  }

  @override
  void dispose() {
    modeloCtrl.dispose();
    marcaCtrl.dispose();
    placaCtrl.dispose();
    anoCtrl.dispose();
    tipoCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSalvar() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final ano = int.tryParse(anoCtrl.text.trim());
      if (ano == null) throw Exception('Ano inválido');

      final v = Veiculo(
        id: widget.veiculoExistente?.id ?? '',
        modelo: modeloCtrl.text.trim(),
        marca: marcaCtrl.text.trim(),
        placa: placaCtrl.text.trim(),
        ano: ano,
        tipoCombustivel: tipoCtrl.text.trim(),
      );

      if (widget.veiculoExistente == null) {
        await widget.controller.cadastrar(v);
      } else {
        await widget.controller.atualizar(v);
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
      title: Text(widget.veiculoExistente == null ? 'Cadastrar Veículo' : 'Editar Veículo'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: modeloCtrl,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe o modelo' : null,
              ),
              TextFormField(
                controller: marcaCtrl,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe a marca' : null,
              ),
              TextFormField(
                controller: placaCtrl,
                decoration: const InputDecoration(labelText: 'Placa'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe a placa' : null,
              ),
              TextFormField(
                controller: anoCtrl,
                decoration: const InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Informe o ano';
                  if (int.tryParse(v.trim()) == null) return 'Digite apenas números';
                  return null;
                },
              ),
              TextFormField(
                controller: tipoCtrl,
                decoration: const InputDecoration(labelText: 'Tipo de Combustível'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe o combustível' : null,
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
