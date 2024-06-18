DROP DATABASE If EXISTS Bubble;
CREATE DATABASE Bubble;
USE Bubble;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_admin TINYINT(1) DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    bubble_tea VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO users (username, email, password) VALUES
    ('jojo', 'jojo@hotmail.fr', 'pass'),
    ('jaja', 'jaja@hotmail.fr', 'pass');


SET @user1_id = LAST_INSERT_ID(); -- ca c'est pour recup le dernier id inserer, le @ convention sinon marche pas 
SET @user2_id = LAST_INSERT_ID() + 1;


INSERT INTO products (user_id, bubble_tea) VALUES
    (@user1_id, 'Bubble Tea 1'),
    (@user2_id, 'Bubble Tea 1');