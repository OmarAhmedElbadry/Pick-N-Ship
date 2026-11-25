/// ============================================================
/// demo_data.dart — Mock Data for Demo Mode
/// ============================================================
/// Contains all sample data for demonstrating the app
/// without a Firebase connection. Includes:
///   - Sample user profile
///   - 8 shops across all 6 categories
///   - 20+ products with representative Egyptian pound prices
//
/// Usage: When demo mode is active, providers use this data
///        instead of calling Firestore.
/// ============================================================

import '../models/user_model.dart';
import '../models/shop_model.dart';
import '../models/product_model.dart';

class DemoData {
  // Global flag — when true, all services return mock data
  static bool isDemoMode = true;

  /// ── Demo User ─────────────────────────────────
  static UserModel get demoUser => UserModel(
    uid: 'demo_user_001',
    phone: '+201012345678',
    name: 'Omar Hassan',
    role: 'customer',
    address: '12 Street 9, Maadi, Cairo',
  );

  /// ── Demo Shops (8 shops across 6 categories) ──
  static List<ShopModel> get allShops => [
    ShopModel(
      shopId: 'shop_001',
      shopName: 'Maadi Fresh Market',
      ownerName: 'Karim Mahmoud',
      phone: '+201000000001',
      category: 'grocery',
      description: 'Fresh groceries & daily essentials',
      addressText: '9 Street, Maadi, Cairo',
      rating: 4.5,
      totalOrders: 234,
      isOpen: true,
      commissionRate: 8.0,
      operatingHours: '8:00 AM - 10:00 PM',
    ),
    ShopModel(
      shopId: 'shop_002',
      shopName: 'Nile Fish Market',
      ownerName: 'Abdullah Ali',
      phone: '+201000000002',
      category: 'fish',
      description: 'Fresh river & sea fish daily',
      addressText: 'Zamalek, Cairo',
      rating: 4.3,
      totalOrders: 156,
      isOpen: true,
      commissionRate: 10.0,
      operatingHours: '6:00 AM - 8:00 PM',
    ),
    ShopModel(
      shopId: 'shop_003',
      shopName: 'Al Khair Butchery',
      ownerName: 'Gamal Hassan',
      phone: '+201000000003',
      category: 'meat',
      description: 'Premium halal meat & poultry',
      addressText: 'Nasr City, Cairo',
      rating: 4.7,
      totalOrders: 312,
      isOpen: true,
      commissionRate: 10.0,
      operatingHours: '7:00 AM - 9:00 PM',
    ),
    ShopModel(
      shopId: 'shop_004',
      shopName: 'Fresh Produce Market',
      ownerName: 'Rafik Ahmed',
      phone: '+201000000004',
      category: 'vegetables',
      description: 'Organic & fresh vegetables',
      addressText: 'Heliopolis, Cairo',
      rating: 4.1,
      totalOrders: 189,
      isOpen: true,
      commissionRate: 8.0,
      operatingHours: '6:00 AM - 9:00 PM',
    ),
    ShopModel(
      shopId: 'shop_005',
      shopName: 'Al Shifa Pharmacy',
      ownerName: 'Dr. Nasser',
      phone: '+201000000005',
      category: 'pharmacy',
      description: 'Medicines, health & personal care',
      addressText: 'Dokki, Giza',
      rating: 4.6,
      totalOrders: 445,
      isOpen: true,
      commissionRate: 5.0,
      operatingHours: '8:00 AM - 11:00 PM',
    ),
    ShopModel(
      shopId: 'shop_006',
      shopName: 'Pickup Express',
      ownerName: 'Soheil Mostafa',
      phone: '+201000000006',
      category: 'parcel_pickup',
      description: 'Fast & reliable parcel delivery',
      addressText: 'Downtown Cairo',
      rating: 4.2,
      totalOrders: 678,
      isOpen: true,
      commissionRate: 0.0,
      operatingHours: '9:00 AM - 8:00 PM',
    ),
    ShopModel(
      shopId: 'shop_007',
      shopName: 'Home Essentials',
      ownerName: 'Habib Abdelrahman',
      phone: '+201000000007',
      category: 'grocery',
      description: 'Your everyday grocery store',
      addressText: 'Mohandessin, Giza',
      rating: 4.0,
      totalOrders: 98,
      isOpen: true,
      commissionRate: 8.0,
      operatingHours: '7:00 AM - 10:00 PM',
    ),
    ShopModel(
      shopId: 'shop_008',
      shopName: 'Amin Produce Shop',
      ownerName: 'Amin Khaled',
      phone: '+201000000008',
      category: 'vegetables',
      description: 'Fresh from the farm daily',
      addressText: 'Fifth Settlement, Cairo',
      rating: 3.9,
      totalOrders: 67,
      isOpen: false, // Closed shop for demo
      commissionRate: 8.0,
      operatingHours: '6:00 AM - 8:00 PM',
    ),
  ];

