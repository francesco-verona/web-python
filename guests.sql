DROP TABLE IF EXISTS guests;

-- Crea tabella
CREATE TABLE guests (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(200) NOT NULL,
  lastname VARCHAR(200) NOT NULL
);

-- Inserisci dati
INSERT INTO guests (firstname, lastname) VALUES
('mario', 'rossi'),
('piero', 'verdi');