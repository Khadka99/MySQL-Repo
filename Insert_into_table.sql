USE revision;

CREATE TABLE IF NOT EXISTS insert_into_users(
user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL
);

INSERT INTO insert_into_users (name, email, password)
VALUES
('Alice Johnson', 'alice.johnson@example.com', 'password123'),
('Bob Smith', 'bob.smith@example.com', 'securepass'),
('Carol Lee', 'carol.lee@example.com', 'mypassword'),
('David Brown', 'david.brown@example.com', 'passw0rd'),
('Eve Taylor', 'eve.taylor@example.com', 'qwerty123'),
('Frank Harris', 'frank.harris@example.com', 'abc123'),
('Grace White', 'grace.white@example.com', 'welcome1'),
('Hannah Adams', 'hannah.adams@example.com', 'letmein'),
('Ian Walker', 'ian.walker@example.com', 'password321'),
('Jack Hall', 'jack.hall@example.com', 'simplepass'),
('Kevin Brooks', 'kevin.brooks@example.com', 'pass1234'),
('Laura Scott', 'laura.scott@example.com', 'secureme'),
('Mike Davis', 'mike.davis@example.com', 'password12345'),
('Nancy Carter', 'nancy.carter@example.com', 'mypassword!'),
('Oliver Martin', 'oliver.martin@example.com', 'letmein2023'),
('Paul Evans', 'paul.evans@example.com', 'testpass'),
('Quinn Fisher', 'quinn.fisher@example.com', 'newpassword'),
('Rachel Green', 'rachel.green@example.com', 'hello1234'),
('Steve Wilson', 'steve.wilson@example.com', 'welcome123'),
('Tina Morris', 'tina.morris@example.com', 'simplepass1'),
('Uma Patel', 'uma.patel@example.com', 'mypassword1'),
('Victor Gomez', 'victor.gomez@example.com', 'tryagain'),
('Wendy Hughes', 'wendy.hughes@example.com', 'letme1n'),
('Xavier King', 'xavier.king@example.com', 'securekey'),
('Yara Lopez', 'yara.lopez@example.com', 'password999'),
('Zane Bell', 'zane.bell@example.com', 'myp@ssword'),
('Amy Reed', 'amy.reed@example.com', '123welcome'),
('Ben Fox', 'ben.fox@example.com', 'qwertypass'),
('Cindy Lane', 'cindy.lane@example.com', 'safepass1'),
('Derek Young', 'derek.young@example.com', 'simplepwd'),
('Ella Knight', 'ella.knight@example.com', 'trythis123'),
('Fred Morris', 'fred.morris@example.com', 'securepwd!'),
('Gina Perry', 'gina.perry@example.com', 'helloWorld'),
('Harry Cruz', 'harry.cruz@example.com', 'newKey123'),
('Ivy Bennett', 'ivy.bennett@example.com', '123simple'),
('Jake Rogers', 'jake.rogers@example.com', 'mypwd321'),
('Kara Stone', 'kara.stone@example.com', 'try@123'),
('Leo Turner', 'leo.turner@example.com', 'pass9999'),
('Mia Cook', 'mia.cook@example.com', 'letme123'),
('Nate Sanders', 'nate.sanders@example.com', 'mypassword!'),
('Oscar Hughes', 'oscar.hughes@example.com', 'securepass22'),
('Penny Gray', 'penny.gray@example.com', '123password'),
('Quincy Diaz', 'quincy.diaz@example.com', 'welcome22'),
('Rose Allen', 'rose.allen@example.com', 'mypwd!123'),
('Sam Bailey', 'sam.bailey@example.com', 'secure111'),
('Terry Howard', 'terry.howard@example.com', 'myp@ssw0rd'),
('Ursula Clark', 'ursula.clark@example.com', 'testme123'),
('Vera Adams', 'vera.adams@example.com', 'hello!321'),
('Will James', 'will.james@example.com', 'securepwd2'),
('Xena Ross', 'xena.ross@example.com', 'newTry!123'),
('Yusuf Hayes', 'yusuf.hayes@example.com', 'secure!99'),
('Zoe Cooper', 'zoe.cooper@example.com', 'trymypwd'),
('Alan Cole', 'alan.cole@example.com', 'mypassword22'),
('Betty Ford', 'betty.ford@example.com', 'simple1234'),
('Caleb Kelly', 'caleb.kelly@example.com', 'letmein321'),
('Dana Paul', 'dana.paul@example.com', 'testpwd99'),
('Ethan Lewis', 'ethan.lewis@example.com', 'mypwd12'),
('Fiona Long', 'fiona.long@example.com', 'secureme123'),
('Gabe Bryant', 'gabe.bryant@example.com', 'tryagain44'),
('Holly Ward', 'holly.ward@example.com', 'mypassword2023'),
('Irene James', 'irene.james@example.com', 'simple2024'),
('Jackie Moore', 'jackie.moore@example.com', 'passwordreset'),
('Kyle Hill', 'kyle.hill@example.com', 'newSecureKey'),
('Laura Powell', 'laura.powell@example.com', '1234mypwd'),
('Matt Scott', 'matt.scott@example.com', 'passwordTest'),
('Nina Diaz', 'nina.diaz@example.com', 'mypassword2022'),
('Owen Murphy', 'owen.murphy@example.com', 'try123'),
('Paula Bennett', 'paula.bennett@example.com', 'letmeinSecure'),
('Quinn Hayes', 'quinn.hayes@example.com', 'helloSecure99'),
('Rita Foster', 'rita.foster@example.com', 'mypwdReset'),
('Scott Murphy', 'scott.murphy@example.com', 'securePass123'),
('Tara Walsh', 'tara.walsh@example.com', 'mypwd!2024'),
('Ulysses Hart', 'ulysses.hart@example.com', 'passwordMe123'),
('Victoria Neal', 'victoria.neal@example.com', 'secure2024'),
('Walter Carter', 'walter.carter@example.com', 'mypassword45'),
('Xander Ross', 'xander.ross@example.com', 'passwordCheck'),
('Yvonne Evans', 'yvonne.evans@example.com', 'securemePass'),
('Zack Moore', 'zack.moore@example.com', 'mypwdTest');



SELECT * FROM insert_into_users;

INSERT INTO insert_into_users
VALUES(NULL,'Rob','rob@gmail.com','xyzcvh');




