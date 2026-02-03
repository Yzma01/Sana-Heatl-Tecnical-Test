import 'package:flutter/material.dart';

IconData getCategoryIcon(String categoryName) {
  final name = categoryName.toLowerCase();

  // Beauty & Personal Care
  if (name.contains('beauty')) return Icons.face_retouching_natural;
  if (name.contains('fragrance')) return Icons.local_florist;
  if (name.contains('skin-care') || name.contains('skincare')) {
    return Icons.spa;
  }

  // Home & Living
  if (name.contains('furniture')) return Icons.weekend;
  if (name.contains('home-decoration') || name.contains('decoration')) {
    return Icons.home;
  }
  if (name.contains('kitchen-accessories') || name.contains('kitchen')) {
    return Icons.kitchen;
  }

  // Food & Groceries
  if (name.contains('groceries') || name.contains('food')) {
    return Icons.shopping_basket;
  }

  // Electronics
  if (name.contains('laptop')) return Icons.laptop_mac;
  if (name.contains('smartphone')) return Icons.smartphone;
  if (name.contains('tablet')) return Icons.tablet_mac;
  if (name.contains('mobile-accessories') ||
      name.contains('mobile accessories')) {
    return Icons.headphones;
  }
  if (name.contains('electronics')) return Icons.devices;

  // Men's Fashion
  if (name.contains('mens-shirts') || name.contains('men\'s shirts')) {
    return Icons.checkroom;
  }
  if (name.contains('mens-shoes') || name.contains('men\'s shoes')) {
    return Icons.shopping_bag;
  }
  if (name.contains('mens-watches') || name.contains('men\'s watches')) {
    return Icons.watch;
  }

  // Women's Fashion
  if (name.contains('womens-dresses') || name.contains('women\'s dresses')) {
    return Icons.checkroom_outlined;
  }
  if (name.contains('womens-shoes') || name.contains('women\'s shoes')) {
    return Icons.shopping_bag_outlined;
  }
  if (name.contains('womens-watches') || name.contains('women\'s watches')) {
    return Icons.watch_outlined;
  }
  if (name.contains('womens-bags') || name.contains('women\'s bags')) {
    return Icons.work_outline;
  }
  if (name.contains('womens-jewellery') ||
      name.contains('women\'s jewellery') ||
      name.contains('jewelry')) {
    return Icons.diamond;
  }
  if (name.contains('tops')) return Icons.dry_cleaning;

  // Accessories
  if (name.contains('sunglasses')) return Icons.wb_sunny;

  // Sports & Outdoors
  if (name.contains('sports-accessories') || name.contains('sports')) {
    return Icons.sports_soccer;
  }

  // Vehicles
  if (name.contains('motorcycle')) return Icons.two_wheeler;
  if (name.contains('vehicle')) return Icons.directions_car;

  // Generic fallbacks
  if (name.contains('clothing') || name.contains('fashion')) {
    return Icons.checkroom;
  }
  if (name.contains('books')) return Icons.menu_book;
  if (name.contains('toys')) return Icons.toys;
  if (name.contains('health')) return Icons.health_and_safety;

  return Icons.category;
}
