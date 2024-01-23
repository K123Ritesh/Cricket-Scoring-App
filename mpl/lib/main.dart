import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> matchData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("http://localhost:3000/api/match"));

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        matchData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget buildTopPlayers(List<dynamic> players, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        for (var player in players)
          Text('${player['name']}: ${player['score']}'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket Tournament App'),
      ),
      body: matchData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTopPlayers(matchData['topBatters'], 'Top Batters:'),
                  buildTopPlayers(matchData['topBowlers'], 'Top Bowlers:'),
                  Text('Points Table:'),
                  for (var entry in matchData['pointsTable'])
                    Text('${entry['team']}: ${entry['points']} points'),
                  Text('Today\'s Matches:'),
                  for (var match in matchData['todaysMatches'])
                    Text('${match['team1']} vs ${match['team2']}'),
                  Text('Players:'),
                  for (var team in matchData['players'].keys)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$team:'),
                        for (var player in matchData['players'][team])
                          Text('- $player'),
                      ],
                    ),
                  Text('Captains:'),
                  for (var team in matchData['captains'].keys)
                    Text('$team: ${matchData['captains'][team]}'),
                  Text('Vice Captains:'),
                  for (var team in matchData['viceCaptains'].keys)
                    Text('$team: ${matchData['viceCaptains'][team]}'),
                ],
              ),
            ),
    );
  }
}
