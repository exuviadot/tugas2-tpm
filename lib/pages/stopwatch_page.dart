import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas_2/models/menu_model.dart';

class StopwatchPage extends StatefulWidget {
  final MenuModel menu;
  const StopwatchPage({super.key, required this.menu});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final List<String> _laps = []; // List untuk menyimpan data Lap

  String _formatTime() {
    final duration = _stopwatch.elapsed;
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String milliseconds = ((duration.inMilliseconds % 1000) / 10).toInt().toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds.$milliseconds";
  }

  void _handleStartStop() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _timer?.cancel();
      } else {
        _stopwatch.start();
        // Gunakan 30ms agar update milidetik terlihat mulus
        _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
          setState(() {});
        });
      }
    });
  }

  void _handleReset() {
    setState(() {
      _stopwatch.reset();
      _laps.clear(); // Bersihkan lap saat reset
      if (!_stopwatch.isRunning) _timer?.cancel();
    });
  }

  void _handleLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.insert(0, _formatTime()); // Tambah lap ke urutan paling atas
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.menu.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          // --- BAGIAN LINGKARAN (PERBAIKAN) ---
          Center(
            child: Container(
              width: 280, // Ukuran tetap agar tidak meluber
              height: 280,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade50,
                border: Border.all(color: Colors.deepPurple.shade100, width: 4),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20)
                ],
              ),
              child: Text(
                _formatTime(),
                style: const TextStyle(
                  fontSize: 42, // Sedikit diperkecil agar pas
                  fontWeight: FontWeight.w300,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // --- TOMBOL KONTROL ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _controlButton(
                onPressed: _stopwatch.isRunning ? _handleLap : _handleReset,
                icon: _stopwatch.isRunning ? Icons.flag_rounded : Icons.refresh_rounded,
                label: _stopwatch.isRunning ? "Lap" : "Reset",
                color: Colors.grey.shade200,
                textColor: Colors.black87,
              ),
              _controlButton(
                onPressed: _handleStartStop,
                icon: _stopwatch.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                label: _stopwatch.isRunning ? "Stop" : "Start",
                color: _stopwatch.isRunning ? Colors.red.shade100 : Colors.deepPurple.shade100,
                textColor: _stopwatch.isRunning ? Colors.red.shade900 : Colors.deepPurple.shade900,
              ),
            ],
          ),

          const SizedBox(height: 30),
          const Divider(),

          // --- LIST LAP ---
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("Lap ${_laps.length - index}", style: TextStyle(color: Colors.grey.shade600)),
                  title: Text(_laps[index], style: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'monospace')),
                  trailing: const Icon(Icons.timer_outlined, size: 18),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return SizedBox(
      width: 120,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}