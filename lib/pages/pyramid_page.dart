import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

const _units = ['mm', 'cm', 'dm', 'm', 'dam', 'hm', 'km'];

const _unitValues = {
  'mm': 0.001, 'cm': 0.01, 'dm': 0.1, 'm': 1.0, 
  'dam': 10.0, 'hm': 100.0, 'km': 1000.0,
};

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
  String _inputUnit = 'cm';
  double? _sisiAwal, _tinggiAwal;
  String? _satuanAwal;
  String? _displayUnit; 
  String _targetConvertUnit = 'cm'; 
  double? _vol, _luas;

  @override
  void dispose() {
    _sisiCtrl.dispose();
    _tinggiCtrl.dispose();
    super.dispose();
  }

  void _hitung() {
    if (!_formKey.currentState!.validate()) return;
    _sisiAwal = double.parse(_sisiCtrl.text);
    _tinggiAwal = double.parse(_tinggiCtrl.text);
    _satuanAwal = _inputUnit;
    _targetConvertUnit = _inputUnit;
    _kalkulasi(_sisiAwal!, _tinggiAwal!, 1.0, _inputUnit);
  }

  void _konversi() {
    if (_sisiAwal == null || _satuanAwal == null) return;
    final double conversionFactor = _unitValues[_satuanAwal]! / _unitValues[_targetConvertUnit]!;
    
    _kalkulasi(_sisiAwal!, _tinggiAwal!, conversionFactor, _targetConvertUnit);
  }

  void _kalkulasi(double sRaw, double tRaw, double factor, String newUnit) {
    final s = sRaw * factor;
    final t = tRaw * factor;
    final ts = sqrt(t * t + (s / 2) * (s / 2));
    
    setState(() {
      _vol = s * s * t / 3;
      _luas = s * s + 2 * s * ts;
      _displayUnit = newUnit; 
    });
  }

  void _reset() {
    _sisiCtrl.clear();
    _tinggiCtrl.clear();
    setState(() {
      _vol = _luas = _sisiAwal = _tinggiAwal = _satuanAwal = _displayUnit = null;
      _inputUnit = 'cm';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, 
      appBar: AppBar(
        title: Text(widget.menu.title,
            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        backgroundColor: Colors.deepPurple, 
        foregroundColor: Colors.white,
        centerTitle: true, 
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
                  color: Colors.deepPurple, 
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
                const Text('Satuan', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.deepPurple)),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _units.map((u) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(u),
                          selected: _inputUnit == u,
                          onSelected: (_) => setState(() => _inputUnit = u),
                          selectedColor: Colors.deepPurple,
                          labelStyle: TextStyle(
                            color: _inputUnit == u ? Colors.white : Colors.deepPurple,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(color: Colors.deepPurple),
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
                      backgroundColor: Colors.deepPurple, 
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.outlined(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh_rounded),
                  color: Colors.deepPurple, 
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: Colors.deepPurple),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.all(14),
                  ),
                ),
              ]),

              if (_vol != null) ...[
                const SizedBox(height: 24),
                _resultCard(),
                const SizedBox(height: 20),
                _conversionSection(),
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
          prefixIcon: Icon(icon, color: Colors.deepPurple, size: 20), 
          suffixText: _inputUnit,
          suffixStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.deepPurple),
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
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2)), 
        ),
        validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0 ? 'Inputan harus berupa angka bernilai positif' : null,
      );

  Widget _resultCard() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.deepPurple.shade400], 
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          _resultTile(Icons.view_in_ar_rounded, 'Volume', _vol!, '$_displayUnit³'),
          const Divider(color: Colors.white24, height: 24),
          _resultTile(Icons.layers_outlined, 'Luas Permukaan', _luas!, '$_displayUnit²'),
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
            text: value == 0 ? "0" 
                : (value.abs() < 0.01 || value.abs() > 1000000)
                  ? value.toStringAsExponential(2) : value.toStringAsFixed(2).replaceAll(RegExp(r'\.?0*$'), ''),
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: ' $unit', 
                style: const TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.normal, 
                  color: Colors.white60
                )
              )
            ],
          ),
        ),
      ]);

  Widget _conversionSection() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Konversi Hasil Ke:', 
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 14)),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _units.map((u) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(u),
                    selected: _targetConvertUnit == u,
                    onSelected: (_) => setState(() => _targetConvertUnit = u),
                    selectedColor: Colors.deepPurple.shade50, 
                    labelStyle: TextStyle(
                      color: _targetConvertUnit == u ? Colors.deepPurple : Colors.grey.shade600,
                      fontWeight: _targetConvertUnit == u ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _konversi, 
                icon: const Icon(Icons.sync_alt_rounded, size: 18),
                label: const Text('Konversi Sekarang'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepPurple, 
                  side: const BorderSide(color: Colors.deepPurple),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            )
          ],
        ),
      );
}