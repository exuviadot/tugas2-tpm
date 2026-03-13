import 'package:flutter/material.dart';
import 'package:tugas_2/pages/bilangan_page.dart';
import 'package:tugas_2/pages/calc_page.dart';
import 'package:tugas_2/pages/login_page.dart';
import 'package:tugas_2/pages/pyramid_page.dart';
import 'package:tugas_2/pages/stopwatch_page.dart';
import 'package:tugas_2/pages/total_angka_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> menus = [
    {
      'title': 'Aritmatika', 
      'subtitle': 'Penjumlahan & Pengurangan',
      'icon': Icons.calculate, 
      'color': Colors.blue.shade400,
      'page': CalcPage()
    },
    {
      'title': 'Bilangan', 
      'subtitle': 'Ganjil/Genap & Prima',
      'icon': Icons.numbers, 
      'color': Colors.orange.shade400,
      'page': BilanganPage()
    },
    {
      'title': 'Total Field', 
      'subtitle': 'Hitung Total Angka',
      'icon': Icons.summarize, 
      'color': Colors.green.shade400,
      'page': TotalAngkaPage()
    },
    {
      'title': 'Stopwatch', 
      'subtitle': 'Manajemen Waktu',
      'icon': Icons.timer, 
      'color': Colors.red.shade400,
      'page': StopwatchPage()
    },
    {
      'title': 'Pyramid', 
      'subtitle': 'Luas & Volume',
      'icon': Icons.category, 
      'color': Colors.deepPurple.shade400,
      'page': PyramidPage()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Main Menu', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => const LoginPage())
            )
          )
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.9,
        ),

        itemCount: menus.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: menus[index]['color'].withOpacity(0.3), 
              hoverColor: menus[index]['color'].withOpacity(0.1),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menus[index]['page']),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: menus[index]['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      menus[index]['icon'], 
                      size: 40, 
                      color: menus[index]['color'],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    menus[index]['title'], 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    menus[index]['subtitle'], 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
