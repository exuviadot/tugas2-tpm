import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class StopwatchPage extends StatefulWidget {
  final MenuModel menu;
  const StopwatchPage({super.key, required this.menu});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
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