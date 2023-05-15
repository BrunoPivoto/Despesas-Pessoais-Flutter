import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({required this.onSubmit, super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value =
        double.tryParse(_valueController.text.replaceAll(',', '.')) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Nova transação',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: _titleController,
                        decoration: const InputDecoration(
                            labelText: 'Título', border: OutlineInputBorder())),
                    const SizedBox(
                      height: 7.5,
                    ),
                    TextField(
                        controller: _valueController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onSubmitted: (value) => _submitForm(),
                        decoration: const InputDecoration(
                            labelText: 'Valor R\$',
                            border: OutlineInputBorder())),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate == DateTime(0, 0, 0)
                                ? 'Nenhuma data selecionada'
                                : 'Data: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                        ),
                        TextButton(
                            onPressed: _showDatePicker,
                            child: const Text('Alterar Data'))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            child: const Text(
                              'Nova transação',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
