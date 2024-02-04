import 'dart:async';
import 'dart:convert';

class MatchData {
  String team1;
  String team2;
  String team1Score;
  String team2Score;
  String message;

  MatchData({
    required this.team1,
    required this.team2,
    required this.team1Score,
    required this.team2Score,
    required this.message,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      team1: json['team1'] ?? '',
      team2: json['team2'] ?? '',
      team1Score: json['team1_score'] ?? '',
      team2Score: json['team2_score'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
