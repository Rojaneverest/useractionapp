import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Trigger Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EventTriggerScreen(),
    );
  }
}

class EventTriggerScreen extends StatelessWidget {
  const EventTriggerScreen({Key? key});

  Future<void> _triggerEvent(
      String actionType, int userId, int productId) async {
    final Map<String, dynamic> eventData = {
      'action_type': actionType,
      'action_datetime': DateTime.now().toString(),
      'user_id': userId,
      'product_id': productId,
    };

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/user_actions_app/record_user_action/"),
        body: json.encode(eventData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('User action sent successfully!');
      } else {
        throw Exception('Failed to send user action');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Trigger Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _triggerEvent('view_product', 1,
                    23); // Replace with actual user ID and product ID
              },
              child: Text('View Product'),
            ),
            ElevatedButton(
              onPressed: () {
                _triggerEvent('add_to_cart', 1,
                    23); // Replace with actual user ID and product ID
              },
              child: Text('Add to Cart'),
            ),
            // Add more buttons for other actions as needed
          ],
        ),
      ),
    );
  }
}
