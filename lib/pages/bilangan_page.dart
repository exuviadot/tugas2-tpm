import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class BilanganPage extends StatefulWidget {
  final MenuModel menu;
  const BilanganPage({super.key, required this.menu});
  @override
  State<BilanganPage> createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
  final _ctrl = TextEditingController();

  bool _isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= sqrt(n); i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _cek() {
    final n = int.tryParse(_ctrl.text);
    if (n == null) {
      _showDialog('Inputan harus berupa angka');
      return;
    }
    final parity = n % 2 == 0 ? 'Genap' : 'Ganjil';
    final prime = _isPrime(n) ? 'Prima' : 'Bukan Prima';
    _showDialog('$n adalah bilangan $parity dan $prime');
  }

  void _showDialog(String msg) => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(widget.menu.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _ctrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Masukkan angka'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: _cek,
              child: const Text('Cek'),
            ),
          ],
        ),
      ),
    );
  }
}