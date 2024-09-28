import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/car_provider.dart';
import '../services/search_provider.dart';
import 'car_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the search controller when the widget is destroyed
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context, listen: false); // Access SearchProvider

    // Get the search results by filtering cars based on the search query
    final searchResults = carProvider.brands
        .expand((brand) => brand.cars)
        .where((car) {
      final carName = car.name.toLowerCase();
      final searchLower = _searchQuery.toLowerCase();
      return carName.contains(searchLower);
    }).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
              child: Container(
                height: 50,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.surface,
                    filled: true,
                    hintText: 'Search ....',
                    prefixIcon: Icon(Icons.search_rounded),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                          _searchController.clear();
                          searchProvider.updateLastSearchedBrand(''); // Clear search brand
                        });
                      },
                    )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });

                    // Update last searched brand if the query is not empty
                    if (_searchQuery.isNotEmpty) {
                      searchProvider.updateLastSearchedBrand(_searchQuery);
                    }
                  },
                ),
              ),
            ),
            if (_searchQuery.isEmpty)
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Search Your dream cars',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.displayLarge?.color,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (_searchQuery.isNotEmpty)
              Expanded(
                child: searchResults.isEmpty
                    ? Center(
                  child: Text(
                    'No data found',
                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                )
                    : ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final car = searchResults[index];
                    return ListTile(
                      leading: Image.network(
                        car.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: _buildHighlightedText(car.name, _searchQuery),
                      subtitle: Text(car.description),
                      trailing: Text('\$${car.dailyRate.toStringAsFixed(2)}/day'),
                      onTap: () {
                        // Save the recommended car
                        searchProvider.saveRecommendedCar(car.id);  // Save the car as recommended

                        // Navigate to the car details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarDetailsPage(car: car),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper function to build highlighted text
  Widget _buildHighlightedText(String text, String query) {
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final spans = <TextSpan>[];
    int start = 0;

    while (start < text.length) {
      final startIndex = lowerText.indexOf(lowerQuery, start);
      if (startIndex == -1) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      if (startIndex > start) {
        spans.add(TextSpan(text: text.substring(start, startIndex)));
      }

      spans.add(TextSpan(
        text: text.substring(startIndex, startIndex + query.length),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ));

      start = startIndex + query.length;
    }

    return Text.rich(TextSpan(children: spans));
  }
}
