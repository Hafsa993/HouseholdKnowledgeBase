import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/menu_drawer.dart';

class RankingScreen extends StatelessWidget {

  final List<User> currUsers = [ 
    User(username: 'JohnDoe',points: 100),
    User(username: 'Max',points: 125),
    User(username: 'Alex',points: 75),
    User(username: 'Anna',points: 90),
    User(username: 'Marie',points: 100),
    User(username: 'Sarah',points: 122)
    ];

   RankingScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    
    currUsers.sort((a, b) {
      if (b.points == a.points) {
        return a.username.compareTo(b.username); // Tie-breaker: alphabetical order
      }
      return b.points.compareTo(a.points); // Primary sorting: points descending
    });
        // Assign ranks
    List<Map<String, dynamic>> rankedUsers = [];
    int rank = 0;
    int count = 0; // Number of users processed
    int previousPoints = -1;
    List<int> uniqueRanks = [];

    for (int i = 0; i < currUsers.length; i++) {
      User user = currUsers[i];
      count++;

      if (user.points != previousPoints) {
        rank = count;
        uniqueRanks.add(rank);
      }

      rankedUsers.add({
        'user': user,
        'rank': rank,
      });

      previousPoints = user.points;
    }

    // Map medal colors to the first three unique ranks, so multiple people can be on any rank
    Map<int, Color> rankMedalColors = {};
    for (int i = 0; i < uniqueRanks.length; i++) {
      int uniqueRank = uniqueRanks[i];
      if (i == 0) {
        rankMedalColors[uniqueRank] = const Color.fromARGB(255, 249, 187, 1); // Gold
      } else if (i == 1) {
        rankMedalColors[uniqueRank] = const Color.fromARGB(255, 155, 153, 153); // Silver
      } else if (i == 2) {
        rankMedalColors[uniqueRank] = const Color.fromARGB(255, 192, 118, 8); // Bronze
      } else {
        rankMedalColors[uniqueRank] = Colors.transparent; // No medal
      }
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 239, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 193, 240),
        title: const Text('Rankings'),
      ),
      drawer: const MenuDrawer(),
      body: ListView.builder(
        itemCount: rankedUsers.length,
        itemBuilder: (context, index) {
          User currUser = rankedUsers[index]['user'];
          int rank = rankedUsers[index]['rank'];

          // medal color for the user's rank
          Color medalColor = rankMedalColors[rank]!;

          return Card(
            color: currUser.username == "JohnDoe"? Color.fromARGB(255, 212, 212, 213): Color.fromARGB(255, 255, 255, 255),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: medalColor,
                child: Text(
                  rank.toString(),
                  style: TextStyle(
                    color: medalColor == Colors.transparent ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(currUser.username,style:TextStyle(fontWeight: FontWeight.bold),),
              subtitle: currUser.username == "JohnDoe"? Text("You",style: TextStyle(color: Colors.red),): null,
              trailing: Text(
                '${currUser.points} pts',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 158, 8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}