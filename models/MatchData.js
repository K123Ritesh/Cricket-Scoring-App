
const mongoose = require('mongoose');

const matchDataSchema = new mongoose.Schema({
  topBatters: [{ name: String, score: Number, teamName: String }],
  topBowlers: [{ name: String, wickets: Number, teamName: String }],
  pointsTable: [{ team: String, points: Number, win: Number, lost: Number }],
});

const MatchData = mongoose.model('MatchData', matchDataSchema);

module.exports = MatchData;
