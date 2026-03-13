import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class TotalAngkaPage extends StatefulWidget {
  final MenuModel menu;
  const TotalAngkaPage({super.key, required this.menu});

  @override
  State<TotalAngkaPage> createState() => _TotalAngkaPageState();
}

class _TotalAngkaPageState extends State<TotalAngkaPage> {
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