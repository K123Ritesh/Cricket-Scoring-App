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
    first: {
        team1: 'Royals11',
        team2: 'Hunters11',
        team1_score: '  ',
        team2_score:' ',
        message: 'Match Not Started Yet'
    },
    second: {
        team1: 'Titans11',
        team2: 'Hunters11',
        team1_score: ' ',
        team2_score:' ',
        message: 'Match Not Started Yet'
    },
};

// Endpoint to get live scores
app.get('/live-scores-today', (req, res) => {
    res.json(liveScores);
});

// Endpoint to update live scores
app.post('/update-score-live', (req, res) => {
    const { matchId, firstTeamScore,SecondTeamScore,message } = req.body;
    // Update the liveScores object
    if (liveScores[matchId]) {
        liveScores[matchId].team1_score = firstTeamScore;
        liveScores[matchId].team2_score=SecondTeamScore;
        liveScores[matchId].message=message
        res.json({ success: true, message: 'Score updated successfully' });
    } else {
        res.status(404).json({ success: false, message: 'Match not found' });
    }
});
app.get('/api/match', (req, res) => {
 const matchData = {
   topBatters: [
     { name: 'Prince Kumar', score: 50,teamName:'Royals11' },
     { name: 'Zeeshan Nawaz', score: 45,teamName:'Titans11' },
     { name: 'Rohit ', score: 40 ,teamName:'RTY'},
     { name: 'Player D', score: 35 ,teamName:'RTY'},
     { name: 'Player E', score: 30,teamName:'RTY' },
   ],
   topBowlers: [
     { name: 'Manweet ', wickets: 5 ,teamName:'RTY'},
     { name: 'Aditya Rajput', wickets: 4 ,teamName:'RTY'},
     { name: 'Bowler Z', wickets: 3 ,teamName:'RTY'},
     { name: 'Bowler W', wickets: 2 ,teamName:'RTY'},
     { name: 'Bowler V', wickets: 1 ,teamName:'RTY'},
   ],
   pointsTable: [
     { team: 'Titans11', points: 2 ,win:1 ,lost:0},
     { team: 'Hunters11', points:0 ,win:0 ,lost:0},
     { team: 'Warriors11', points: 0 ,win:0 ,lost:0},
     { team: 'Royals11', points:0,win:0 ,lost:1},
   ],
  
 };

 res.json(matchData);
});

app.listen(PORT, () => {
 console.log(`Server is running at http://localhost:${PORT}`);
});
