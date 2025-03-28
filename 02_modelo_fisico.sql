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



-- [...] (inserir músicas para os demais discos seguindo o mesmo padrão)

-- Finaliza com os IDs de autoincremento atualizados
ALTER TABLE Gravadora AUTO_INCREMENT = 6;
ALTER TABLE Tipo_Artista AUTO_INCREMENT = 5;
ALTER TABLE Genero AUTO_INCREMENT = 11;
ALTER TABLE Artista AUTO_INCREMENT = 31;
ALTER TABLE Disco AUTO_INCREMENT = 51;
ALTER TABLE Musica AUTO_INCREMENT = 351; -- Considerando que inserimos até a música 350



SHOW TABLES;
