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
    {'title': 'Menu Penjumlahan & Pengurangan', 'page': CalcPage()},
    {'title': 'Menu Ganjil/Genap dan Bilangan Prima', 'page': BilanganPage()},
    {'title': 'Menu Jumlah Total Angka', 'page': TotalAngkaPage()},
    {'title': 'Menu Stopwatch', 'page': StopwatchPage()},
    {'title': 'Menu Hitung Luas & Volume Pyramid', 'page': PyramidPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Main Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => LoginPage())
            )
          )
        ],
      ),

      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

        itemCount: menus.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menus[index]['page']),
              ),
              child: Center(
                child: Text(
                  menus[index]['title'], 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}