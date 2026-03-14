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

  String _formatTime() {
    final duration = _stopwatch.elapsed;
    
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  void _handleStartStop() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _timer?.cancel();
      } else {
        _stopwatch.start();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {});
        });
      }
    });
  }

  void _handleReset() {
    setState(() {
      _stopwatch.reset();
      if (!_stopwatch.isRunning) {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade50,
                border: Border.all(color: Colors.deepPurple.shade100, width: 2),
              ),
              child: Text(
                _formatTime(),
                style: const TextStyle(
                  fontSize: 54,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'monospace',
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _controlButton(
                  onPressed: _handleReset,
                  icon: Icons.refresh_rounded,
                  label: "Reset",
                  color: Colors.orange.shade100,
                  textColor: Colors.orange.shade900,
                ),
                const SizedBox(width: 20),
                _controlButton(
                  onPressed: _handleStartStop,
                  icon: _stopwatch.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  label: _stopwatch.isRunning ? "Stop" : "Start",
                  color: _stopwatch.isRunning ? Colors.red.shade100 : Colors.green.shade100,
                  textColor: _stopwatch.isRunning ? Colors.red.shade900 : Colors.green.shade900,
                ),
              ],
            ),
          ],
        ),
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