import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class DataKelompokPage extends StatelessWidget {
  final MenuModel menu;
  const DataKelompokPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> anggota = [
      {"nama": "Amrullah Alam Almaududi", "nim": "123230163"},
      {"nama": "Dwiki Aditya Rabbani", "nim": "123230167"},
      {"nama": "Atiqa Desyta Zahrani", "nim": "123230185"}
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          menu.title, 
          style: const TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: anggota.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: const Icon(Icons.person, color: Colors.deepPurple),
              ),
              title: Text(
                anggota[index]['nama']!, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                )
              ),
              subtitle: Text(anggota[index]['nim']!),
            ),
          );
        },
      ),
    );
  }
}