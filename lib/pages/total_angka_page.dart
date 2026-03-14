import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class TotalAngkaPage extends StatefulWidget {
  final MenuModel menu;
  const TotalAngkaPage({super.key, required this.menu});

  @override
  State<TotalAngkaPage> createState() => _TotalAngkaPageState();
}

class _TotalAngkaPageState extends State<TotalAngkaPage> {
  final _controller = TextEditingController();
  String _hasil = '';

  void _hitungJumlahAngka() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() => _hasil = 'Masukkan data terlebih dahulu!');
      return;
    }

    // Buat ambil angka (membuang huruf/simbol jika ada)
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      setState(() => _hasil = 'Tidak ada angka ditemukan!');
      return;
    }

    int total = 0;
    List<String> listDigit = digits.split('');
    
    for (var digit in listDigit) {
      total += int.parse(digit);
    }

    setState(() {
      _hasil = '${listDigit.join(' + ')} = $total';
    });
  }

  void _reset() {
    setState(() {
      _controller.clear();
      _hasil = '';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(widget.menu.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan angka',
                hintText: 'Contoh: 12345',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: _controller.text.isNotEmpty 
                  ? IconButton(onPressed: _reset, icon: const Icon(Icons.close)) 
                  : null,
              ),
            ),
            const SizedBox(height: 20),
            
            Row(
              children: [

                // Tombol Hitung
                Expanded(
                  flex: 2, 
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _hitungJumlahAngka,
                      icon: const Icon(Icons.calculate, size: 20),
                      label: const Text('Hitung'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Tombol Reset
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.deepPurple,
                        side: const BorderSide(color: Colors.deepPurple),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            if (_hasil.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                ),
                child: Column(
                  children: [
                    const Text('HASIL PERHITUNGAN', style: TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 1.2)),
                    const SizedBox(height: 12),
                    Text(
                      _hasil,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}