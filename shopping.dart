// main.dart
void main(){
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SignInScreen(),
        '/itemList': (context) => ItemListScreen(),
      },
    );
  }
}

class SignInScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Replace these placeholder values with your actual email and password
            String email = 'your_email@example.com';
            String password = 'your_password';

            String result = await _auth.signInWithEmailAndPassword(email, password);

            if (result == null) {
              Navigator.pushReplacementNamed(context, '/itemList');
            } else {
              print(result);
            }
          },
          child: Text('Sign In'),
        ),
      ),
    );
  }
}

class ItemListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'productName': 'iPhone 15 Pro',
      'price': 1299.99,
      'productId': 'iphone15pro',
    },
    {
      'productName': 'LG Refrigerator',
      'price': 999.99,
      'productId': 'lgrefrigerator',
    },
    {
      'productName': 'Voltas AC',
      'price': 799.99,
      'productId': 'voltasac',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]['productName']),
            subtitle: Text('Price: \$${items[index]['price']}'),
            onTap: () {
              _preorderItem(
                context,
                items[index]['productId'],
                items[index]['productName'],
                items[index]['price'],
              );
            },
          );
        },
      ),
    );
  }

  void _preorderItem(
    BuildContext context,
    String productId,
    String productName,
    double price,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Preorder Confirmation'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Product ID: $productId'),
              Text('Product: $productName'),
              Text('Price: \$${price.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }
}

class AuthService {
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    // Placeholder implementation for authentication
    return null;
  }
}
}