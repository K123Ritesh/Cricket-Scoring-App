const express = require('express');
const cors = require('cors');
require('dotenv').config()
const app = express();
const PORT = process.env.PORT || 3030;
app.use(cors())
const bodyParser = require('body-parser');


// Use body-parser middleware to parse JSON in request bodies
app.use(bodyParser.json());

// Placeholder for live scores
let liveScores = {
    match1: {
        team1: 'Team A',
        team2: 'Team B',
        score: '2-1',
        time: '75th minute'
    },
    match2: {
        team1: 'Team C',
        team2: 'Team D',
        score: '0-0',
        time: '30th minute'
    },
};

// Endpoint to get live scores
app.get('/live-scores', (req, res) => {
    res.json(liveScores);
});

// Endpoint to update live scores
app.post('/update-score', (req, res) => {
    const { matchId, newScore } = req.body;

    // Update the liveScores object
    if (liveScores[matchId]) {
        liveScores[matchId].score = newScore;
        res.json({ success: true, message: 'Score updated successfully' });
    } else {
        res.status(404).json({ success: false, message: 'Match not found' });
    }
});
app.get('/api/match', (req, res) => {
 const matchData = {
   topBatters: [
     { name: 'Player A', score: 50 },
     { name: 'Player B', score: 45 },
     { name: 'Player C', score: 40 },
     { name: 'Player D', score: 35 },
     { name: 'Player E', score: 30 },
   ],
   topBowlers: [
     { name: 'Bowler X', wickets: 5 },
     { name: 'Bowler Y', wickets: 4 },
     { name: 'Bowler Z', wickets: 3 },
     { name: 'Bowler W', wickets: 2 },
     { name: 'Bowler V', wickets: 1 },
   ],
   pointsTable: [
     { team: 'Team 1', points: 10 },
     { team: 'Team 2', points: 8 },
     { team: 'Team 3', points: 6 },
     { team: 'Team 4', points: 4 },
   ],
   todaysMatches: [
     { team1: 'Team 1', team2: 'Team 2' },
     { team1: 'Team 3', team2: 'Team 4' },
   ],
   players: {
     team1: ['Player 1', 'Player 2', 'Player 3'],
     team2: ['Player 4', 'Player 5', 'Player 6'],
     team3: ['Player 7', 'Player 8', 'Player 9'],
     team4: ['Player 10', 'Player 11', 'Player 12'],
   },
   captains: {
     team1: 'Captain 1',
     team2: 'Captain 2',
     team3: 'Captain 3',
     team4: 'Captain 4',
   },
   viceCaptains: {
     team1: 'Vice Captain 1',
     team2: 'Vice Captain 2',
     team3: 'Vice Captain 3',
     team4: 'Vice Captain 4',
   },
 };

 res.json(matchData);
});

app.listen(PORT, () => {
 console.log(`Server is running at http://localhost:${PORT}`);
});
