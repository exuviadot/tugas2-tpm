import 'package:flutter/material.dart';
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
  double _num1 = 0;
  String _operator = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _num1 = 0;
        _operator = "";
      } else if (value == "⌫") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          _output = _input.isEmpty ? "0" : _input;
        }
      } else if (value == "+" || value == "-") {
        _num1 = double.tryParse(_input) ?? 0;
        _operator = value;
        _input = "";
      } else if (value == ".") {

        // buat titik
        if (!_input.contains(".")) {
          _input = _input.isEmpty ? "0." : _input + ".";
          _output = _input;
        }
      } else if (value == "=") {
        double num2 = double.tryParse(_input) ?? 0;
        if (_operator == "+") {
          _output = (_num1 + num2).toString();
        } else if (_operator == "-") {
          _output = (_num1 - num2).toString();
        }

        if (_output.endsWith(".0")) {
          _output = _output.substring(0, _output.length - 2);
        }
        
        _input = _output;
        _operator = "";
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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          widget.menu.title, 
          style: const TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _operator.isEmpty ? "" : "${_num1.toString().replaceAll(".0", "")} $_operator",
                    style: const TextStyle(
                      fontSize: 24, 
                      color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _output,
                      style: const TextStyle(
                        fontSize: 80, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.deepPurple
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [BoxShadow(
                  color: Colors.black12, 
                  blurRadius: 10, 
                  offset: Offset(0, -2)
                )],
              ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> values) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: values.map((val) => _buildButton(val)).toList(),
      ),
    );
  }

  Widget _buildButton(String val) {
    if (val.isEmpty) return Expanded(child: Container());

    bool isOperator = val == "+" || val == "-" || val == "=" || val == "C" || val == "⌫" || val == ".";
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(val),
          style: ElevatedButton.styleFrom(
            backgroundColor: isOperator ? Colors.deepPurple.shade50 : Colors.grey.shade100,
            foregroundColor: isOperator ? Colors.deepPurple : Colors.black87,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text(
            val,
            style: TextStyle(
              fontSize: 24, 
              fontWeight: isOperator ? FontWeight.bold : FontWeight.normal
            ),
          ),
        ),
      ),
    );
  }
}