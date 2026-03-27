import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class TanggalLahirPage extends StatefulWidget {
  final MenuModel menu;
  const TanggalLahirPage({super.key, required this.menu});

  @override
  State<TanggalLahirPage> createState() => _TanggalLahirPageState();
}

class _TanggalLahirPageState extends State<TanggalLahirPage> {
  late DateTime _selectedDate;
  TimeOfDay _selectedTime = TimeOfDay.now();
  Map<String, int>? _hasilUmur;
  int? _selectedMonth;
  int? _selectedYear;
  Key _calendarKey = UniqueKey();

  late List<int> _listTahun;
  final List<String> _namaBulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedMonth = _selectedDate.month;
    _selectedYear = _selectedDate.year;
    _listTahun = List<int>.generate(2100 - 1900 + 1, (index) => 1900 + index);
  }

  void _updateDateFromDropdown() {
    int year = _selectedYear!;
    int month = _selectedMonth!;
    int day = _selectedDate.day;

    int maxDaysInMonth = DateUtils.getDaysInMonth(year, month);
    if (day > maxDaysInMonth) day = maxDaysInMonth;

    _selectedDate = DateTime(year, month, day, _selectedTime.hour, _selectedTime.minute);
    _calendarKey = UniqueKey();
    _hasilUmur = null;
  }

  void _hitungUmurDetail() {
    DateTime birthDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    DateTime now = DateTime.now();

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    setState(() {
      _hasilUmur = {
        "tahun": years,
        "bulan": months,
        "hari": days,
        "jam": now.difference(birthDate).inHours % 24,
        "menit": now.difference(birthDate).inMinutes % 60,
      };
    });
  }

  Future<void> _pickTime() async {
    final TimeOfDay? t = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (t != null) {
      setState(() {
        _selectedTime = t;
        _hasilUmur = null;
      });
    }
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.hourglass_empty, color: Colors.white70, size: 28),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Kalkulator Umur Detail',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('Hitung usia Anda hingga satuan menit',
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildDropdown('Bulan', _selectedMonth, (val) {
                    if (val != null) {
                      setState(() {
                        _selectedMonth = val;
                        _updateDateFromDropdown();
                      });
                    }
                  }, List.generate(12, (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text(_namaBulan[index], style: const TextStyle(fontSize: 14)),
                  ))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildDropdown('Tahun', _selectedYear, (val) {
                    if (val != null) {
                      setState(() {
                        _selectedYear = val;
                        _updateDateFromDropdown();
                      });
                    }
                  }, _listTahun.map((year) => DropdownMenuItem(
                    value: year,
                    child: Text(year.toString(), style: const TextStyle(fontSize: 14)),
                  )).toList()),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                  lastDate: DateTime.now(),
                  onDateChanged: (DateTime date) {
                    setState(() {
                      _selectedDate = date;
                      _selectedMonth = date.month;
                      _selectedYear = date.year;
                      _hasilUmur = null;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickTime,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Waktu Lahir (Jam & Menit)", style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor)),
                    Text(_selectedTime.format(context), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _hitungUmurDetail,
              icon: const Icon(Icons.calculate_outlined),
              label: const Text('Hitung Umur', style: TextStyle(fontWeight: FontWeight.bold)),
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            if (_hasilUmur != null) ...[
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
                    BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text('HASIL ANALISIS USIA',
                        style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    const SizedBox(height: 16),
                    Text('${_hasilUmur!['tahun']} Tahun',
                        style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    Text('${_hasilUmur!['bulan']} Bulan, ${_hasilUmur!['hari']} Hari',
                        style: const TextStyle(color: Colors.white, fontSize: 18)),
                    const Divider(color: Colors.white24, height: 32),
                    Text('${_hasilUmur!['jam']} Jam, ${_hasilUmur!['menit']} Menit',
                        style: const TextStyle(color: Colors.white70, fontSize: 14)),
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