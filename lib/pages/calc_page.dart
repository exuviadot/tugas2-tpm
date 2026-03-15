import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_2/models/menu_model.dart';

class CalcPage extends StatefulWidget {
  final MenuModel menu;
  const CalcPage({super.key, required this.menu});

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  String _output = "0";
  String _input = "";
  double? _num1;
  String _operator = "";
  String _history = "";

  final NumberFormat _formatter = NumberFormat('#,###');

  void _calculate() {
    if (_num1 == null || _operator.isEmpty || _input.isEmpty) return;
    double num2 = double.tryParse(_input) ?? 0;

    double result = 0;
    if (_operator == "+") {
      result = _num1! + num2;
    } else if (_operator == "-") {
      result = _num1! - num2;
    }
    _output = result.toString().replaceAll(".0", "");
    _num1 = result;
  }

  String _formatNumber(String val) {
    if (val.isEmpty || val == "0") return "0";

    if (val.contains('.')) {
      List <String> parts = val.split('.');
      String integerPart = parts[0];
      String decimalPart = parts[1];

      String formattedInteger = _formatter.format(int.tryParse(integerPart) ?? 0);
      return '$formattedInteger.$decimalPart';
    }

    return _formatter.format(int.tryParse(val) ?? 0);
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _num1 = null;
        _operator = "";
        _history = "";
      } else if (value == "⌫") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          _output = _input.isEmpty ? "0" : _input;
        }
      } else if (value == "+" || value == "-") {
        if (_input.isNotEmpty) {
          if (_num1 == null) {
            _num1 = double.tryParse(_input);
          } else {
            _calculate();
          }
          _operator = value;
          _history = "${_num1.toString().replaceAll(".0", "")} $_operator";
          _input = "";
        }
      } else if (value == "=") {
        if (_num1 != null && _input.isNotEmpty) {
          double num2 = double.tryParse(_input) ?? 0;
          _history = "${_num1.toString().replaceAll(".0", "")} $_operator ${num2.toString().replaceAll(".0", "")} =";
          _calculate();
          _input = _output;
          _num1 = null;
          _operator = "";
        }
      } else {
        if (_input == "0" && value == "0") return;
        _input += value;
        _output = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(widget.menu.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(_history, style: const TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 8),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _formatNumber(_output),
                          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _buildRow(["C", "⌫", "", ""]), 
                      _buildRow(["7", "8", "9", "-"]),
                      _buildRow(["4", "5", "6", "+"]),
                      _buildRow(["1", "2", "3", "="]),
                      _buildRow(["", "0", ".", ""]), 
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> values) {
    return Row(
      children: values.map((val) => _buildButton(val)).toList(),
    );
  }

  Widget _buildButton(String val) {
    if (val.isEmpty) return Expanded(child: Container());
    bool isOperator = val == "+" || val == "-" || val == "=" || val == "C" || val == "⌫" || val == ".";
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: AspectRatio(
          aspectRatio: 1.2,
          child: ElevatedButton(
            onPressed: () => _onButtonPressed(val),
            style: ElevatedButton.styleFrom(
              backgroundColor: isOperator ? Colors.deepPurple.shade50 : Colors.grey.shade100,
              foregroundColor: isOperator ? Colors.deepPurple : Colors.black87,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(val, style: const TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}