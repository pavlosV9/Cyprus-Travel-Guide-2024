import 'package:flutter/material.dart';
import 'package:tourismappofficial/const/Text_Styles.dart';

class HistoryofCyprus extends StatelessWidget {
  const HistoryofCyprus({super.key});

  @override
  Widget build(BuildContext context) {
    const double spacing = 10.0;  // Standardize spacing

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: spacing * 3), // Adjusted for visual appeal at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'History of Cyprus',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Opacity(
                  opacity: 0.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing),
            Container(
              height: 200,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('plaza/cyprus.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing),
              child: Text(
                'The history of Cyprus is one of the oldest recorded in the world and its strategic location at the crossroads of three continents, Europe, Asia, and Africa, has made it a jewel coveted by several great civilizations throughout history. The first known human activity on the island dates back to around the 10th millennium BC, with settlements from the Neolithic period showing evidence of organized communities.\n\n'
                    'By the Bronze Age, Cyprus had become a major Mediterranean player, known for its copper resources which gave the island its name. Influences from Mycenaean Greeks during this period are profound and led to the establishment of robust trade networks. Classical and Hellenistic periods saw the island flourishing under various rulers, including Persians and Egyptians, until it became a significant part of the Roman Empire, renowned for its arts and architecture.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: spacing),
            Container(
              height: 200,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('plaza/moufflon.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing),
              child: Text(
                'The division of the Roman Empire brought Cyprus under Byzantine rule, marking a period dominated by Christianity, which shaped much of its cultural and architectural heritage. The subsequent centuries saw Arab raids and a short period of Arab control before the Byzantine reconquest. The medieval period was highlighted by the rule of the Lusignan kings who left a lasting mark with their Gothic architecture. Later, the island came under Venetian, Ottoman, and British rule, each adding layers to its rich historical tapestry. Cyprus gained independence in 1960, but inter-communal tensions led to a division of the island in 1974, a situation that remains unresolved. \n\n'
                    'Today, Cyprus is a popular tourist destination, celebrated not only for its enchanting landscapes and beaches but also for its extensive archaeological sites that offer insights into its storied past. The island continues to be a meeting place of different cultures, embodying a rich cultural heritage that stands as a testament to its complex history.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Add more widgets as needed with consistent spacing
          ],
        ),
      ),
    );
  }
}
