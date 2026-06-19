import 'package:flutter/material.dart';

import 'models/product.dart';

void main() {
  runApp(const ResponsiveProductCatalogApp());
}

class ResponsiveProductCatalogApp extends StatelessWidget {
  const ResponsiveProductCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Product Catalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        useMaterial3: true,
      ),
      home: const ProductCatalogScreen(),
    );
  }
}

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Product> products = const [
    Product(
      name: 'Laptop',
      price: 999.99,
      category: 'Technology',
      icon: Icons.laptop_mac_rounded,
    ),
    Product(
      name: 'Phone',
      price: 699.99,
      category: 'Technology',
      icon: Icons.smartphone_rounded,
    ),
    Product(
      name: 'Headphones',
      price: 149.99,
      category: 'Accessories',
      icon: Icons.headphones_rounded,
    ),
    Product(
      name: 'Coffee',
      price: 4.99,
      category: 'Food',
      icon: Icons.local_cafe_rounded,
    ),
    Product(
      name: 'Backpack',
      price: 54.99,
      category: 'Accessories',
      icon: Icons.backpack_rounded,
    ),
    Product(
      name: 'Keyboard',
      price: 89.99,
      category: 'Technology',
      icon: Icons.keyboard_rounded,
    ),
  ];

  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) {
      return products;
    }

    return products
        .where(
          (product) =>
              product.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFFE3F2FD),
              child: Icon(product.icon, color: const Color(0xFF1565C0)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF102A43),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF486581),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0B6E4F),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> visibleProducts = filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Product Catalog'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Catalog',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF102A43),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Browse products and search by name with a layout that adapts to mobile and desktop screens.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Color(0xFF486581),
                          ),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            labelText: 'Search products',
                            prefixIcon: const Icon(Icons.search_rounded),
                            suffixIcon: searchQuery.isEmpty
                                ? null
                                : IconButton(
                                    onPressed: () {
                                      searchController.clear();
                                      setState(() {
                                        searchQuery = '';
                                      });
                                    },
                                    icon: const Icon(Icons.close_rounded),
                                  ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value.trim();
                            });
                          },
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Products found: ${visibleProducts.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF486581),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: visibleProducts.isEmpty
                      ? const Center(
                          child: Text(
                            'No products found.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF486581),
                            ),
                          ),
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth < 600) {
                              return ListView.separated(
                                itemCount: visibleProducts.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  return _buildProductCard(
                                    visibleProducts[index],
                                  );
                                },
                              );
                            }

                            final int crossAxisCount =
                                constraints.maxWidth > 900 ? 3 : 2;

                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 1.55,
                                  ),
                              itemCount: visibleProducts.length,
                              itemBuilder: (context, index) {
                                return _buildProductCard(
                                  visibleProducts[index],
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
