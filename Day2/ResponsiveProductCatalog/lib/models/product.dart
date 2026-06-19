import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.name,
    required this.price,
    required this.category,
    required this.icon,
  });

  final String name;
  final double price;
  final String category;
  final IconData icon;
}
