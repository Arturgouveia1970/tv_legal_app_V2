import 'package:flutter/material.dart';
import 'player_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> canais = [
    {
      'title': 'Al Jazeera',
      'url': 'https://live-hls-web-aje.getaj.net/AJE/index.m3u8',
      'icon': 'assets/images/aljazeera.png',
      'category': 'News'
    },
    {
      'title': 'DW News',
      'url': 'https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8',
      'icon': 'assets/images/dw.png',
      'category': 'News'
    },
    {
      'title': 'Red Bull TV',
      'url': 'https://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master.m3u8',
      'icon': 'assets/images/redbull.png',
      'category': 'Sports'
    },
  ];

  TextEditingController _searchController = TextEditingController();
  
  // Initialize _filteredChannels as an empty list or as a copy of 'canais'.
  List<Map<String, dynamic>> _filteredChannels = [];  // Fixed initialization

  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    // Initialize _filteredChannels to be the same as 'canais' initially
    _filteredChannels = List.from(canais);  // Ensuring proper initialization
    _searchController.addListener(() {
      _filterChannels();
    });
  }

  void _filterChannels() {
    setState(() {
      _filteredChannels = canais.where((canal) {
        return canal['title']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  void _toggleFavorite(Map<String, dynamic> canal) {
    setState(() {
      if (_favorites.contains(canal)) {
        _favorites.remove(canal);
      } else {
        _favorites.add(canal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categorias = _filteredChannels.map((c) => c['category']).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('TV Legal'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),  // Set text color to white
              decoration: InputDecoration(
                labelText: 'Search Channels',
                labelStyle: TextStyle(color: Colors.white),  // Set label text color
                prefixIcon: Icon(Icons.search, color: Colors.white),  // Search icon color
                filled: true,  // Background fill for the search bar
                fillColor: Colors.deepPurple,  // Match the AppBar color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,  // Remove the border side
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: categorias.map((categoria) {
          final filtrados = _filteredChannels.where((c) => c['category'] == categoria).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  categoria,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple, // Accent color
                  ),
                ),
              ),
              ...filtrados.map((canal) {
                return Card(
                  color: Colors.white, // White cards for light theme
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        canal['icon'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(Icons.tv, color: Colors.grey),
                      ),
                    ),
                    title: Text(
                      canal['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        _favorites.contains(canal)
                            ? Icons.star
                            : Icons.star_border,
                        color: _favorites.contains(canal)
                            ? Colors.yellow
                            : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(canal),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerPage(
                          canalNome: canal['title'],
                          canalUrl: canal['url'],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
