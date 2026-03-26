import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
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
  String _history = "";

  final NumberFormat _formatter = NumberFormat('#,###.###');

  void _calculate() {
    if (_input.isEmpty) return;
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input.replaceAll('x', '*').replaceAll(':', '/'));
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);

      _output = result.toString().endsWith(".0") 
          ? result.toStringAsFixed(0) 
          : result.toString();
      _input = _output;
    } catch (e) {
      _output = "Error";
    }
  }

  String _formatNumber(String val) {
    if (val == "Error") return val;
    if (val.isEmpty || val == "0") return "0";
    
    if (val.contains('.')) {
      List<String> parts = val.split('.');
      String formattedInteger = _formatter.format(double.tryParse(parts[0]) ?? 0);
      return '$formattedInteger.${parts[1]}';
    }
    return _formatter.format(double.tryParse(val) ?? 0);
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _history = "";
      } else if (value == "⌫") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          _output = _input.isEmpty ? "0" : _input;
          _history = _input;
        }
      } else if (value == "=") {
        _history = "$_input =";
        _calculate();
      } else {
        if (_input == "0" && value != ".") {
          _input = value;
        } else {
          _input += value;
        }
        _output = _input;
        _history = _input;
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
                  // Menggunakan .withValues untuk menghindari deprecation
                  color: Colors.black.withValues(alpha: 0.08),
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
                      _buildRow(["C", "⌫", "(", ")"]),
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
    bool isOperator = ["+", "-", "=", "C", "⌫", ".", "(", ")"].contains(val);
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