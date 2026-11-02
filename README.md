# DCT2201 — Banco de Dados

Repositório pessoal de Jefferson Willame ([JefWill](https://github.com/JefWill)) para as atividades práticas da disciplina de Banco de Dados — CERES/UFRN.

## Tarefa 03 — Docker Compose, MariaDB e Administração de SGBD

Os arquivos estão em [`tarefa03/`](tarefa03/):

| Arquivo ou pasta | Finalidade |
|---|---|
| [`docker-compose.yml`](tarefa03/docker-compose.yml) | Ambiente original com MariaDB 11, CloudBeaver e volume persistente. |
| [`.env.example`](tarefa03/.env.example) | Modelo público das variáveis de ambiente. |
| [`.gitignore`](.gitignore) | Impede versionar os arquivos `.env` locais em qualquer pasta. |
| [`povoamento.sql`](tarefa03/povoamento.sql) | Acrescenta 10 autores e 30 livros à carga inicial do roteiro. Executar uma vez em `biblioteca`, após os 4 autores e 5 livros iniciais. |
| [`setup.sql`](tarefa03/setup.sql) | Apaga e recria a base completa e os usuários didáticos; reproduz o estado final dos desafios. Testado duas vezes em ambiente isolado. |
| [`consultas.sql`](tarefa03/consultas.sql) | As seis consultas obrigatórias da seção 10. |
| [`desafios.sql`](tarefa03/desafios.sql) | Comandos dos desafios 6 a 14, separados por conta; executar por blocos, observando os erros esperados. |
| [`ambiente1/`](tarefa03/ambiente1/) | Projeto independente dos desafios: portas 3307 e 8979. |
| [`ambiente2/`](tarefa03/ambiente2/) | Segundo projeto independente: portas 3308 e 8980, usado para testar senha persistida e recriação. |

Os desafios foram validados em 02/11/2026 em cópias isoladas. O ambiente original não foi modificado. Os contêineres de teste foram removidos ao final, mantendo os volumes. O estado final reconstruído por `setup.sql` possui 14 autores, 35 livros e 3 empréstimos; o livro 1 tem preço 43,89.

### Preparar o ambiente original

No CMD, dentro de `tarefa03`:

```cmd
copy .env.example .env
notepad .env
git check-ignore -v .env
docker compose config --quiet
docker compose up -d
docker compose ps
```

Se o `.env` já existir, preserve-o em vez de sobrescrevê-lo. Defina uma senha própria antes da primeira inicialização. O CloudBeaver original está em `http://localhost:8978`; a conexão interna usa host `mariadb` e porta `3306`. A porta do Windows é definida por `MARIADB_PORT`. As senhas não devem constar no relatório nem em capturas de tela.

### Inicializar o banco com setup.sql

**O script remove o banco `biblioteca` e todos os seus dados.** Use-o somente para reconstruir um laboratório descartável. Não o execute sobre dados que deseja manter.

Depois de iniciar o ambiente escolhido, copie o script para o serviço e abra o cliente:

```cmd
docker compose cp setup.sql mariadb:/tmp/setup.sql
docker compose exec mariadb mariadb -uroot -p
```

No cliente MariaDB, execute:

```sql
SOURCE /tmp/setup.sql;
```

Esse script já inclui a carga de `povoamento.sql`. Não execute novamente o povoamento depois dele. As senhas das contas `app_biblioteca`, `consulta` e `relatorios` no script são exemplos didáticos do roteiro; a senha local de root fica apenas no `.env`.

### Dois ambientes independentes

Em cada pasta `ambiente1` e `ambiente2`, copie o `.env.example` para `.env`, defina uma senha própria e execute `docker compose up -d`. Os projetos usam nomes, portas, redes e volumes diferentes. Os portais são `http://localhost:8979` e `http://localhost:8980`; dentro de cada rede, a conexão do CloudBeaver continua em `mariadb:3306`.

`docker compose down` remove os contêineres e mantém o volume. `docker compose down -v` também apaga os dados daquele projeto.

## Entrega

O relatório fica exclusivamente em `database/20262/JefWill/tarefa03.md` no fork [JefWill/bsi-tasks](https://github.com/JefWill/bsi-tasks). O PR para a disciplina deve conter apenas esse Markdown. No SIGAA, devem ser informados o link do PR e o link deste repositório pessoal.

Roteiro oficial: [Tarefa 03](https://github.com/tacianosilva/bsi-tasks/blob/main/database/tarefas/tarefa-docker-sgbd.md).
