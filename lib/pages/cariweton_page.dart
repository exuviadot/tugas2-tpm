import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class CariWetonPage extends StatefulWidget {
  final MenuModel menu;
  const CariWetonPage({super.key, required this.menu});

  @override
  State<CariWetonPage> createState() => _CariWetonPageState();
}

class _CariWetonPageState extends State<CariWetonPage> {
  late DateTime _selectedDate;
  String? _weton;
  int? _selectedMonth;
  int? _selectedYear;
  Key _calendarKey = UniqueKey();
  
  late List<int> _listTahun;
  final List<String> _namaBulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  final List<String> _hariList = [
    '', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
  ];

  final List<String> _pasaranList = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];
  final DateTime _referensiTanggal = DateTime(1900, 1, 1);
  final int _referensiPasaranIndex = 1;

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
    if (day > maxDaysInMonth) {
      day = maxDaysInMonth;
    }

    _selectedDate = DateTime(year, month, day);
    _calendarKey = UniqueKey(); 
    _weton = null; 
  }

  String _hitungPasaran(DateTime tanggal) {
    int selisihHari = tanggal.difference(_referensiTanggal).inDays;
    int pasaranIndex = (_referensiPasaranIndex + selisihHari) % 5;
    return _pasaranList[pasaranIndex];
  }

  void _hitungWeton() {
    String hari = _hariList[_selectedDate.weekday];
    String pasaran = _hitungPasaran(_selectedDate);

    setState(() {
      _weton = '$hari $pasaran';
    });
  }

  String _formatTanggalLengkap(DateTime date) {
    String hariAsli = _hariList[date.weekday];
    return '$hariAsli, ${date.day} ${_namaBulan[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.deepPurple;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          widget.menu.title,
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
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
            // Header card (Gaya PyramidPage)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_stories, color: Colors.white70, size: 28),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cari Weton Jawa',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('Tentukan hari lahir dan pasaran Anda',
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
                  lastDate: DateTime(2100, 12, 31),
                  onDateChanged: (DateTime date) {
                    setState(() {
                      _selectedDate = date;
                      _selectedMonth = date.month;
                      _selectedYear = date.year;
                      _weton = null;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: _hitungWeton,
              icon: const Icon(Icons.calculate_outlined),
              label: const Text('Cari Weton', style: TextStyle(fontWeight: FontWeight.bold)),
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            if (_weton != null) ...[
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
                      'HASIL WETON JAWA',
                      style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _weton!,
                      style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const Divider(color: Colors.white24, height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.event_available, color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          _formatTanggalLengkap(_selectedDate),
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
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
    );
  }
}