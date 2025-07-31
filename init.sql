DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
-- Le seguenti istruzioni vanno eseguite dopo aver selezionato il database
-- Puoi usare psql per connetterti al database appena creato:
-- psql -U postgres -d example

-- Crea utente
DROP ROLE IF EXISTS franc;
CREATE USER franc WITH PASSWORD 'password';

-- Concedi permessi
GRANT ALL PRIVILEGES ON DATABASE example TO franc;


