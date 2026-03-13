import 'package:flutter/material.dart';

class MenuModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget Function(MenuModel) page;

  MenuModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.page,
  });
}