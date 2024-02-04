// app.js
const express = require('express');
const cors = require('cors');
require('dotenv').config();
const mongoose = require('mongoose');
const LiveScoresRoutes = require('./routes/liveScoresRoutes');
const MatchDataRoutes = require('./routes/matchDataRoutes');

const app = express();
const PORT = process.env.PORT || 3030;

app.use(cors());
const bodyParser = require('body-parser');

// Use body-parser middleware to parse JSON in request bodies
app.use(bodyParser.json());

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });
const db = mongoose.connection;

db.on('error', console.error.bind(console, 'MongoDB connection error:'));
db.once('open', () => {
  console.log('Connected to MongoDB');
});

// Use routes
app.use('/', LiveScoresRoutes);
app.use('/', MatchDataRoutes);

app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});