  /// Get shops filtered by category
  static List<ShopModel> getShopsByCategory(String category) {
    if (category == 'all') return allShops;
    return allShops.where((s) => s.category == category).toList();
  }

  /// ── Demo Products (per shop) ──────────────────
  static Map<String, List<ProductModel>> get allProducts => {
    /// ── Maadi Fresh Market Products ──
    'shop_001': [
      ProductModel(
        productId: 'p001',
        shopId: 'shop_001',
        name: 'Miniket Rice (5kg)',
        category: 'Rice & Grains',
        price: 230,
        unit: 'bag',
        stockQuantity: 25,
      ),
      ProductModel(
        productId: 'p002',
        shopId: 'shop_001',
        name: 'Soybean Oil (5L)',
        category: 'Oil & Ghee',
        price: 490,
        unit: 'bottle',
        stockQuantity: 15,
      ),
      ProductModel(
        productId: 'p003',
        shopId: 'shop_001',
        name: 'Banana (12pc)',
        category: 'Fruits',
        price: 35,
        unit: 'dozen',
        stockQuantity: 40,
      ),
      ProductModel(
        productId: 'p004',
        shopId: 'shop_001',
        name: 'Aarong Milk (1L)',
        category: 'Dairy',
        price: 50,
        unit: 'pack',
        stockQuantity: 30,
      ),
      ProductModel(
        productId: 'p005',
        shopId: 'shop_001',
        name: 'Pran Mango Juice (1L)',
        category: 'Beverages',
        price: 65,
        unit: 'pack',
        stockQuantity: 20,
      ),
      ProductModel(
        productId: 'p006',
        shopId: 'shop_001',
        name: 'Red Lentil / Masoor Dal (1kg)',
        category: 'Rice & Grains',
        price: 80,
        unit: 'kg',
        stockQuantity: 35,
      ),
      ProductModel(
        productId: 'p007',
        shopId: 'shop_001',
        name: 'Sugar (1kg)',
        category: 'Rice & Grains',
        price: 70,
        unit: 'kg',
        stockQuantity: 50,
      ),
      ProductModel(
        productId: 'p008',
        shopId: 'shop_001',
        name: 'Egg (12pc)',
        category: 'Dairy',
        price: 100,
        discountPrice: 85,
        unit: 'dozen',
        stockQuantity: 20,
      ),
      ProductModel(
        productId: 'p009',
        shopId: 'shop_001',
        name: 'Radhuni Mixed Spice',
        category: 'Spices',
        price: 30,
        unit: 'pack',
        stockQuantity: 30,
      ),
      ProductModel(
        productId: 'p010',
        shopId: 'shop_001',
        name: 'Maggi Noodles (8 pack)',
        category: 'Snacks',
        price: 90,
        discountPrice: 75,
        unit: 'pack',
        stockQuantity: 25,
      ),
    ],

    /// ── Nile Fish Market Products ──
    'shop_002': [
      ProductModel(
        productId: 'p011',
        shopId: 'shop_002',
        name: 'Hilsa / Ilish (1kg)',
        category: 'River Fish',
        price: 660,
        unit: 'kg',
        stockQuantity: 10,
      ),
      ProductModel(
        productId: 'p012',
        shopId: 'shop_002',
        name: 'Rui Fish (1kg)',
        category: 'River Fish',
        price: 195,
        unit: 'kg',
        stockQuantity: 15,
      ),
      ProductModel(
        productId: 'p013',
        shopId: 'shop_002',
        name: 'Katla Fish (1kg)',
        category: 'River Fish',
        price: 210,
        unit: 'kg',
        stockQuantity: 12,
      ),
      ProductModel(
        productId: 'p014',
        shopId: 'shop_002',
        name: 'Shrimp / Chingri (500g)',
        category: 'Sea Fish',
        price: 300,
        unit: 'pack',
        stockQuantity: 8,
      ),
      ProductModel(
        productId: 'p015',
        shopId: 'shop_002',
        name: 'Pangas Fish (1kg)',
        category: 'River Fish',
        price: 120,
        unit: 'kg',
        stockQuantity: 20,
      ),
    ],

    /// ── Al Khair Butchery Products ──
    'shop_003': [
      ProductModel(
        productId: 'p016',
        shopId: 'shop_003',
        name: 'Beef (1kg)',
        category: 'Beef',
        price: 385,
        unit: 'kg',
        stockQuantity: 15,
      ),
      ProductModel(
        productId: 'p017',
        shopId: 'shop_003',
        name: 'Chicken Breast (1kg)',
        category: 'Chicken',
        price: 175,
        unit: 'kg',
        stockQuantity: 20,
      ),
      ProductModel(
        productId: 'p018',
        shopId: 'shop_003',
        name: 'Whole Chicken (1.2kg)',
        category: 'Chicken',
        price: 210,
        discountPrice: 185,
        unit: 'piece',
        stockQuantity: 10,
      ),
      ProductModel(
        productId: 'p019',
        shopId: 'shop_003',
        name: 'Mutton / Khashi (1kg)',
        category: 'Mutton',
        price: 605,
        unit: 'kg',
        stockQuantity: 8,
      ),
      ProductModel(
        productId: 'p020',
        shopId: 'shop_003',
        name: 'Chicken Wings (500g)',
        category: 'Chicken',
        price: 95,
        unit: 'pack',
        stockQuantity: 18,
      ),
    ],

    /// ── Fresh Produce Market ──
    'shop_004': [
      ProductModel(
        productId: 'p021',
        shopId: 'shop_004',
        name: 'Potato / Alu (1kg)',
        category: 'Root',
        price: 20,
        unit: 'kg',
        stockQuantity: 50,
      ),
      ProductModel(
        productId: 'p022',
        shopId: 'shop_004',
        name: 'Onion / Peyaj (1kg)',
        category: 'Root',
        price: 35,
        unit: 'kg',
        stockQuantity: 40,
      ),
      ProductModel(
        productId: 'p023',
        shopId: 'shop_004',
        name: 'Tomato (1kg)',
        category: 'Vegetable',
        price: 45,
        unit: 'kg',
        stockQuantity: 30,
      ),
      ProductModel(
        productId: 'p024',
        shopId: 'shop_004',
        name: 'Green Chili (250g)',
        category: 'Spice Veg',
        price: 15,
        unit: 'pack',
        stockQuantity: 35,
      ),
      ProductModel(
        productId: 'p025',
        shopId: 'shop_004',
        name: 'Cauliflower (1pc)',
        category: 'Vegetable',
        price: 25,
        unit: 'piece',
        stockQuantity: 20,
      ),
      ProductModel(
        productId: 'p026',
        shopId: 'shop_004',
        name: 'Spinach / Palong Shak',
        category: 'Leafy',
        price: 10,
        unit: 'bundle',
        stockQuantity: 25,
      ),
    ],

    /// ── Al Shifa Pharmacy ──
    'shop_005': [
      ProductModel(
        productId: 'p027',
        shopId: 'shop_005',
        name: 'Napa Extra (10 tabs)',
        category: 'Pain Relief',
        price: 25,
        unit: 'strip',
        stockQuantity: 100,
      ),
      ProductModel(
        productId: 'p028',
        shopId: 'shop_005',
        name: 'Antacid Suspension (200ml)',
        category: 'Digestive',
        price: 65,
        unit: 'bottle',
        stockQuantity: 30,
      ),
      ProductModel(
        productId: 'p029',
        shopId: 'shop_005',
        name: 'Vitamin C (30 tabs)',
        category: 'Vitamins',
        price: 100,
        unit: 'bottle',
        stockQuantity: 25,
      ),
      ProductModel(
        productId: 'p030',
        shopId: 'shop_005',
        name: 'Band-Aid (10pc)',
        category: 'First Aid',
        price: 35,
        unit: 'box',
        stockQuantity: 40,
      ),
      ProductModel(
        productId: 'p031',
        shopId: 'shop_005',
        name: 'Hand Sanitizer (200ml)',
        category: 'Hygiene',
        price: 50,
        unit: 'bottle',
        stockQuantity: 35,
      ),
    ],

    /// ── Home Essentials (Grocery #2) ──
    'shop_007': [
      ProductModel(
        productId: 'p032',
        shopId: 'shop_007',
        name: 'Bread (Large)',
        category: 'Bakery',
        price: 40,
        unit: 'piece',
        stockQuantity: 15,
      ),
      ProductModel(
        productId: 'p033',
        shopId: 'shop_007',
        name: 'Butter (200g)',
        category: 'Dairy',
        price: 120,
        unit: 'pack',
        stockQuantity: 10,
      ),
      ProductModel(
        productId: 'p034',
        shopId: 'shop_007',
        name: 'Tea Bags (50pc)',
        category: 'Beverages',
        price: 140,
        unit: 'box',
        stockQuantity: 20,
      ),
      ProductModel(
        productId: 'p035',
        shopId: 'shop_007',
        name: 'Biscuits Assorted',
        category: 'Snacks',
        price: 45,
        discountPrice: 40,
        unit: 'pack',
        stockQuantity: 30,
      ),
    ],
  };

  /// Get products for a specific shop
  static List<ProductModel> getProductsForShop(String shopId) {
    return allProducts[shopId] ?? [];
  }

  /// Get unique product categories for a shop
  static List<String> getProductCategories(String shopId) {
    final products = getProductsForShop(shopId);
    final cats = products
        .map((p) => p.category)
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList();
    cats.sort();
    return ['All', ...cats];
  }

  /// Search shops by name
  static List<ShopModel> searchShops(String query) {
    final lower = query.toLowerCase();
    return allShops
        .where(
          (s) =>
              s.shopName.toLowerCase().contains(lower) ||
              s.category.toLowerCase().contains(lower) ||
              s.description.toLowerCase().contains(lower),
        )
        .toList();
  }
}
