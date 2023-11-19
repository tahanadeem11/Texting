import 'package:daim_project/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform login logic
                // For simplicity, we'll just navigate back to the authentication screen
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));               },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}