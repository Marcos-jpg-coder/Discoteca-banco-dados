CREATE DATABASE IF NOT EXISTS db_discoteca
COLLATE utf8mb4_general_ci CHARSET utf8mb4;


	use db_discoteca;
    
    -- Tabelas independentes
CREATE TABLE Gravadora (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Tipo_Artista (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(20) NOT NULL UNIQUE  -- "Solo", "Banda", "Dupla", "Concerto"
);

CREATE TABLE Genero (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE  -- "Rock", "Pop", etc.
);

-- Tabelas dependentes
CREATE TABLE Artista (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_tipo_artista INT NOT NULL,
    data_nascimento DATE NULL,
    FOREIGN KEY (id_tipo_artista) REFERENCES Tipo_Artista(id),
    CHECK (
        (SELECT nome FROM Tipo_Artista WHERE id = id_tipo_artista) = 'Solo' 
        AND data_nascimento IS NOT NULL
        OR
        (SELECT nome FROM Tipo_Artista WHERE id = id_tipo_artista) != 'Solo' 
        AND data_nascimento IS NULL
    )
);

CREATE TABLE Disco (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    duracao TIME NOT NULL,
    ano_lancamento INT NOT NULL,
    id_genero INT NOT NULL,
    id_artista INT NOT NULL,
    id_gravadora INT NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES Genero(id),
    FOREIGN KEY (id_artista) REFERENCES Artista(id),
    FOREIGN KEY (id_gravadora) REFERENCES Gravadora(id),
    CHECK (ano_lancamento BETWEEN 1900 AND YEAR(CURRENT_DATE))
);

CREATE TABLE Musica (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    duracao TIME NOT NULL,
    id_disco INT NOT NULL,
    FOREIGN KEY (id_disco) REFERENCES Disco(id) ON DELETE CASCADE,
    CHECK (TIME_TO_SEC(duracao) > 0)
);
-- Inserção de Gravadoras (5 distintas)
INSERT INTO Gravadora (id, nome) VALUES
(1, 'Sony Music'),
(2, 'Universal Music'),
(3, 'Warner Music'),
(4, 'EMI'),
(5, 'RCA Records');

-- Inserção de Tipos de Artista
INSERT INTO Tipo_Artista (id, nome) VALUES
(1, 'Solo'),
(2, 'Banda'),
(3, 'Dupla'),
(4, 'Concerto');

-- Inserção de Gêneros Musicais
INSERT INTO Genero (id, nome) VALUES
(1, 'Rock'),
(2, 'Pop'),
(3, 'MPB'),
(4, 'Sertanejo'),
(5, 'Eletrônica'),
(6, 'Hip Hop'),
(7, 'Jazz'),
(8, 'Classical'),
(9, 'Reggae'),
(10, 'Blues');

-- Inserção de Artistas (30 diferentes, variados)
-- Artistas Solo
INSERT INTO Artista (id, nome, id_tipo_artista, data_nascimento) VALUES
(1, 'Elvis Presley', 1, '1935-01-08'),
(2, 'Madonna', 1, '1958-08-16'),
(3, 'Michael Jackson', 1, '1958-08-29'),
(4, 'Beyoncé', 1, '1981-09-04'),
(5, 'Roberto Carlos', 1, '1941-04-19'),
(6, 'Elis Regina', 1, '1945-03-17'),
(7, 'Frank Sinatra', 1, '1915-12-12'),
(8, 'Amy Winehouse', 1, '1983-09-14'),
(9, 'Bob Dylan', 1, '1941-05-24'),
(10, 'Caetano Veloso', 1, '1942-08-07');

-- Bandas
INSERT INTO Artista (id, nome, id_tipo_artista, data_nascimento) VALUES
(11, 'The Beatles', 2, NULL),
(12, 'Pink Floyd', 2, NULL),
(13, 'Queen', 2, NULL),
(14, 'Metallica', 2, NULL),
(15, 'Legião Urbana', 2, NULL),
(16, 'Coldplay', 2, NULL),
(17, 'Red Hot Chili Peppers', 2, NULL),
(18, 'The Rolling Stones', 2, NULL),
(19, 'U2', 2, NULL),
(20, 'Nirvana', 2, NULL);

-- Duplas
INSERT INTO Artista (id, nome, id_tipo_artista, data_nascimento) VALUES
(21, 'Daft Punk', 3, NULL),
(22, 'Simon & Garfunkel', 3, NULL),
(23, 'The White Stripes', 3, NULL),
(24, 'Chitãozinho & Xororó', 3, NULL),
(25, 'Milburn', 3, NULL),
(26, 'Brooks & Dunn', 3, NULL),
(27, 'Pet Shop Boys', 3, NULL),
(28, 'The Chainsmokers', 3, NULL),
(29, 'MGMT', 3, NULL),
(30, 'The Black Keys', 3, NULL);

-- Inserção de Discos (10 para cada gravadora = 50 discos)
-- Gravadora 1 (Sony)
INSERT INTO Disco (id, titulo, duracao, ano_lancamento, id_genero, id_artista, id_gravadora) VALUES
(1, 'Thriller', '00:42:19', 1982, 2, 3, 1),
(2, 'Bad', '00:48:16', 1987, 2, 3, 1),
(3, 'Dangerous', '01:17:03', 1991, 2, 3, 1),
(4, 'Like a Virgin', '00:43:10', 1984, 2, 2, 1),
(5, 'Ray of Light', '00:66:45', 1998, 2, 2, 1),
(6, 'Elvis Presley', '00:28:03', 1956, 1, 1, 1),
(7, 'From Elvis in Memphis', '00:39:57', 1969, 1, 1, 1),
(8, 'Dangerously in Love', '00:63:42', 2003, 2, 4, 1),
(9, 'Beyoncé', '00:53:49', 2013, 2, 4, 1),
(10, 'Lemonade', '00:45:00', 2016, 2, 4, 1);

-- Gravadora 2 (Universal)
INSERT INTO Disco (id, titulo, duracao, ano_lancamento, id_genero, id_artista, id_gravadora) VALUES
(11, 'Abbey Road', '00:47:23', 1969, 1, 11, 2),
(12, 'Sgt. Pepper''s Lonely Hearts Club Band', '00:39:52', 1967, 1, 11, 2),
(13, 'The Dark Side of the Moon', '00:42:59', 1973, 1, 12, 2),
(14, 'Wish You Were Here', '00:44:28', 1975, 1, 12, 2),
(15, 'A Night at the Opera', '00:43:08', 1975, 1, 13, 2),
(16, 'News of the World', '00:39:15', 1977, 1, 13, 2),
(17, 'Metallica', '00:62:31', 1991, 1, 14, 2),
(18, 'Master of Puppets', '00:54:45', 1986, 1, 14, 2),
(19, 'Parachutes', '00:41:44', 2000, 1, 16, 2),
(20, 'A Rush of Blood to the Head', '00:54:12', 2002, 1, 16, 2);

-- Gravadora 3 (Warner)
INSERT INTO Disco (id, titulo, duracao, ano_lancamento, id_genero, id_artista, id_gravadora) VALUES
(21, 'The Wall', '01:21:11', 1979, 1, 12, 3),
(22, 'Animals', '00:41:51', 1977, 1, 12, 3),
(23, 'Jazz', '00:44:11', 1978, 1, 13, 3),
(24, 'The Game', '00:35:39', 1980, 1, 13, 3),
(25, 'Californication', '00:56:24', 1999, 1, 17, 3),
(26, 'By the Way', '00:68:46', 2002, 1, 17, 3),
(27, 'Sticky Fingers', '00:46:25', 1971, 1, 18, 3),
(28, 'Exile on Main St.', '01:07:17', 1972, 1, 18, 3),
(29, 'The Joshua Tree', '00:50:11', 1987, 1, 19, 3),
(30, 'Achtung Baby', '00:55:23', 1991, 1, 19, 3);

-- Gravadora 4 (EMI)
INSERT INTO Disco (id, titulo, duracao, ano_lancamento, id_genero, id_artista, id_gravadora) VALUES
(31, 'Nevermind', '00:42:38', 1991, 1, 20, 4),
(32, 'In Utero', '00:41:12', 1993, 1, 20, 4),
(33, 'Discovery', '01:00:52', 2001, 5, 21, 4),
(34, 'Random Access Memories', '01:14:28', 2013, 5, 21, 4),
(35, 'Bridge over Troubled Water', '00:36:47', 1970, 1, 22, 4),
(36, 'Bookends', '00:29:51', 1968, 1, 22, 4),
(37, 'Elephant', '00:49:56', 2003, 1, 23, 4),
(38, 'White Blood Cells', '00:40:26', 2001, 1, 23, 4),
(39, 'Actually', '00:48:19', 1987, 5, 27, 4),
(40, 'Please', '00:40:31', 1986, 5, 27, 4);

-- Gravadora 5 (RCA)
INSERT INTO Disco (id, titulo, duracao, ano_lancamento, id_genero, id_artista, id_gravadora) VALUES
(41, 'Transa', '00:37:21', 1972, 3, 10, 5),
(42, 'Tropicália 2', '00:45:08', 1993, 3, 10, 5),
(43, 'Cores e Nomes', '00:45:00', 1980, 3, 5, 5),
(44, 'Roberto Carlos', '00:35:12', 1961, 3, 5, 5),
(45, 'Elis & Tom', '00:46:34', 1974, 3, 6, 5),
(46, 'Falso Brilhante', '00:41:55', 1976, 3, 6, 5),
(47, 'In the Wee Small Hours', '00:48:34', 1955, 7, 7, 5),
(48, 'Come Fly with Me', '00:35:14', 1958, 7, 7, 5),
(49, 'Back to Black', '00:34:54', 2006, 2, 8, 5),
(50, 'Frank', '00:58:18', 2003, 2, 8, 5);

-- Inserção de Músicas (7-10 por disco, quantidades variadas)
-- Função para gerar durações aleatórias entre 2 e 6 minutos
DELIMITER //
CREATE FUNCTION random_duration() RETURNS TIME
BEGIN
    DECLARE minutes INT;
    DECLARE seconds INT;
    SET minutes = FLOOR(2 + RAND() * 5);
    SET seconds = FLOOR(RAND() * 60);
    RETURN CONCAT('00:', LPAD(minutes, 2, '0'), ':', LPAD(seconds, 2, '0'));
END //
DELIMITER ;

-- Inserção de músicas para cada disco (exemplo para os primeiros 5 discos)
-- Disco 1 (Thriller) - 9 músicas
INSERT INTO Musica (id, nome, duracao, id_disco) VALUES
(1, 'Wanna Be Startin'' Somethin''', random_duration(), 1),
(2, 'Baby Be Mine', random_duration(), 1),
(3, 'The Girl Is Mine', random_duration(), 1),
(4, 'Thriller', random_duration(), 1),
(5, 'Beat It', random_duration(), 1),
(6, 'Billie Jean', random_duration(), 1),
(7, 'Human Nature', random_duration(), 1),
(8, 'P.Y.T. (Pretty Young Thing)', random_duration(), 1),
(9, 'The Lady in My Life', random_duration(), 1);

-- Disco 2 (Bad) - 8 músicas
INSERT INTO Musica (id, nome, duracao, id_disco) VALUES
(10, 'Bad', random_duration(), 2),
(11, 'The Way You Make Me Feel', random_duration(), 2),
(12, 'Speed Demon', random_duration(), 2),
(13, 'Liberian Girl', random_duration(), 2),
(14, 'Just Good Friends', random_duration(), 2),
(15, 'Another Part of Me', random_duration(), 2),
(16, 'Man in the Mirror', random_duration(), 2),
(17, 'I Just Can''t Stop Loving You', random_duration(), 2);

-- Disco 3 (Dangerous) - 7 músicas
INSERT INTO Musica (id, nome, duracao, id_disco) VALUES
(18, 'Jam', random_duration(), 3),
(19, 'Why You Wanna Trip on Me', random_duration(), 3),
(20, 'In the Closet', random_duration(), 3),
(21, 'She Drives Me Wild', random_duration(), 3),
(22, 'Remember the Time', random_duration(), 3),
(23, 'Can''t Let Her Get Away', random_duration(), 3),
(24, 'Heal the World', random_duration(), 3);

-- Disco 4 (Like a Virgin) - 9 músicas
INSERT INTO Musica (id, nome, duracao, id_disco) VALUES
(25, 'Material Girl', random_duration(), 4),
(26, 'Angel', random_duration(), 4),
(27, 'Like a Virgin', random_duration(), 4),
(28, 'Over and Over', random_duration(), 4),
(29, 'Love Don''t Live Here Anymore', random_duration(), 4),
(30, 'Dress You Up', random_duration(), 4),
(31, 'Shoo-Bee-Doo', random_duration(), 4),
(32, 'Pretender', random_duration(), 4),
(33, 'Stay', random_duration(), 4);

-- Disco 5 (Ray of Light) - 10 músicas
INSERT INTO Musica (id, nome, duracao, id_disco) VALUES
(34, 'Drowned World/Substitute for Love', random_duration(), 5),
(35, 'Swim', random_duration(), 5),
(36, 'Ray of Light', random_duration(), 5),
(37, 'Candy Perfume Girl', random_duration(), 5),
(38, 'Skin', random_duration(), 5),
(39, 'Nothing Really Matters', random_duration(), 5),
(40, 'Sky Fits Heaven', random_duration(), 5),
(41, 'Shanti/Ashtangi', random_duration(), 5),
(42, 'Frozen', random_duration(), 5),
(43, 'The Power of Good-Bye', random_duration(), 5);

-- Continuação para os outros discos (repetir o padrão)
-- Disco 6 (Elvis Presley) - 8 músicas
INSERT INTO Musica (id, nome, duracao, id_disco) VALUES
(44, 'Blue Suede Shoes', random_duration(), 6),
(45, 'I''m Counting on You', random_duration(), 6),
(46, 'I Got a Woman', random_duration(), 6),
(47, 'One-Sided Love Affair', random_duration(), 6),
(48, 'I Love You Because', random_duration(), 6),
(49, 'Just Because', random_duration(), 6),
(50, 'Tutti Frutti', random_duration(), 6),
(51, 'Tryin'' to Get to You', random_duration(), 6);

-- Disco 7 (From Elvis in Memphis) - 8 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Wearin'' That Loved On Look', random_duration(), 7),
('Only the Strong Survive', random_duration(), 7),
('I''ll Hold You in My Heart', random_duration(), 7),
('Long Black Limousine', random_duration(), 7),
('It Keeps Right On A-Hurtin''', random_duration(), 7),
('I''m Movin'' On', random_duration(), 7),
('Power of My Love', random_duration(), 7),
('In the Ghetto', random_duration(), 7);

-- Disco 8 (Dangerously in Love) - 9 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Crazy in Love', random_duration(), 8),
('Naughty Girl', random_duration(), 8),
('Baby Boy', random_duration(), 8),
('Hip Hop Star', random_duration(), 8),
('Be with You', random_duration(), 8),
('Me, Myself and I', random_duration(), 8),
('Yes', random_duration(), 8),
('Signs', random_duration(), 8),
('Gift from Virgo', random_duration(), 8);

-- Disco 9 (Beyoncé) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Pretty Hurts', random_duration(), 9),
('Haunted', random_duration(), 9),
('Drunk in Love', random_duration(), 9),
('Blow', random_duration(), 9),
('No Angel', random_duration(), 9),
('Partition', random_duration(), 9),
('Jealous', random_duration(), 9),
('Rocket', random_duration(), 9),
('Mine', random_duration(), 9),
('XO', random_duration(), 9);

-- Disco 10 (Lemonade) - 8 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Pray You Catch Me', random_duration(), 10),
('Hold Up', random_duration(), 10),
('Don''t Hurt Yourself', random_duration(), 10),
('Sorry', random_duration(), 10),
('6 Inch', random_duration(), 10),
('Daddy Lessons', random_duration(), 10),
('Love Drought', random_duration(), 10),
('Formation', random_duration(), 10);

-- Disco 11 (Abbey Road) - 9 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Come Together', random_duration(), 11),
('Something', random_duration(), 11),
('Maxwell''s Silver Hammer', random_duration(), 11),
('Oh! Darling', random_duration(), 11),
('Octopus''s Garden', random_duration(), 11),
('I Want You (She''s So Heavy)', random_duration(), 11),
('Here Comes the Sun', random_duration(), 11),
('Because', random_duration(), 11),
('The End', random_duration(), 11);

-- Disco 12 (Sgt. Pepper''s) - 8 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Sgt. Pepper''s Lonely Hearts Club Band', random_duration(), 12),
('With a Little Help from My Friends', random_duration(), 12),
('Lucy in the Sky with Diamonds', random_duration(), 12),
('Getting Better', random_duration(), 12),
('Fixing a Hole', random_duration(), 12),
('She''s Leaving Home', random_duration(), 12),
('Being for the Benefit of Mr. Kite!', random_duration(), 12),
('A Day in the Life', random_duration(), 12);

-- Disco 13 (The Dark Side of the Moon) - 7 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Speak to Me', random_duration(), 13),
('Breathe', random_duration(), 13),
('On the Run', random_duration(), 13),
('Time', random_duration(), 13),
('The Great Gig in the Sky', random_duration(), 13),
('Money', random_duration(), 13),
('Us and Them', random_duration(), 13);

-- Disco 14 (Wish You Were Here - Pink Floyd) - 5 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Shine On You Crazy Diamond (Parts I-V)', random_duration(), 14),
('Welcome to the Machine', random_duration(), 14),
('Have a Cigar', random_duration(), 14),
('Wish You Were Here', random_duration(), 14),
('Shine On You Crazy Diamond (Parts VI-IX)', random_duration(), 14);

-- Disco 15 (A Night at the Opera - Queen) - 12 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Death on Two Legs', random_duration(), 15),
('Lazing on a Sunday Afternoon', random_duration(), 15),
('I''m in Love with My Car', random_duration(), 15),
('You''re My Best Friend', random_duration(), 15),
('''39', random_duration(), 15),
('Sweet Lady', random_duration(), 15),
('Seaside Rendezvous', random_duration(), 15),
('The Prophet''s Song', random_duration(), 15),
('Love of My Life', random_duration(), 15),
('Good Company', random_duration(), 15),
('Bohemian Rhapsody', random_duration(), 15),
('God Save the Queen', random_duration(), 15);

-- Disco 16 (News of the World - Queen) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('We Will Rock You', random_duration(), 16),
('We Are the Champions', random_duration(), 16),
('Sheer Heart Attack', random_duration(), 16),
('All Dead, All Dead', random_duration(), 16),
('Spread Your Wings', random_duration(), 16),
('Fight from the Inside', random_duration(), 16),
('Get Down, Make Love', random_duration(), 16),
('Sleeping on the Sidewalk', random_duration(), 16),
('Who Needs You', random_duration(), 16),
('It''s Late', random_duration(), 16);

-- Disco 17 (Metallica - Metallica) - 12 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Enter Sandman', random_duration(), 17),
('Sad but True', random_duration(), 17),
('Holier Than Thou', random_duration(), 17),
('The Unforgiven', random_duration(), 17),
('Wherever I May Roam', random_duration(), 17),
('Don''t Tread on Me', random_duration(), 17),
('Through the Never', random_duration(), 17),
('Nothing Else Matters', random_duration(), 17),
('Of Wolf and Man', random_duration(), 17),
('The God That Failed', random_duration(), 17),
('My Friend of Misery', random_duration(), 17),
('The Struggle Within', random_duration(), 17);

-- Disco 18 (Master of Puppets - Metallica) - 8 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Battery', random_duration(), 18),
('Master of Puppets', random_duration(), 18),
('The Thing That Should Not Be', random_duration(), 18),
('Welcome Home (Sanitarium)', random_duration(), 18),
('Disposable Heroes', random_duration(), 18),
('Leper Messiah', random_duration(), 18),
('Orion', random_duration(), 18),
('Damage, Inc.', random_duration(), 18);

-- Disco 19 (Parachutes - Coldplay) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Don''t Panic', random_duration(), 19),
('Shiver', random_duration(), 19),
('Spies', random_duration(), 19),
('Sparks', random_duration(), 19),
('Yellow', random_duration(), 19),
('Trouble', random_duration(), 19),
('Parachutes', random_duration(), 19),
('High Speed', random_duration(), 19),
('We Never Change', random_duration(), 19),
('Everything''s Not Lost', random_duration(), 19);

-- Disco 20 (A Rush of Blood to the Head - Coldplay) - 11 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Politik', random_duration(), 20),
('In My Place', random_duration(), 20),
('God Put a Smile upon Your Face', random_duration(), 20),
('The Scientist', random_duration(), 20),
('Clocks', random_duration(), 20),
('Daylight', random_duration(), 20),
('Green Eyes', random_duration(), 20),
('Warning Sign', random_duration(), 20),
('A Whisper', random_duration(), 20),
('A Rush of Blood to the Head', random_duration(), 20),
('Amsterdam', random_duration(), 20);

-- Disco 21 (The Wall - Pink Floyd) - 13 músicas (principais)
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('In the Flesh?', random_duration(), 21),
('The Thin Ice', random_duration(), 21),
('Another Brick in the Wall (Part 1)', random_duration(), 21),
('The Happiest Days of Our Lives', random_duration(), 21),
('Another Brick in the Wall (Part 2)', random_duration(), 21),
('Mother', random_duration(), 21),
('Goodbye Blue Sky', random_duration(), 21),
('Empty Spaces', random_duration(), 21),
('Young Lust', random_duration(), 21),
('One of My Turns', random_duration(), 21),
('Don''t Leave Me Now', random_duration(), 21),
('Comfortably Numb', random_duration(), 21),
('Run Like Hell', random_duration(), 21);

-- Disco 22 (Animals - Pink Floyd) - 5 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Pigs on the Wing (Part 1)', random_duration(), 22),
('Dogs', random_duration(), 22),
('Pigs (Three Different Ones)', random_duration(), 22),
('Sheep', random_duration(), 22),
('Pigs on the Wing (Part 2)', random_duration(), 22);

-- Disco 23 (Jazz - Queen) - 13 músicas (principais)
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Mustapha', random_duration(), 23),
('Fat Bottomed Girls', random_duration(), 23),
('Jealousy', random_duration(), 23),
('Bicycle Race', random_duration(), 23),
('If You Can''t Beat Them', random_duration(), 23),
('Let Me Entertain You', random_duration(), 23),
('Dead on Time', random_duration(), 23),
('In Only Seven Days', random_duration(), 23),
('Dreamers Ball', random_duration(), 23),
('Fun It', random_duration(), 23),
('Leaving Home Ain''t Easy', random_duration(), 23),
('Don''t Stop Me Now', random_duration(), 23),
('More of That Jazz', random_duration(), 23);

-- Disco 24 (The Game - Queen) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Play the Game', random_duration(), 24),
('Dragon Attack', random_duration(), 24),
('Another One Bites the Dust', random_duration(), 24),
('Need Your Loving Tonight', random_duration(), 24),
('Crazy Little Thing Called Love', random_duration(), 24),
('Rock It (Prime Jive)', random_duration(), 24),
('Don''t Try Suicide', random_duration(), 24),
('Sail Away Sweet Sister', random_duration(), 24),
('Coming Soon', random_duration(), 24),
('Save Me', random_duration(), 24);

-- Disco 25 (Californication - RHCP) - 15 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Around the World', random_duration(), 25),
('Parallel Universe', random_duration(), 25),
('Scar Tissue', random_duration(), 25),
('Otherside', random_duration(), 25),
('Get on Top', random_duration(), 25),
('Californication', random_duration(), 25),
('Easily', random_duration(), 25),
('Porcelain', random_duration(), 25),
('Emit Remmus', random_duration(), 25),
('I Like Dirt', random_duration(), 25),
('This Velvet Glove', random_duration(), 25),
('Savior', random_duration(), 25),
('Purple Stain', random_duration(), 25),
('Right on Time', random_duration(), 25),
('Road Trippin''', random_duration(), 25);

-- Disco 26 (By the Way - RHCP) - 16 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('By the Way', random_duration(), 26),
('Universally Speaking', random_duration(), 26),
('This Is the Place', random_duration(), 26),
('Dosed', random_duration(), 26),
('Don''t Forget Me', random_duration(), 26),
('The Zephyr Song', random_duration(), 26),
('Can''t Stop', random_duration(), 26),
('I Could Die for You', random_duration(), 26),
('Midnight', random_duration(), 26),
('Throw Away Your Television', random_duration(), 26),
('Cabron', random_duration(), 26),
('Tear', random_duration(), 26),
('On Mercury', random_duration(), 26),
('Minor Thing', random_duration(), 26),
('Warm Tape', random_duration(), 26),
('Venice Queen', random_duration(), 26);

-- Disco 27 (Sticky Fingers - Rolling Stones) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Brown Sugar', random_duration(), 27),
('Sway', random_duration(), 27),
('Wild Horses', random_duration(), 27),
('Can''t You Hear Me Knocking', random_duration(), 27),
('You Gotta Move', random_duration(), 27),
('Bitch', random_duration(), 27),
('I Got the Blues', random_duration(), 27),
('Sister Morphine', random_duration(), 27),
('Dead Flowers', random_duration(), 27),
('Moonlight Mile', random_duration(), 27);

-- Disco 28 (Exile on Main St. - Rolling Stones) - 18 músicas (principais)
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Rocks Off', random_duration(), 28),
('Rip This Joint', random_duration(), 28),
('Shake Your Hips', random_duration(), 28),
('Casino Boogie', random_duration(), 28),
('Tumbling Dice', random_duration(), 28),
('Sweet Virginia', random_duration(), 28),
('Torn and Frayed', random_duration(), 28),
('Sweet Black Angel', random_duration(), 28),
('Loving Cup', random_duration(), 28),
('Happy', random_duration(), 28),
('Turd on the Run', random_duration(), 28),
('Ventilator Blues', random_duration(), 28),
('I Just Want to See His Face', random_duration(), 28),
('Let It Loose', random_duration(), 28),
('All Down the Line', random_duration(), 28),
('Stop Breaking Down', random_duration(), 28),
('Shine a Light', random_duration(), 28),
('Soul Survivor', random_duration(), 28);

-- Disco 29 (The Joshua Tree - U2) - 11 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Where the Streets Have No Name', random_duration(), 29),
('I Still Haven''t Found What I''m Looking For', random_duration(), 29),
('With or Without You', random_duration(), 29),
('Bullet the Blue Sky', random_duration(), 29),
('Running to Stand Still', random_duration(), 29),
('Red Hill Mining Town', random_duration(), 29),
('In God''s Country', random_duration(), 29),
('Trip Through Your Wires', random_duration(), 29),
('One Tree Hill', random_duration(), 29),
('Exit', random_duration(), 29),
('Mothers of the Disappeared', random_duration(), 29);

-- Disco 30 (Achtung Baby - U2) - 12 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Zoo Station', random_duration(), 30),
('Even Better Than the Real Thing', random_duration(), 30),
('One', random_duration(), 30),
('Until the End of the World', random_duration(), 30),
('Who''s Gonna Ride Your Wild Horses', random_duration(), 30),
('So Cruel', random_duration(), 30),
('The Fly', random_duration(), 30),
('Mysterious Ways', random_duration(), 30),
('Tryin'' to Throw Your Arms Around the World', random_duration(), 30),
('Ultraviolet (Light My Way)', random_duration(), 30),
('Acrobat', random_duration(), 30),
('Love Is Blindness', random_duration(), 30);

-- Disco 31 (Nevermind - Nirvana) - 12 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Smells Like Teen Spirit', random_duration(), 31),
('In Bloom', random_duration(), 31),
('Come as You Are', random_duration(), 31),
('Breed', random_duration(), 31),
('Lithium', random_duration(), 31),
('Polly', random_duration(), 31),
('Territorial Pissings', random_duration(), 31),
('Drain You', random_duration(), 31),
('Lounge Act', random_duration(), 31),
('Stay Away', random_duration(), 31),
('On a Plain', random_duration(), 31),
('Something in the Way', random_duration(), 31);

-- Disco 32 (In Utero - Nirvana) - 12 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Serve the Servants', random_duration(), 32),
('Scentless Apprentice', random_duration(), 32),
('Heart-Shaped Box', random_duration(), 32),
('Rape Me', random_duration(), 32),
('Frances Farmer Will Have Her Revenge on Seattle', random_duration(), 32),
('Dumb', random_duration(), 32),
('Very Ape', random_duration(), 32),
('Milk It', random_duration(), 32),
('Pennyroyal Tea', random_duration(), 32),
('Radio Friendly Unit Shifter', random_duration(), 32),
('tourette''s', random_duration(), 32),
('All Apologies', random_duration(), 32);

-- Disco 33 (Discovery - Daft Punk) - 14 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('One More Time', random_duration(), 33),
('Aerodynamic', random_duration(), 33),
('Digital Love', random_duration(), 33),
('Harder, Better, Faster, Stronger', random_duration(), 33),
('Crescendolls', random_duration(), 33),
('Nightvision', random_duration(), 33),
('Superheroes', random_duration(), 33),
('High Life', random_duration(), 33),
('Something About Us', random_duration(), 33),
('Voyager', random_duration(), 33),
('Veridis Quo', random_duration(), 33),
('Short Circuit', random_duration(), 33),
('Face to Face', random_duration(), 33),
('Too Long', random_duration(), 33);

-- Disco 34 (Random Access Memories - Daft Punk) - 13 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Give Life Back to Music', random_duration(), 34),
('The Game of Love', random_duration(), 34),
('Giorgio by Moroder', random_duration(), 34),
('Within', random_duration(), 34),
('Instant Crush', random_duration(), 34),
('Lose Yourself to Dance', random_duration(), 34),
('Touch', random_duration(), 34),
('Get Lucky', random_duration(), 34),
('Beyond', random_duration(), 34),
('Motherboard', random_duration(), 34),
('Fragments of Time', random_duration(), 34),
('Doin'' It Right', random_duration(), 34),
('Contact', random_duration(), 34);

-- Disco 35 (Bridge over Troubled Water - Simon & Garfunkel) - 11 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Bridge over Troubled Water', random_duration(), 35),
('El Condor Pasa (If I Could)', random_duration(), 35),
('Cecilia', random_duration(), 35),
('Keep the Customer Satisfied', random_duration(), 35),
('So Long, Frank Lloyd Wright', random_duration(), 35),
('The Boxer', random_duration(), 35),
('Baby Driver', random_duration(), 35),
('The Only Living Boy in New York', random_duration(), 35),
('Why Don''t You Write Me', random_duration(), 35),
('Bye Bye Love', random_duration(), 35),
('Song for the Asking', random_duration(), 35);

-- Disco 36 (Bookends - Simon & Garfunkel) - 11 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Bookends Theme', random_duration(), 36),
('Save the Life of My Child', random_duration(), 36),
('America', random_duration(), 36),
('Overs', random_duration(), 36),
('Voices of Old People', random_duration(), 36),
('Old Friends', random_duration(), 36),
('Bookends Theme', random_duration(), 36),
('Fakin'' It', random_duration(), 36),
('Punky''s Dilemma', random_duration(), 36),
('Mrs. Robinson', random_duration(), 36),
('A Hazy Shade of Winter', random_duration(), 36);

-- Disco 37 (Elephant - The White Stripes) - 14 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Seven Nation Army', random_duration(), 37),
('Black Math', random_duration(), 37),
('There''s No Home for You Here', random_duration(), 37),
('I Just Don''t Know What to Do with Myself', random_duration(), 37),
('In the Cold, Cold Night', random_duration(), 37),
('I Want to Be the Boy to Warm Your Mother''s Heart', random_duration(), 37),
('You''ve Got Her in Your Pocket', random_duration(), 37),
('Ball and Biscuit', random_duration(), 37),
('The Hardest Button to Button', random_duration(), 37),
('Little Acorns', random_duration(), 37),
('Hypnotize', random_duration(), 37),
('The Air Near My Fingers', random_duration(), 37),
('Girl, You Have No Faith in Medicine', random_duration(), 37),
('Well It''s True That We Love One Another', random_duration(), 37);

-- Disco 38 (White Blood Cells - The White Stripes) - 16 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Dead Leaves and the Dirty Ground', random_duration(), 38),
('Hotel Yorba', random_duration(), 38),
('I''m Finding It Harder to Be a Gentleman', random_duration(), 38),
('Fell in Love with a Girl', random_duration(), 38),
('Expecting', random_duration(), 38),
('Little Room', random_duration(), 38),
('The Union Forever', random_duration(), 38),
('The Same Boy You''ve Always Known', random_duration(), 38),
('We''re Going to Be Friends', random_duration(), 38),
('Offend in Every Way', random_duration(), 38),
('I Think I Smell a Rat', random_duration(), 38),
('Aluminum', random_duration(), 38),
('I Can''t Wait', random_duration(), 38),
('Now Mary', random_duration(), 38),
('I Can Learn', random_duration(), 38),
('This Protector', random_duration(), 38);

-- Disco 39 (Actually - Pet Shop Boys) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('One More Chance', random_duration(), 39),
('What Have I Done to Deserve This?', random_duration(), 39),
('Shopping', random_duration(), 39),
('Rent', random_duration(), 39),
('Hit Music', random_duration(), 39),
('It Couldn''t Happen Here', random_duration(), 39),
('It''s a Sin', random_duration(), 39),
('I Want to Wake Up', random_duration(), 39),
('Heart', random_duration(), 39),
('King''s Cross', random_duration(), 39);

-- Disco 40 (Please - Pet Shop Boys) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Two Divided by Zero', random_duration(), 40),
('West End Girls', random_duration(), 40),
('Opportunities (Let''s Make Lots of Money)', random_duration(), 40),
('Love Comes Quickly', random_duration(), 40),
('Suburbia', random_duration(), 40),
('Tonight Is Forever', random_duration(), 40),
('Violence', random_duration(), 40),
('I Want a Lover', random_duration(), 40),
('Later Tonight', random_duration(), 40),
('Why Don''t We Live Together?', random_duration(), 40);

-- Disco 41 (Transa - Caetano Veloso) - 7 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('You Don''t Know Me', random_duration(), 41),
('Nine Out of Ten', random_duration(), 41),
('Triste Bahia', random_duration(), 41),
('It''s a Long Way', random_duration(), 41),
('Mora no Philosophy', random_duration(), 41),
('Neolithic Man', random_duration(), 41),
('Nostalgia', random_duration(), 41);

-- Disco 42 (Tropicália 2 - Caetano Veloso) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Haiti', random_duration(), 42),
('As Coisas', random_duration(), 42),
('Dengo', random_duration(), 42),
('Tradição', random_duration(), 42),
('As Camélias do Quilombo do Leblon', random_duration(), 42),
('Nossa Gente', random_duration(), 42),
('Caminhos Cruzados', random_duration(), 42),
('O Ciúme', random_duration(), 42),
('Tempo de Estio', random_duration(), 42),
('Dama de Vermelho', random_duration(), 42);

-- Disco 43 (Cores e Nomes - Roberto Carlos) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Caminhoneiro', random_duration(), 43),
('Amigo', random_duration(), 43),
('As Curvas da Estrada de Santos', random_duration(), 43),
('Detalhes', random_duration(), 43),
('Jesus Cristo', random_duration(), 43),
('O Calhambeque', random_duration(), 43),
('O Portão', random_duration(), 43),
('As Baleias', random_duration(), 43),
('Nossa Senhora', random_duration(), 43),
('Eu Te Amo, Te Amo, Te Amo', random_duration(), 43);

-- Disco 44 (Roberto Carlos - Roberto Carlos) - 12 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Splish Splash', random_duration(), 44),
('Pequeña', random_duration(), 44),
('Por Isso Corro Demais', random_duration(), 44),
('Parei na Contramão', random_duration(), 44),
('O Feio', random_duration(), 44),
('É Proibido Fumar', random_duration(), 44),
('Não É Papel pra Mim', random_duration(), 44),
('Só Você', random_duration(), 44),
('Splish Splash (Versão em Inglês)', random_duration(), 44),
('You Can Have Her', random_duration(), 44),
('What''d I Say', random_duration(), 44),
('Good Lovin''', random_duration(), 44);

-- Disco 45 (Elis & Tom) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Águas de Março', random_duration(), 45),
('Pois é', random_duration(), 45),
('Só tinha de ser com você', random_duration(), 45),
('Modinha', random_duration(), 45),
('Triste', random_duration(), 45),
('Corcovado', random_duration(), 45),
('O que tinha de ser', random_duration(), 45),
('Retrato em branco e preto', random_duration(), 45),
('Brigas, nunca mais', random_duration(), 45),
('Por toda a minha vida', random_duration(), 45);

-- Disco 46 (Falso Brilhante - Elis Regina) - 10 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Falso Brilhante', random_duration(), 46),
('O Que Foi Feito de Vera', random_duration(), 46),
('Como Nossos Pais', random_duration(), 46),
('Casa no Campo', random_duration(), 46),
('Atrás da Porta', random_duration(), 46),
('Querelas do Brasil', random_duration(), 46),
('Vento de Maio', random_duration(), 46),
('Saudosa Maloca', random_duration(), 46),
('Dois pra Lá, Dois pra Cá', random_duration(), 46),
('No Céu da Boca', random_duration(), 46);

-- Disco 47 (In the Wee Small Hours - Frank Sinatra) - 16 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('In the Wee Small Hours of the Morning', random_duration(), 47),
('Mood Indigo', random_duration(), 47),
('Glad to Be Unhappy', random_duration(), 47),
('I Get Along Without You Very Well', random_duration(), 47),
('Deep in a Dream', random_duration(), 47),
('I See Your Face Before Me', random_duration(), 47),
('Can''t We Be Friends?', random_duration(), 47),
('When Your Lover Has Gone', random_duration(), 47),
('What Is This Thing Called Love?', random_duration(), 47),
('Last Night When We Were Young', random_duration(), 47),
('I''ll Be Around', random_duration(), 47),
('Ill Wind', random_duration(), 47),
('It Never Entered My Mind', random_duration(), 47),
('Dancing on the Ceiling', random_duration(), 47),
('I''ll Never Be the Same', random_duration(), 47),
('This Love of Mine', random_duration(), 47);

-- Disco 48 (Come Fly with Me - Frank Sinatra) - 12 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Come Fly with Me', random_duration(), 48),
('Around the World', random_duration(), 48),
('Isle of Capri', random_duration(), 48),
('Moonlight in Vermont', random_duration(), 48),
('Autumn in New York', random_duration(), 48),
('On the Road to Mandalay', random_duration(), 48),
('Let''s Get Away from It All', random_duration(), 48),
('April in Paris', random_duration(), 48),
('London by Night', random_duration(), 48),
('Brazil', random_duration(), 48),
('Blue Hawaii', random_duration(), 48),
('It''s Nice to Go Trav''ling', random_duration(), 48);

-- Disco 49 (Back to Black - Amy Winehouse) - 11 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Rehab', random_duration(), 49),
('You Know I''m No Good', random_duration(), 49),
('Me & Mr Jones', random_duration(), 49),
('Just Friends', random_duration(), 49),
('Back to Black', random_duration(), 49),
('Love Is a Losing Game', random_duration(), 49),
('Tears Dry on Their Own', random_duration(), 49),
('Wake Up Alone', random_duration(), 49),
('Some Unholy War', random_duration(), 49),
('He Can Only Hold Her', random_duration(), 49),
('Addicted', random_duration(), 49);

-- Disco 50 (Frank) - 9 músicas
INSERT INTO Musica (nome, duracao, id_disco) VALUES
('Intro/Stronger Than Me', random_duration(), 50),
('You Sent Me Flying', random_duration(), 50),
('Fuck Me Pumps', random_duration(), 50),
('I Heard Love Is Blind', random_duration(), 50),
('Moody''s Mood for Love', random_duration(), 50),
('(There Is) No Greater Love', random_duration(), 50),
('In My Bed', random_duration(), 50),
('Take the Box', random_duration(), 50),
('October Song', random_duration(), 50);



-- Finaliza com os IDs de autoincremento atualizados
ALTER TABLE Gravadora AUTO_INCREMENT = 6;
ALTER TABLE Tipo_Artista AUTO_INCREMENT = 5;
ALTER TABLE Genero AUTO_INCREMENT = 11;
ALTER TABLE Artista AUTO_INCREMENT = 31;
ALTER TABLE Disco AUTO_INCREMENT = 51;
ALTER TABLE Musica AUTO_INCREMENT = 351; -- Considerando que inserimos até a música 350



SHOW TABLES;
