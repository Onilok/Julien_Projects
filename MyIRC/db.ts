import mysql from "mysql2";
import {
  name_channel,
  username,
  password,
  channel_id,
  user_id,
  content,
} from "./index";

export const db = mysql.createConnection({
  host: "localhost",
  user: "julien",
  password: "pass",
  database: "myIRC",
});

const dropdb = `DROP DATABASE IF EXISTS myIRC;`;
const createdb = `CREATE DATABASE myIRC;`;

// je peux mettre les requete ici dans des variable et je peux les apeller dans index.ts

export const query_channels =
  "CREATE TABLE IF NOT EXISTS channels (channel_id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(255) NOT NULL UNIQUE);";

export const query_users = `CREATE TABLE IF NOT EXISTS users(
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  is_admin BOOLEAN DEFAULT FALSE,
  date_account TIMESTAMP NOT NULL DEFAULT NOW()
);`;

// syntaxe alter table
// ALTER TABLE users ADD date_account TIMESTAMP NOT NULL DEFAULT NOW()

export const query_message =
  "CREATE TABLE IF NOT EXISTS messages (message_id INT AUTO_INCREMENT PRIMARY KEY,channel_id INT,user_id INT,content TEXT,date TIMESTAMP NOT NULL DEFAULT NOW(),FOREIGN KEY (channel_id) REFERENCES channels(channel_id),FOREIGN KEY (user_id) REFERENCES users(user_id));";
/*
export let query_insert_channels = `INSERT INTO channels(name) VALUES('${name_channel}');`;
export let query_insert_users = `INSERT INTO users(username,password) VALUES('${username}','${password}');`;
export let query_insert_messages = `INSERT INTO messages(channel_id,user_id,content) VALUES('${channel_id}','${user_id}','${content}');`;
*/

export const query_select_user = `SELECT * FROM users WHERE user_id = 5;`;
//export const query_select_user =
