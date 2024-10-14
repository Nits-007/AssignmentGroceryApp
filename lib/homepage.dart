import 'package:flutter/material.dart';
import 'package:grocery/productdetailpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Apple',
      'price': 150.0,
      'image': 'assets/images/apple.jpg',
      'description': 'Fresh and juicy apples imported from the best farms.',
    },
    {
      'name': 'Banana',
      'price': 60.0,
      'image': 'assets/images/banana.jpg',
      'description': 'Fresh and sweet Bananas imported from the best farms.',
    },
    {
      'name': 'Biscuit',
      'price': 30.0,
      'image': 'assets/images/biscuit.jpg',
      'description': 'Freshly baked sweet and salty biscuits.',
    },
    {
      'name': 'Brown Bread',
      'price': 40.0,
      'image': 'assets/images/bread.jpg',
      'description': 'Fresh brown breads imported from the best farms.',
    },
    {
      'name': 'Chocolate',
      'price': 120.0,
      'image': 'assets/images/choc.jpg',
      'description': 'Dairy Milk Silk Chocolates.',
    },
    {
      'name': 'Namkeen',
      'price': 100.0,
      'image': 'assets/images/namkeen.jpg',
      'description': 'Fresh Haldiram Mixture Namkeen.',
    },
    {
      'name': 'Peanut Butter',
      'price': 200.0,
      'image': 'assets/images/peanut.jpg',
      'description': 'Pure and creamy Amul Peanut Butter.',
    },
    {
      'name': 'Soft Drinks',
      'price': 60.0,
      'image': 'assets/images/softdrinks.jpg',
      'description': 'ThumbsUp, Coca Cola, Fanta, Sprite - 1L.',
    },
  ];

  final Map<String, int> cartItems = {};
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((product) =>
            product['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cart Items'),
                  content: cartItems.isEmpty
                      ? Text('No items in the cart.')
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: cartItems.entries
                              .map((entry) =>
                                  Text('${entry.key} x${entry.value}'))
                              .toList(),
                        ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search by product name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (screenWidth < 600) ? 2 : 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: filteredProducts[index],
                            onAddToCart: (int quantity) {
                              setState(() {
                                cartItems.update(
                                  filteredProducts[index]['name'],
                                  (value) => value + quantity,
                                  ifAbsent: () => quantity,
                                );
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: ProductGridItem(
                      name: filteredProducts[index]['name'],
                      price: filteredProducts[index]['price'],
                      image: filteredProducts[index]['image'],
                      isInCart: cartItems
                          .containsKey(filteredProducts[index]['name']),
                      onAddToCart: () {
                        setState(() {
                          cartItems.update(
                            filteredProducts[index]['name'],
                            (value) => value + 1,
                            ifAbsent: () => 1,
                          );
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${filteredProducts[index]['name']} added to cart'),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductGridItem extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final bool isInCart;
  final VoidCallback onAddToCart;

  ProductGridItem({
    required this.name,
    required this.price,
    required this.image,
    required this.isInCart,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '\₹$price',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: isInCart ? null : onAddToCart,
                  child: Text(isInCart ? 'Added' : 'Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 36),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
