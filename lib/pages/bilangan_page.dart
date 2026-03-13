import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class BilanganPage extends StatefulWidget {
  final MenuModel menu;
  const BilanganPage({super.key, required this.menu});

  @override
  State<BilanganPage> createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
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