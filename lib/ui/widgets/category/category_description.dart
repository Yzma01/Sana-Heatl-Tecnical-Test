String getCategoryDescription(String categoryName) {
  final name = categoryName.toLowerCase();

  // Beauty & Personal Care
  if (name.contains('beauty')) return 'Cosmetics & beauty products';
  if (name.contains('fragrance')) return 'Perfumes & scented products';
  if (name.contains('skin-care') || name.contains('skincare')) {
    return 'Skincare & treatments';
  }

  // Home & Living
  if (name.contains('furniture')) return 'Home & office furniture';
  if (name.contains('home-decoration') || name.contains('decoration')) {
    return 'Decorative items & accents';
  }
  if (name.contains('kitchen-accessories') || name.contains('kitchen')) {
    return 'Kitchen tools & gadgets';
  }

  // Food & Groceries
  if (name.contains('groceries') || name.contains('food')) {
    return 'Fresh food & essentials';
  }

  // Electronics
  if (name.contains('laptop')) return 'Notebooks & ultrabooks';
  if (name.contains('smartphone')) return 'Mobile phones & devices';
  if (name.contains('tablet')) return 'Tablets & e-readers';
  if (name.contains('mobile-accessories') ||
      name.contains('mobile accessories')) {
    return 'Cases, chargers & more';
  }
  if (name.contains('electronics')) return 'Tech & gadgets';

  // Men's Fashion
  if (name.contains('mens-shirts') || name.contains('men\'s shirts')) {
    return 'Casual & formal shirts';
  }
  if (name.contains('mens-shoes') || name.contains('men\'s shoes')) {
    return 'Footwear for men';
  }
  if (name.contains('mens-watches') || name.contains('men\'s watches')) {
    return 'Timepieces & smartwatches';
  }

  // Women's Fashion
  if (name.contains('womens-dresses') || name.contains('women\'s dresses')) {
    return 'Elegant dresses & gowns';
  }
  if (name.contains('womens-shoes') || name.contains('women\'s shoes')) {
    return 'Footwear for women';
  }
  if (name.contains('womens-watches') || name.contains('women\'s watches')) {
    return 'Elegant timepieces';
  }
  if (name.contains('womens-bags') || name.contains('women\'s bags')) {
    return 'Handbags & clutches';
  }
  if (name.contains('womens-jewellery') ||
      name.contains('women\'s jewellery') ||
      name.contains('jewelry')) {
    return 'Rings, necklaces & more';
  }
  if (name.contains('tops')) return 'T-shirts, blouses & tops';

  // Accessories
  if (name.contains('sunglasses')) return 'Stylish eyewear';

  // Sports & Outdoors
  if (name.contains('sports-accessories') || name.contains('sports')) {
    return 'Fitness & sports gear';
  }

  // Vehicles
  if (name.contains('motorcycle')) return 'Bikes & motorcycle gear';
  if (name.contains('vehicle')) return 'Cars & auto accessories';

  // Generic fallbacks
  if (name.contains('clothing') || name.contains('fashion')) {
    return 'Apparel & accessories';
  }
  if (name.contains('books')) return 'Books & reading materials';
  if (name.contains('toys')) return 'Toys & games';
  if (name.contains('health')) return 'Health & wellness';

  return 'Explore this category';
}
