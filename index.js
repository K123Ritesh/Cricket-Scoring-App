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
    _firstMatch: {
        team1: 'Team A',
        team2: 'Team B',
        team1_score: '0-0',
        team2_score:'',
        message: 'Match Not Started Yet'
    },
    _secondMatch: {
        team1: 'Team C',
        team2: 'Team D',
        team1_score: '0-0',
        team2_score:'',
        message: 'Match Not Started Yet'
    },
};

// Endpoint to get live scores
app.get('/live-scores-today', (req, res) => {
    res.json(liveScores);
});

// Endpoint to update live scores
app.post('/update-score-live', (req, res) => {
    const { matchId, firstTeamScore,SecondTeamScore } = req.body;
    // Update the liveScores object
    if (liveScores[matchId]) {
        liveScores[matchId].team1_score = firstTeamScore;
        liveScores[matchId].team2_score=SecondTeamScore;
        res.json({ success: true, message: 'Score updated successfully' });
    } else {
        res.status(404).json({ success: false, message: 'Match not found' });
    }
});
app.get('/api/match', (req, res) => {
 const matchData = {
   topBatters: [
     { name: 'Player A', score: 50,teamName:'RTY' },
     { name: 'Player B', score: 45,teamName:'RTY' },
     { name: 'Player C', score: 40 ,teamName:'RTY'},
     { name: 'Player D', score: 35 ,teamName:'RTY'},
     { name: 'Player E', score: 30,teamName:'RTY' },
   ],
   topBowlers: [
     { name: 'Bowler X', wickets: 5 ,teamName:'RTY'},
     { name: 'Bowler Y', wickets: 4 },
     { name: 'Bowler Z', wickets: 3 },
     { name: 'Bowler W', wickets: 2 },
     { name: 'Bowler V', wickets: 1 },
   ],
   pointsTable: [
     { team: 'Team 1', points: 10 ,teamName:'RTY',win:1 ,lost:1},
     { team: 'Team 2', points: 8 ,teamName:'RTY',win:1 ,lost:1},
     { team: 'Team 3', points: 6 ,teamName:'RTY',win:1 ,lost:1},
     { team: 'Team 4', points: 4,teamName:'RTY' ,win:1 ,lost:1},
   ],
   players: {
     team1: ['Player 1', 'Player 2', 'Player 3'],
     team2: ['Player 4', 'Player 5', 'Player 6'],
     team3: ['Player 7', 'Player 8', 'Player 9'],
     team4: ['Player 10', 'Player 11', 'Player 12'],
   },
 };

 res.json(matchData);
});

app.listen(PORT, () => {
 console.log(`Server is running at http://localhost:${PORT}`);
});
