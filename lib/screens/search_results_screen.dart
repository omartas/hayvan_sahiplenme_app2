import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  final List<dynamic> searchResults;

  SearchResultScreen({required this.searchResults});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arama Sonuçları'),
      ),
      body: widget.searchResults.isEmpty
          ? Center(child: Text('Sonuç bulunamadı'))
          : ListView.builder(
              itemCount: widget.searchResults.length,
              itemBuilder: (context, index) {
                var pet = widget.searchResults[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.pets), // Hayvan simgesi
                    title: Text(pet['name']),
                    subtitle: Text(
                        'Tür: ${pet['genus']['name']} \nBarınak: ${pet['shelter']['name']}'),
                    trailing: pet['adoption']
                        ? Icon(Icons.check, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                    onTap: () {
                      // Hayvanın detaylarına gitmek için kullanabilirsiniz
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetDetailScreen(pet: pet),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class PetDetailScreen extends StatelessWidget {
  final dynamic pet;

  PetDetailScreen({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cins: ${pet['genus']['name']}'),
            Text('Barınak: ${pet['shelter']['name']}'),
            Text('Adopted: ${pet['adopted'] ? 'Evet' : 'Hayır'}'),
            Text('Kısır: ${pet['kisirlik'] ? 'Evet' : 'Hayır'}'),
            Text('Yaş: ${pet['age']}'),
          ],
        ),
      ),
    );
  }
}
