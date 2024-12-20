import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            movie['image'] != null
                ? Image.network(movie['image']['original'])
                : Container(height: 300, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie['name'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie['summary'] != null ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '') : 'No summary available',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}