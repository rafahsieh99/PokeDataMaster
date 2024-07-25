-- Consultas para la creacion de tablas

BEGIN;

CREATE TABLE IF NOT EXISTS public.batallas
(
    id serial NOT NULL,
    fecha date NOT NULL,
    entrenador_1 integer NOT NULL,
    entrenador_2 integer NOT NULL,
    pokemon_1 integer NOT NULL,
    pokemon_2 integer NOT NULL,
    resultado character(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT batallas_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.entrenadores
(
    id serial NOT NULL,
    nombre character(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT entrenadores_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.entrenadores_pokemones
(
    id serial NOT NULL,
    entrenador_id integer NOT NULL,
    pokemon_id integer NOT NULL,
    CONSTRAINT entrenadores_pokemones_pkey PRIMARY KEY (id),
    CONSTRAINT entrenadores_pokemones_entrenador_id_pokemon_id_key UNIQUE (entrenador_id, pokemon_id)
);

CREATE TABLE IF NOT EXISTS public.pokemones
(
    id serial NOT NULL,
    numero integer NOT NULL,
    nombre character(50) COLLATE pg_catalog."default" NOT NULL,
    tipo character(50) COLLATE pg_catalog."default" NOT NULL,
    movimiento character(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pokemones_pkey PRIMARY KEY (id)
);

-- Consultas para poder hacer la operacion multitablas

ALTER TABLE IF EXISTS public.batallas
    ADD CONSTRAINT batallas_entrenador_1_fkey FOREIGN KEY (entrenador_1)
    REFERENCES public.entrenadores (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.batallas
    ADD CONSTRAINT batallas_entrenador_2_fkey FOREIGN KEY (entrenador_2)
    REFERENCES public.entrenadores (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.batallas
    ADD CONSTRAINT batallas_pokemon_1_fkey FOREIGN KEY (pokemon_1)
    REFERENCES public.pokemones (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.batallas
    ADD CONSTRAINT batallas_pokemon_2_fkey FOREIGN KEY (pokemon_2)
    REFERENCES public.pokemones (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.entrenadores_pokemones
    ADD CONSTRAINT entrenadores_pokemones_entrenador_id_fkey FOREIGN KEY (pokemon_id)
    REFERENCES public.pokemones (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.entrenadores_pokemones
    ADD FOREIGN KEY (entrenador_id)
    REFERENCES public.entrenadores (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;

-- Tabla Entrenadores
INSERT INTO public.entrenadores(
	id, nombre)
	VALUES (?, ?);

UPDATE public.entrenadores
	SET id=?, nombre=?
	WHERE <condition>;

DELETE FROM public.entrenadores
	WHERE <condition>;

-- Tabla Pokemones
SELECT *
FROM pokemones
WHERE id = 455;  -- Cambia 455 por el ID del Pokémon que deseas consultar

-- Tabla Relacion entrenadores_pokemones
INSERT INTO public.entrenadores_pokemones(
	id, entrenador_id, pokemon_id)
	VALUES (?, ?, ?);

UPDATE public.entrenadores_pokemones
	SET id=?, entrenador_id=?, pokemon_id=?
	WHERE <condition>;

DELETE FROM public.entrenadores_pokemones
	WHERE <condition>;

-- Leer
SELECT e.id AS entrenador_id, e.nombre AS entrenador_nombre, p.id AS pokemon_id, p.nombre AS pokemon_nombre
FROM entrenadores e
JOIN entrenadores_pokemones ep ON e.id = ep.entrenador_id
JOIN pokemones p ON ep.pokemon_id = p.id;

-- Tabla de batallas
INSERT INTO public.batallas(
	id, fecha, entrenador_1, entrenador_2, pokemon_1, pokemon_2, resultado)
	VALUES (?, ?, ?, ?, ?, ?, ?);

UPDATE public.batallas
	SET id=?, fecha=?, entrenador_1=?, entrenador_2=?, pokemon_1=?, pokemon_2=?, resultado=?
	WHERE <condition>;

-- Leer
SELECT 
    b.id AS batalla_id,
    e1.nombre AS entrenador1,
    e2.nombre AS entrenador2,
    b.resultado
FROM 
    batallas b
JOIN 
    entrenadores e1 ON b.entrenador_1 = e1.id
JOIN 
    entrenadores e2 ON b.entrenador_2= e2.id;

