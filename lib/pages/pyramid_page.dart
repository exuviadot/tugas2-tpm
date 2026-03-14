import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

const _units = ['mm', 'cm', 'm', 'km'];

class PyramidPage extends StatefulWidget {
  final MenuModel menu;
  const PyramidPage({super.key, required this.menu});
  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final _formKey = GlobalKey<FormState>();
  final _sisiCtrl = TextEditingController();
  final _tinggiCtrl = TextEditingController();
  String _unit = 'cm';
  double? _vol, _luas;

  @override
  void dispose() {
    _sisiCtrl.dispose();
    _tinggiCtrl.dispose();
    super.dispose();
  }

  void _hitung() {
    if (!_formKey.currentState!.validate()) return;
    final s = double.parse(_sisiCtrl.text);
    final t = double.parse(_tinggiCtrl.text);
    final ts = sqrt(t * t + (s / 2) * (s / 2));
    setState(() {
      _vol = s * s * t / 3;
      _luas = s * s + 2 * s * ts;
    });
  }

  void _reset() {
    _sisiCtrl.clear();
    _tinggiCtrl.clear();
    setState(() => _vol = _luas = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      appBar: AppBar(
        title: Text(widget.menu.title,
            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        backgroundColor: const Color(0xFF4A2C8F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A2C8F),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(children: [
                  const Icon(Icons.change_history, color: Colors.white70, size: 28),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Limas Segi Empat',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('V = ⅓s²t   |   L = s² + 4×½×s×t꜀',
                        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
                  ]),
                ]),
              ),
              const SizedBox(height: 20),

              Row(children: [
                const Text('Satuan', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4A2C8F))),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _units.map((u) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(u),
                          selected: _unit == u,
                          onSelected: (_) => setState(() => _unit = u),
                          selectedColor: const Color(0xFF4A2C8F),
                          labelStyle: TextStyle(
                            color: _unit == u ? Colors.white : const Color(0xFF4A2C8F),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(color: Color(0xFF4A2C8F)),
                        ),
                      )).toList(),
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 16),

              _field(_sisiCtrl, 'Sisi Alas (s)', Icons.straighten),
              const SizedBox(height: 12),
              _field(_tinggiCtrl, 'Tinggi Limas (t)', Icons.vertical_align_top),
              const SizedBox(height: 20),

              Row(children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _hitung,
                    icon: const Icon(Icons.calculate_outlined),
                    label: const Text('Hitung', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF4A2C8F),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.outlined(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh_rounded),
                  color: const Color(0xFF4A2C8F),
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF4A2C8F)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.all(14),
                  ),
                ),
              ]),

              if (_vol != null) ...[
                const SizedBox(height: 24),
                _resultCard(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label, IconData icon) =>
      TextFormField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF4A2C8F), size: 20),
          suffixText: _unit,
          suffixStyle: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4A2C8F)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFF4A2C8F), width: 2)),
        ),
        validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Inputan harus berupa angka bernilai positif' : null,
      );

  Widget _resultCard() => Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A2C8F), Color(0xFF7B52D3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: const Color(0xFF4A2C8F).withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          _resultTile(Icons.view_in_ar_rounded, 'Volume', _vol!, '$_unit³'),
          const Divider(color: Colors.white24, height: 24),
          _resultTile(Icons.layers_outlined, 'Luas Permukaan', _luas!, '$_unit²'),
        ]),
      );

  Widget _resultTile(IconData icon, String label, double value, String unit) =>
      Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 14),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const Spacer(),
        RichText(
          text: TextSpan(
            text: value.toStringAsFixed(2),
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            children: [TextSpan(text: ' $unit', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white60))],
          ),
        ),
      ]);
}
