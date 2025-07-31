-- Creazione utente se non esiste
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles WHERE rolname = 'franc') THEN
      CREATE ROLE franc LOGIN PASSWORD 'password';
   END IF;
END
$do$;

-- Concedi permessi sul database (esistente)
GRANT ALL PRIVILEGES ON DATABASE example TO franc;

-- Crea tabella 'guests' solo se non esiste
CREATE TABLE IF NOT EXISTS guests (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(200) NOT NULL,
  lastname VARCHAR(200) NOT NULL
);

-- Inserisci dati di prova solo se la tabella è vuota
INSERT INTO guests (firstname, lastname)
SELECT 'Mario', 'Rossi'
WHERE NOT EXISTS (SELECT 1 FROM guests);

INSERT INTO guests (firstname, lastname)
SELECT 'Piero', 'Verdi'
WHERE NOT EXISTS (SELECT 1 FROM guests);
