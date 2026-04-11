const express = require('express');
const mongoose = require('mongoose');
const Redis = require('ioredis');
const { Pool } = require('pg');

const pool = new Pool({
  host: 'postgres-container',
  port: 5432,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB,
});

pool.connect()
  .then(() => console.log('✅ Connected to PostgreSQL'))
  .catch(err => console.error('❌ PostgreSQL connection error:', err.message));


const app = express();
const PORT = process.env.PORT || 4000;

// ─── MongoDB ───────────────────────────────────────────
// const MONGO_URL = `mongodb://${process.env.MONGO_USER}:${process.env.MONGO_PASSWORD}@mongo:27017`;

// const connectMongo = () => {
//   mongoose.connect(MONGO_URL)
//     .then(() => console.log('✅ Connected to MongoDB'))
//     .catch((err) => {
//       console.error('❌ MongoDB connection failed, retrying in 5s...', err.message);
//       setTimeout(connectMongo, 5000);
//     });
// };

// connectMongo();

// ─── Redis ─────────────────────────────────────────────
const redis = new Redis({
  host: process.env.REDIS_HOST || 'redis-container',
  port: process.env.REDIS_PORT || 6379,
});

redis.on('connect', () => console.log('✅ Connected to Redis'));
redis.on('error', (err) => console.error('❌ Redis connection error:', err.message));

// ─── Routes ────────────────────────────────────────────
app.get('/', (req, res) => {
  redis.set('products', 'products...');
  res.send('<h1>Hello!</h1>');
});

app.get('/data', async (req, res) => {
  const products = await redis.get('products');
  res.send(`<h1>Hello!</h1> <h2>${products}</h2>`);
});

// ─── Server ────────────────────────────────────────────
app.listen(PORT, () => console.log(`🚀 App is running on port ${PORT}`));