import 'package:flutter/material.dart';

import 'main.dart';


class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(product.imageUrl),
            SizedBox(height: 20),
            Text(
              'Title: ${product.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Display other product details here if available
          ],
        ),
      ),
    );
  }
}
