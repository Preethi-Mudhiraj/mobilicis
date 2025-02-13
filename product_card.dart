import 'package:flutter/material.dart';
import 'package:oruphones/common/app_images.dart';


class Product {
  final String image;
  final String title;
  final String price;

  Product({required this.image, required this.title, required this.price});
}

class ProductGrid extends StatelessWidget {
  List<Product> products = [
    Product(image: AppImages.phone, title: 'Apple iPhone 13 Pro', price: '₹41,500'),
    Product(image: AppImages.phone, title: 'Apple iPhone 14 Pro', price: '₹52,000'),
    Product(image: AppImages.phone, title: 'Apple iPhone 15 Pro', price: '₹65,000'),
    Product(image: AppImages.sell, title: ' ', price: ''),
    Product(image: AppImages.phone, title: 'Apple iPhone 14 Pro', price: '₹52,000'),
    Product(image: AppImages.phone, title: 'Apple iPhone 15 Pro', price: '₹65,000'),
    Product(image: AppImages.phone, title: 'Apple iPhone 13 Pro', price: '₹41,500'),
    Product(image: AppImages.compare, title: ' ', price: ' '),
    Product(image: AppImages.phone, title: 'Apple iPhone 15 Pro', price: '₹65,000'),
    Product(image: AppImages.phone, title: 'Apple iPhone 13 Pro', price: '₹41,500'),
    Product(image: AppImages.phone, title: 'Apple iPhone 14 Pro', price: '₹52,000'),
    Product(image: AppImages.phone, title: 'Apple iPhone 15 Pro', price: '₹65,000'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            image: products[index].image,
            title: products[index].title,
            price: products[index].price,
          );
        },
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String image;
  final String title;
  final String price;

  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(widget.image, fit: BoxFit.cover, height: 155, width: double.infinity),
              ),
              Positioned(
                top: 1,
                right: 1,
                child: IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? Colors.red : Colors.grey),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.price, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
