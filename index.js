require('dotenv').config();
const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

async function runMigrations() {
  const sqlPath = path.join(__dirname, 'index.sql');
  const script = fs.readFileSync(sqlPath, 'utf8');

  const client = await pool.connect();
  try {
    await client.query(script);
    console.log('Миграции успешно применены');
  } catch (err) {
    console.error('Ошибка миграции:', err);
  } finally {
    client.release();
  }
}

runMigrations();
