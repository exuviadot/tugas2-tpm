import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';
import 'package:tugas_2/pages/bilangan_page.dart';
import 'package:tugas_2/pages/calc_page.dart';
import 'package:tugas_2/pages/data_kelompok_page.dart';
import 'package:tugas_2/pages/pyramid_page.dart';
import 'package:tugas_2/pages/stopwatch_page.dart';
import 'package:tugas_2/pages/total_angka_page.dart';

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
  ];
}