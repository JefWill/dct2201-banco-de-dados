-- ATENÇÃO: este script apaga e recria biblioteca e seus dados.
-- Execute como root somente em um banco de laboratório.
-- As senhas dos usuários abaixo são exemplos didáticos do roteiro.
-- A senha de root é definida localmente no .env e não consta neste arquivo.
SET NAMES utf8mb4;
DROP DATABASE IF EXISTS biblioteca;
DROP USER IF EXISTS 'app_biblioteca'@'%';
DROP USER IF EXISTS 'consulta'@'%';
DROP USER IF EXISTS 'relatorios'@'%';

CREATE DATABASE IF NOT EXISTS biblioteca
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE biblioteca;

CREATE TABLE IF NOT EXISTS autores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  pais VARCHAR(50),
  ano_nascimento INT
);

CREATE TABLE IF NOT EXISTS livros (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  ano_publicacao INT,
  preco DECIMAL(10,2),
  autor_id INT,
  FOREIGN KEY (autor_id) REFERENCES autores(id)
);

CREATE USER 'app_biblioteca'@'%' IDENTIFIED BY 'AppBib2026!';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.* TO 'app_biblioteca'@'%';

CREATE USER 'consulta'@'%' IDENTIFIED BY 'Consulta2026!';
GRANT SELECT ON biblioteca.* TO 'consulta'@'%';

FLUSH PRIVILEGES;

USE biblioteca;

INSERT INTO autores (nome, pais, ano_nascimento) VALUES
('Machado de Assis', 'Brasil', 1839),
('Clarice Lispector', 'Brasil', 1920),
('Gabriel García Márquez', 'Colômbia', 1927),
('Jane Austen', 'Inglaterra', 1775);

INSERT INTO livros (titulo, ano_publicacao, preco, autor_id) VALUES
('Dom Casmurro', 1899, 39.90, 1),
('Memórias Póstumas de Brás Cubas', 1881, 45.00, 1),
('A Hora da Estrela', 1977, 32.50, 2),
('Cem Anos de Solidão', 1967, 59.90, 3),
('Orgulho e Preconceito', 1813, 29.90, 4);

INSERT INTO autores (id, nome, pais, ano_nascimento) VALUES
(5, 'José de Alencar', 'Brasil', 1829),
(6, 'Mary Shelley', 'Inglaterra', 1797),
(7, 'Fiódor Dostoiévski', 'Rússia', 1821),
(8, 'Eça de Queirós', 'Portugal', 1845),
(9, 'Franz Kafka', 'Áustria-Hungria', 1883),
(10, 'Virginia Woolf', 'Inglaterra', 1882),
(11, 'George Orwell', 'Índia Britânica', 1903),
(12, 'Jorge Luis Borges', 'Argentina', 1899),
(13, 'Chinua Achebe', 'Nigéria', 1930),
(14, 'Chimamanda Ngozi Adichie', 'Nigéria', 1977);

INSERT INTO livros (titulo, ano_publicacao, preco, autor_id) VALUES
('Quincas Borba', 1891, 34.90, 1),
('Esaú e Jacó', 1904, 32.90, 1),
('Perto do Coração Selvagem', 1943, 49.90, 2),
('Laços de Família', 1960, 44.90, 2),
('O Amor nos Tempos do Cólera', 1985, 59.90, 3),
('Crônica de uma Morte Anunciada', 1981, 42.90, 3),
('Razão e Sensibilidade', 1811, 39.90, 4),
('Emma', 1815, 44.90, 4),
('Iracema', 1865, 24.90, 5),
('O Guarani', 1857, 29.90, 5),
('Senhora', 1875, 32.90, 5),
('Frankenstein', 1818, 39.90, 6),
('O Último Homem', 1826, 54.90, 6),
('Crime e Castigo', 1866, 69.90, 7),
('Os Irmãos Karamázov', 1880, 89.90, 7),
('O Primo Basílio', 1878, 39.90, 8),
('Os Maias', 1888, 54.90, 8),
('A Metamorfose', 1915, 29.90, 9),
('Na Colônia Penal', 1919, 24.90, 9),
('Mrs. Dalloway', 1925, 44.90, 10),
('Orlando', 1928, 49.90, 10),
('A Revolução dos Bichos', 1945, 29.90, 11),
('1984', 1949, 39.90, 11),
('Ficções', 1944, 54.90, 12),
('O Aleph', 1949, 49.90, 12),
('O Mundo se Despedaça', 1958, 49.90, 13),
('A Flecha de Deus', 1964, 54.90, 13),
('Hibisco Roxo', 2003, 49.90, 14),
('Meio Sol Amarelo', 2006, 59.90, 14),
('Americanah', 2013, 64.90, 14);

CREATE TABLE IF NOT EXISTS emprestimos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  livro_id INT,
  data_emprestimo DATE,
  devolvido BOOLEAN,
  FOREIGN KEY (livro_id) REFERENCES livros(id)
);

INSERT INTO emprestimos (livro_id, data_emprestimo, devolvido) VALUES
(1, '2026-11-01', FALSE),
(2, '2026-11-02', FALSE),
(3, '2026-10-30', TRUE);

-- Estado final dos desafios: reajuste do livro 1 e conta de relatórios somente leitura.
UPDATE livros SET preco = ROUND(preco * 1.10, 2) WHERE id = 1;
CREATE USER 'relatorios'@'%' IDENTIFIED BY 'Relatorios2026!';
GRANT SELECT ON biblioteca.livros TO 'relatorios'@'%';
