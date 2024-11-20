import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Text(
                      'Review and Rating',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    SizedBox(width: 48), // Space equivalent to IconButton width
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '4.5',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRatingRow(context, '5', 0.9, Colors.blueAccent),
                          _buildRatingRow(context, '4', 0.7, Colors.green),
                          _buildRatingRow(context, '3', 0.5, Colors.yellow),
                          _buildRatingRow(context, '2', 0.3, Colors.orange),
                          _buildRatingRow(context, '1', 0.1, Colors.red),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: _createProfile(context),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingRow(BuildContext context, String rating, double value, Color color) {
    return Row(
      children: [
        Text(rating, style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.displayMedium?.color)),
        SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: value,
            minHeight: 7,
            backgroundColor: Theme.of(context).colorScheme.surface,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }

  Widget _createProfile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 12),
                Text(
                  'Username',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayMedium!.color,
                  ),
                ),
              ],
            ),
            Icon(Icons.more_horiz_outlined),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star_border, color: Colors.grey),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 150,
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: Text(
              'Review text belongs here',
              style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium?.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
