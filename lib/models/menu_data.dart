import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';
import 'package:tugas_2/pages/bilangan_page.dart';
import 'package:tugas_2/pages/calc_page.dart';
import 'package:tugas_2/pages/pyramid_page.dart';
import 'package:tugas_2/pages/stopwatch_page.dart';
import 'package:tugas_2/pages/total_angka_page.dart';

class MenuData {
  static List<MenuModel> listPage = [
    MenuModel(
      title: 'Aritmatika', 
      subtitle: 'Penjumlahan & Pengurangan', 
      icon: Icons.calculate, 
      color: Colors.blue.shade400, 
      page: CalcPage()
    ),

    MenuModel(
      title: 'Bilangan', 
      subtitle: 'Ganjil/Genap & Prima', 
      icon: Icons.numbers, 
      color: Colors.orange.shade400, 
      page: BilanganPage()
    ),

    MenuModel(
      title: 'Total Field', 
      subtitle: 'Hitung Total Angka', 
      icon: Icons.summarize, 
      color: Colors.green.shade400, 
      page: TotalAngkaPage()
    ),

    MenuModel(
      title: 'Stopwatch', 
      subtitle: 'Manajemen Waktu', 
      icon: Icons.timer, 
      color: Colors.red.shade400, 
      page: StopwatchPage()
    ),

    MenuModel(
      title: 'Pyramid', 
      subtitle: 'Luas & Volume', 
      icon: Icons.category, 
      color: Colors.deepPurple.shade400, 
      page: PyramidPage()
    ),
  ];
}