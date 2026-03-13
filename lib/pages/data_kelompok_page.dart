import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class DataKelompokPage extends StatelessWidget {
  final MenuModel menu;
  const DataKelompokPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(menu.title, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}