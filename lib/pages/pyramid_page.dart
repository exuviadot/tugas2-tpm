import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class PyramidPage extends StatefulWidget {
  final MenuModel menu;
  const PyramidPage({super.key, required this.menu});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(widget.menu.title, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}