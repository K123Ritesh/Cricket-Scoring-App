
const express = require('express');
const MatchData = require('../models/MatchData');
const router = express.Router();


router.get('/api/match', async (req, res) => {
  try {
    const matchData = await MatchData.findOne();
    res.json(matchData);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
