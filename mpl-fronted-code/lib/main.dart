import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpl/home_page.dart';
import 'package:mpl/live_scores_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: child,
        );
      },
      child: MyForm(),
    );
  }
}

// class MatchCard extends StatelessWidget {
//   final String matchTitle;
//   final String team1Name;
//   final String team2Name;
//   final String score1;
//   final String score2;
//   final String scoretowin;

//   const MatchCard(
//       {required this.matchTitle,
//       required this.team1Name,
//       required this.team2Name,
//       required this.score1,
//       required this.score2,
//       required this.scoretowin});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           Text(matchTitle),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(team1Name),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(team2Name),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(score1),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(score2),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Text("Needs $scoretowin runs to win")
//         ],
//       ),
//     );
//   }
// }

// class LiveScoresCard extends StatelessWidget {
//   final Map<String, dynamic> matchData;

//   const LiveScoresCard({required this.matchData});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         children: [
//           Text('Team 1 Name: ${matchData['team1']}'),
//           Text('Team 2 Name: ${matchData['team2']}'),
//           Text('Team 1 Score: ${matchData['team1_score']}'),
//           Text('Team 2 Score: ${matchData['team2_score']}'),
//           Text('Message: ${matchData['message']}'),
//         ],
//       ),
//     );
//   }
// }

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController matchIdController = TextEditingController();
  TextEditingController firstTeamScoreController = TextEditingController();
  TextEditingController secondTeamScoreController = TextEditingController();
  TextEditingController messageController =
      TextEditingController(text: 'Match Not Started Yet');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Scores MPL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LiveScoresWidget(matchTime: "first"),
              LiveScoresWidget(matchTime: "second"),
              TextField(
                controller: matchIdController,
                decoration: const InputDecoration(labelText: 'Match ID'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: firstTeamScoreController,
                decoration:
                    const InputDecoration(labelText: 'First Team Score'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: secondTeamScoreController,
                decoration:
                    const InputDecoration(labelText: 'Second Team Score'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: messageController,
                decoration: const InputDecoration(labelText: 'Message'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  updateScores();
                },
                child: const Text('Update Scores'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateScores() async {
    final url = 'https://mpl-backend-92m8.onrender.com/update-score-live';

    final body = {
      "matchId": matchIdController.text,
      "firstTeamScore": firstTeamScoreController.text,
      "SecondTeamScore": secondTeamScoreController.text,
      "message": messageController.text
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Handle success
        Get.snackbar('Success', 'Scores updated successfully!',
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      } else {
        // Handle errors
        Get.snackbar('Error',
            'Failed to update scores. Status code: ${response.statusCode}',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (error) {
      // Handle network errors or other exceptions
      Get.snackbar('Error', 'Error: $error',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
