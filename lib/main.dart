import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newtask/productDetials.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _performLogin() async {
    final String apiUrl = 'https://dummyjson.com/auth/login';
    final Map<String, String> requestBody = {
      'username': _usernameController.text.trim(),
      'password': _passwordController.text.trim(),
    };

    // ... existing code ...

    // Rest of the code remains unchanged
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("Login Screen",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color:Color(0xFF00008B) ),)),
            SizedBox(height: 40,),
            Container(
              height: 50.0, // Set a fixed height for the text fields
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12.0), // Set padding inside the text field
                  filled: true,
                  fillColor: Colors.grey[300], // Gray background color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color(0xFF00008B)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Username',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 50.0, // Set a fixed height for the text fields
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12.0), // Set padding inside the text field
                  filled: true,
                  fillColor: Colors.grey[300], // Gray background color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Color(0xFF00008B)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity, // Make the button take full width
              height: 50.0, // Set a fixed height for the button
              child: ElevatedButton(
                onPressed: _performLogin,
                child: Text('Sign in'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00008B),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String title;
  final String imageUrl;
  final String descripation;
  final String brand;
  final String category;
  final double price;
  final double rating;


  Product({required this.title, required this.imageUrl,required this.descripation,required this.brand,required this.category,required this.price,required this.rating});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      imageUrl: json['image'],
      descripation: json['descripation'],
      brand:json['brand'],
      category:json['category'],
      price:json['price'],
      rating: json['rating'],
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final apiUrl = 'https://dummyjson.com/products';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        products = jsonResponse.map((item) => Product.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: products[index]),
              ),);
              },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(products[index].imageUrl),
            ),
            title: Text(products[index].title),
            // You can display additional product information here if needed
          );
        },
      ),
    );
  }
}
