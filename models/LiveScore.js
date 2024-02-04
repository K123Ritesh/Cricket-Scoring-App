
const mongoose = require('mongoose');

const liveScoreSchema = new mongoose.Schema({
  matchId: { type: String, required: true },
  firstTeamScore: { type: String },
  SecondTeamScore: { type: String },
  message: { type: String },
});

const LiveScore = mongoose.model('LiveScore', liveScoreSchema);

module.exports = LiveScore;
