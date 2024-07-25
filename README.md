# PokeDataMaster
# Proyecto de Gestión de Entrenadores y Pokémon

Este proyecto tiene como objetivo gestionar la información de entrenadores, Pokémon y batallas utilizando una base de datos PostgreSQL. El proyecto incluye cuatro tablas y utiliza una API para cargar datos de Pokémon.

## Tablas

### 1. entrenadores
Tabla que almacena la información de los entrenadores.

| Columna     | Tipo    | Descripción                  |
|-------------|---------|------------------------------|
| id          | SERIAL  | Clave primaria               |
| nombre      | TEXT    | Nombre del entrenador        |

### 2. pokemones
Tabla que almacena la información de los Pokémon.

| Columna     | Tipo    | Descripción                  |
|-------------|---------|------------------------------|
| id          | SERIAL  | Clave primaria               |
| numero      | INTEGER | Numero del Pokemon           |
| nombre      | TEXT    | Nombre del Pokémon           |
| tipo        | TEXT    | Tipo del Pokémon             |
|movimiento   | TEXT    | Movimiento del Pokémon        |

### 3. entrenadores_pokemones
Tabla intermedia que almacena la relación muchos a muchos entre entrenadores y Pokémon.

| Columna         | Tipo    | Descripción                              |
|-----------------|---------|------------------------------------------|
| entrenador_id   | INTEGER | Clave foránea referenciando a `entrenadores(id)` |
| pokemon_id      | INTEGER | Clave foránea referenciando a `pokemones(id)`    |

### 4. batallas
Tabla que almacena la información de las batallas entre entrenadores.

| Columna         | Tipo    | Descripción                              |
|-----------------|---------|------------------------------------------|
| id              | SERIAL  | Clave primaria                           |
| entrenador1_id  | INTEGER | Clave foránea referenciando a `entrenadores(id)` |
| entrenador2_id  | INTEGER | Clave foránea referenciando a `entrenadores(id)` |
| resultado       | TEXT    | Resultado de la batalla (ganador)        |
| fecha           | DATE    | Fecha de la batalla (ganador)        |

## Relaciones

- `entrenadores_pokemones`: Tabla intermedia que establece una relación muchos a muchos entre `entrenadores` y `pokemones`.
- `batallas`: Tabla que relaciona a dos entrenadores (entrenador1 y entrenador2) en una batalla.

## Cargar Datos de Pokémon

Los datos de los Pokémon se cargan desde una API externa utilizando un script Python `cargar_pokemon.py`. Este script obtiene los datos de la API y los inserta en la tabla `pokemones`.

### Script `cargar_pokemon.py`

El script `cargar_pokemon.py` contiene el código para obtener datos de la API de Pokémon y cargarlos en la tabla `pokemones`. Aquí un resumen de cómo funciona:

1. **Conexión a la API**: El script realiza una solicitud a la API de Pokémon para obtener la lista de Pokémon y sus detalles.
2. **Procesamiento de Datos**: Los datos obtenidos se procesan para extraer la información relevante (nombre, tipo, habilidad, etc.).
3. **Inserción en la Base de Datos**: Los datos procesados se insertan en la tabla `pokemones` de la base de datos PostgreSQL.

### Ejemplo de Uso

Para cargar los datos de Pokémon, simplemente ejecuta el script `cargar_pokemon.py`:

```sh
python cargar_pokemon.py
