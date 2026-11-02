USE biblioteca;

SELECT * FROM livros;


SELECT titulo, ano_publicacao
FROM livros
ORDER BY ano_publicacao DESC;


SELECT *
FROM livros
WHERE ano_publicacao < 1900;


SELECT l.titulo, a.nome AS autor, l.preco
FROM livros l
JOIN autores a ON l.autor_id = a.id;


SELECT a.nome AS autor, AVG(l.preco) AS preco_medio
FROM autores a
JOIN livros l ON a.id = l.autor_id
GROUP BY a.id, a.nome;


SELECT *
FROM livros
WHERE preco > (SELECT AVG(preco) FROM livros);
