-- Execute por blocos nas contas indicadas; não execute o arquivo inteiro como root.
-- Bloco B: conectado como root em biblioteca; aplicar uma vez.
USE biblioteca;
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

-- Desafio 8
SELECT l.titulo, e.data_emprestimo, a.nome AS autor
FROM emprestimos e
JOIN livros l ON l.id = e.livro_id
JOIN autores a ON a.id = l.autor_id
WHERE e.devolvido = FALSE;

-- Desafio 9
SELECT a.nome AS autor, COUNT(*) AS total_obras
FROM autores a JOIN livros l ON l.autor_id = a.id
GROUP BY a.id, a.nome HAVING COUNT(*) > 1;

-- Desafio 10: aplicar uma vez para não acumular reajustes.
UPDATE livros SET preco = ROUND(preco * 1.10, 2) WHERE id = 1;
SELECT id, titulo, preco FROM livros WHERE id = 1;

-- Desafio 11
INSERT INTO autores (nome, pais, ano_nascimento)
VALUES ('Autor temporário do desafio', 'Brasil', 2000);
SET @autor_temporario = LAST_INSERT_ID();
DELETE FROM autores WHERE id = @autor_temporario;

-- Desafio 12: root
CREATE USER 'relatorios'@'%' IDENTIFIED BY 'Relatorios2026!';
GRANT SELECT ON biblioteca.livros TO 'relatorios'@'%';

-- Desafio 13: executar como relatorios; erro 1142 esperado.
SELECT * FROM biblioteca.autores;

-- Desafio 14: root
GRANT INSERT ON biblioteca.livros TO 'relatorios'@'%';
-- Trocar para relatorios:
INSERT INTO biblioteca.livros (titulo, ano_publicacao, preco, autor_id)
VALUES ('Livro de teste de privilégio', 2026, 10.00, 1);
-- Trocar para root:
REVOKE INSERT ON biblioteca.livros FROM 'relatorios'@'%';
-- Trocar para relatorios; erro 1142 esperado:
INSERT INTO biblioteca.livros (titulo, ano_publicacao, preco, autor_id)
VALUES ('Inserção após revogação', 2026, 10.00, 1);
-- Root: limpeza somente do registro de teste criado acima.
DELETE FROM biblioteca.livros WHERE titulo = 'Livro de teste de privilégio' AND ano_publicacao = 2026;
