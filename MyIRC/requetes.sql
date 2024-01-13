DROP DATABASE IF EXISTS myIRC;
CREATE DATABASE myIRC;

USE myIRC;
/*si la table existe pas on la crée*/
CREATE TABLE IF NOT EXISTS 'channels' (
    channel_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
  );

CREATE TABLE IF NOT EXISTS 'users' (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE
  );

/* mis dans variable*/
CREATE TABLE IF NOT EXISTS 'messages' (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    channel_id INT,
    user_id INT,
    content TEXT,
    timestamp DATETIME,
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
  );
  

/*user*/
SET User_id := '1';
SET Username := 'utilisateur1';
SET Password := 'motdepasse1';
SET IsAdmin := 1; 


/*channels*/
SET Channel_id;
SET Name  := 'channel '
/*messages*/

SET Message_id := '1'
SET Channel_id := '1'
SET User_id := '1'
SET Content := 'Message 1';
SET Timestamp := NOW();

INSERT INTO 'channels' (channel_id,name) VALUES(Channel_id,Name);
INSERT INTO 'users' (user_id,username,password,is_admin) VALUES(User_id,Username,Password,Is_Admin);
INSERT INTO 'messages' (message_id,channel_id,user_id,content,timestamp) VALUES(Message_id,Channel_id,User_id,Content,Timestamp);



/*test*/
INSERT INTO 'users' (user_id,username,password,is_admin) VALUES(1,"toto","tata",0);
/* syntaxe ok INSERT ""
const query_insert =
      "INSERT INTO users(username,password) VALUES('" +
      Username +
      "','" +
      password +
      "')";
      */



     /* insert avec bactip 
     const query_insert = `INSERT INTO users(username,password) VALUES('${username}','${password}')`;
     */

     /*alter table rajouter datetime not null default now */

     ALTER TABLE users
DROP COLUMN date_account
;