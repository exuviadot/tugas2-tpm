import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';
import 'package:tugas_2/pages/bilangan_page.dart';
import 'package:tugas_2/pages/calc_page.dart';
import 'package:tugas_2/pages/data_kelompok_page.dart';
import 'package:tugas_2/pages/hijriyah_page.dart';
import 'package:tugas_2/pages/pyramid_page.dart';
import 'package:tugas_2/pages/stopwatch_page.dart';
import 'package:tugas_2/pages/total_angka_page.dart';
import 'package:tugas_2/pages/cari_weton_page.dart';
import 'package:tugas_2/pages/tanggal_lahir.dart';

class MenuData {
  static List<MenuModel> listPage = [
    MenuModel(
      title: 'Data Kelompok', 
      subtitle: 'Nama & NIM Anggota', 
      icon: Icons.person, 
      color: Colors.pink.shade400, 
      page: (menu) => DataKelompokPage(menu: menu)
    ),

    MenuModel(
      title: 'Aritmatika', 
      subtitle: 'Penjumlahan & Pengurangan', 
      icon: Icons.calculate, 
      color: Colors.blue.shade400, 
      page: (menu) => CalcPage(menu: menu)
    ),

    MenuModel(
      title: 'Bilangan', 
      subtitle: 'Ganjil/Genap & Prima', 
      icon: Icons.numbers, 
      color: Colors.orange.shade400, 
      page: (menu) => BilanganPage(menu: menu)
    ),

    MenuModel(
      title: 'Total Field', 
      subtitle: 'Hitung Total Angka', 
      icon: Icons.summarize, 
      color: Colors.green.shade400, 
      page: (menu) => TotalAngkaPage(menu: menu)
    ),

    MenuModel(
      title: 'Stopwatch', 
      subtitle: 'Manajemen Waktu', 
      icon: Icons.timer, 
      color: Colors.red.shade400, 
      page: (menu) => StopwatchPage(menu: menu)
    ),

    MenuModel(
      title: 'Pyramid', 
      subtitle: 'Luas & Volume', 
      icon: Icons.category, 
      color: Colors.deepPurple.shade400, 
      page: (menu) => PyramidPage(menu: menu)
    ),

    MenuModel(
      title: 'Weton', 
      subtitle: 'Cari Weton', 
      icon: Icons.auto_stories, 
      color: Colors.lightBlue.shade400, 
      page: (menu) => CariWetonPage(menu: menu)
    ),

    MenuModel(
      title: 'Kalkulator Umur',
      subtitle: 'Detail Tahun - Menit',
      icon: Icons.hourglass_top,
      color: const Color.fromARGB(255, 223, 147, 119),
      page: (menu) => TanggalLahirPage(menu: menu), 
    ),
    
    MenuModel(
      title: 'Hijriyah', 
      subtitle: 'Konversi Masehi ke Hijriyah', 
      icon: Icons.date_range, 
      color: Colors.cyan.shade400, 
      page: (menu) => HijriyahPage(menu: menu),
    ),
  ];
}