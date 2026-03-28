import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';
import 'package:hijri_date/hijri.dart';

class HijriyahPage extends StatefulWidget {
  final MenuModel menu;
  const HijriyahPage({super.key, required this.menu});

  @override
  State<HijriyahPage> createState() => _HijriyahPageState();
}

class _HijriyahPageState extends State<HijriyahPage> {
  late DateTime _selectedDate;
  String? _hasilHijriyah;
  int? _selectedMonth;
  int? _selectedYear;
  Key _calendarKey = UniqueKey();

  late List<int> _listTahun;
  final List<String> _namaBulanMasehi = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  @override
  void initState() {
    super.initState();

    HijriDate.setLocal('id');

    _selectedDate = DateTime.now();
    _selectedMonth = _selectedDate.month;
    _selectedYear = _selectedDate.year;
    _listTahun = List<int>.generate(2100 - 1900 + 1, (index) => 1900 + index);
  }

  void _updateDateFromDropdown(){
    int year = _selectedYear!;
    int month = _selectedMonth!;
    int day = _selectedDate.day;

    int maxDaysInMonth = DateUtils.getDaysInMonth(year, month);
    if (day > maxDaysInMonth) day = maxDaysInMonth;

    setState(() {
      _selectedDate = DateTime(year, month, day);
      _calendarKey = UniqueKey();
      _hasilHijriyah = null;
    });
  }

  void _hitungKonversi() {
    final hijriDate = HijriDate.fromDate(_selectedDate);

    setState(() {
      _hasilHijriyah = '${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear} H';
    });
  }

  String _formatTanggalMasehi(DateTime date) {
    return '${date.day} ${_namaBulanMasehi[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.deepPurple;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(widget.menu.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.mosque, color: Colors.white70, size: 28),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Konversi ke Hijriyah',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('Ubah tanggal Masehi ke penanggalan Islam',
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown Pemilih
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildDropdown('Bulan Masehi', _selectedMonth, (val) {
                    if (val != null) {
                      _selectedMonth = val;
                      _updateDateFromDropdown();
                    }
                  }, List.generate(12, (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text(_namaBulanMasehi[index], style: const TextStyle(fontSize: 14)),
                  ))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildDropdown('Tahun', _selectedYear, (val) {
                    if (val != null) {
                      _selectedYear = val;
                      _updateDateFromDropdown();
                    }
                  }, _listTahun.map((year) => DropdownMenuItem(
                    value: year,
                    child: Text(year.toString(), style: const TextStyle(fontSize: 14)),
                  )).toList()),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Calendar Picker
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: primaryColor),
                ),
                child: CalendarDatePicker(
                  key: _calendarKey,
                  initialDate: _selectedDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100, 12, 31),
                  onDateChanged: (DateTime date) {
                    setState(() {
                      _selectedDate = date;
                      _selectedMonth = date.month;
                      _selectedYear = date.year;
                      _hasilHijriyah = null;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tombol Konversi
            FilledButton.icon(
              onPressed: _hitungKonversi,
              icon: const Icon(Icons.sync_alt),
              label: const Text('Konversi Sekarang', style: TextStyle(fontWeight: FontWeight.bold)),
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            // Result Card
            if (_hasilHijriyah != null) ...[
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'TANGGAL HIJRIYAH',
                      style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _hasilHijriyah!,
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(color: Colors.white24, height: 32),
                    Text(
                      'Masehi: ${_formatTanggalMasehi(_selectedDate)}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, int? value, ValueChanged<int?> onChanged, List<DropdownMenuItem<int>> items) {
    return DropdownButtonFormField<int>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.deepPurple, width: 2)),
      ),
    );
  }
}