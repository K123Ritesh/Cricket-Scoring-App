
const express = require('express');
const LiveScore = require('../models/LiveScore');
const router = express.Router();

router.get('/live-scores-today', async (req, res) => {
  try {
    const liveScores = await LiveScore.find();
    res.json(liveScores);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post('/update-score-live', async (req, res) => {
  const { matchId, firstTeamScore, SecondTeamScore, message } = req.body;

  try {
    const existingScore = await LiveScore.findOne({ matchId });

    if (existingScore) {
      existingScore.firstTeamScore = firstTeamScore;
      existingScore.SecondTeamScore = SecondTeamScore;
      existingScore.message = message;

      await existingScore.save();

      res.json({ success: true, message: 'Score updated successfully' });
    } else {
      res.status(404).json({ success: false, message: 'Match not found' });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
