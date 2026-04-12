import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class SakaPage extends StatefulWidget {
  final MenuModel menu;
  const SakaPage({super.key, required this.menu});

  @override
  State<SakaPage> createState() => _SakaPageState();
}

class _SakaPageState extends State<SakaPage> {
  late DateTime _selectedDate;
  String? _hasilSaka;
  int? _selectedMonth;
  int? _selectedYear;
  Key _calendarKey = UniqueKey();

  late List<int> _listTahun;
  final List<String> _namaBulanMasehi = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  // Data Kalender Saka
  final List<String> _namaSasih = [
    'Kasa', 'Karo', 'Katiga', 'Kapat', 'Kalima', 'Kanem',
    'Kapitu', 'Kawalu', 'Kasanga', 'Kadasa', 'Jiyestha', 'Sadha'
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

    setState(() {
      _selectedDate = DateTime(year, month, day);
      _calendarKey = UniqueKey();
      _hasilSaka = null;
    });
  }

  // 1. Tambahkan Mapping Nyepi di dalam Class State
  final Map<int, DateTime> _dataNyepi = {
    2023: DateTime(2023, 3, 22),
    2024: DateTime(2024, 3, 11),
    2025: DateTime(2025, 3, 29),
    2026: DateTime(2026, 3, 19), // Referensi yang kamu cek tadi
    2027: DateTime(2027, 3, 8),
    2028: DateTime(2028, 3, 26),
  };

  void _hitungKonversi() {
    int tahunPilihan = _selectedDate.year;
    
    // 2. Ambil referensi Nyepi untuk tahun tersebut
    // Jika tahun tidak ada di map, kita pakai default 2026
    DateTime nyepiTahunIni = _dataNyepi[tahunPilihan] ?? DateTime(tahunPilihan, 3, 20);
    
    // 3. Tentukan Tahun Saka
    int tahunSaka = tahunPilihan - 78;
    if (_selectedDate.isBefore(nyepiTahunIni)) {
      tahunSaka -= 1;
    }

    // 4. Hitung Tanggal (Penanggal/Panglong)
    // Referensi: Nyepi selalu Penanggal 1. Berarti sehari sebelumnya (Nyepi - 1) adalah Tilem.
    DateTime refTilem = nyepiTahunIni.subtract(const Duration(days: 1));
    int selisihHari = _selectedDate.difference(refTilem).inDays;
    
    // Normalisasi siklus bulan (0-29)
    int siklus = selisihHari % 30;
    if (siklus < 0) siklus += 30;

    String infoFase;
    int tglSaka;

    if (siklus == 0) {
      infoFase = "Tilem";
      tglSaka = 9; // Tilem Sasih Kasanga
    } else if (siklus <= 15) {
      infoFase = "Penanggal";
      tglSaka = siklus;
    } else {
      infoFase = "Panglong";
      tglSaka = siklus - 15;
    }

    // 5. Penentuan Sasih (Bulan)
    // Nyepi selalu awal Sasih Kadasa (Bulan 10)
    // Kita hitung jarak bulan dari Maret (Kadasa)
    int indexSasih;
    if (_selectedDate.isBefore(nyepiTahunIni)) {
      // Sebelum nyepi biasanya Sasih Kasanga (9) atau sebelumnya
      indexSasih = (9 - (nyepiTahunIni.month - _selectedDate.month)) % 12;
    } else {
      // Setelah nyepi masuk Sasih Kadasa (10) dan seterusnya
      indexSasih = (9 + (_selectedDate.month - nyepiTahunIni.month)) % 12;
    }
    
    if (indexSasih < 0) indexSasih += 12;
    String sasih = _namaSasih[indexSasih];

    setState(() {
      _hasilSaka = '$infoFase $tglSaka, Sasih $sasih $tahunSaka';
      
      // Cek jika hari ini tepat Nyepi
      if (_selectedDate.day == nyepiTahunIni.day && _selectedDate.month == nyepiTahunIni.month) {
        _hasilSaka = "Selamat Hari Raya Nyepi\n$_hasilSaka";
      }
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
                  const Icon(Icons.temple_hindu_outlined, color: Colors.white70, size: 28),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Konversi ke Tahun Saka',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('Ubah tanggal Masehi ke penanggalan Saka',
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
                      _hasilSaka = null;
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
            if (_hasilSaka != null) ...[
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
                      'TANGGAL TAHUN SAKA',
                      style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _hasilSaka!,
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
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