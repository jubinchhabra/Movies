import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> results = [];
  String searchTerm = '';

  Future<void> searchMovies() async {
    if (searchTerm.isNotEmpty) {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchTerm'));
      if (response.statusCode == 200 ) {
        setState(() {
          results = json.decode(response.body).map((item) => item['show']).toList();
        });
      } else {
        throw Exception('Failed to load search results');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
                searchMovies();
              },
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? Center(child: Text('No results found'))
                : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final movie = results[index];
                return ListTile(
                  leading: movie['image'] != null
                      ? Image.network(movie['image']['medium'])
                      : Container(width: 50, height: 50, color: Colors.grey),
                  title: Text(movie['name']),
                  subtitle: Text(movie['summary'] != null ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '') : ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsScreen(movie: movie)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}