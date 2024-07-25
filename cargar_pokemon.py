import requests
import psycopg2

conn = psycopg2.connect(
        dbname='Pokemon',
        user='postgres',
        password='123456',
        host='localhost'
)
cursor = conn.cursor()

def insert_pokemon(numero_pokemon):
    api_url = f"https://pokeapi.co/api/v2/pokemon/{numero_pokemon}"  # Corrige la definición de la URL
    response = requests.get(api_url)
    if response.status_code == 200:
        data = response.json()
        pokemon_name = data.get("name")
        pokemon_number = data.get('id')
        # Verifica si 'types' y 'moves' existen antes de acceder a ellos
        pokemon_type = data['types'][0]['type']['name'] if data.get('types') else None
        pokemon_move = data['moves'][0]['move']['name'] if data.get('moves') else None

        cursor.execute("""
                    INSERT INTO pokemones (numero, nombre, tipo, movimiento)
                    VALUES (%s, %s, %s, %s)
        """ , (pokemon_number, pokemon_name, pokemon_type, pokemon_move))
        conn.commit()

        # Imprime los datos obtenidos
        print(f"Name: {pokemon_name}")
        print(f"Number: {pokemon_number}")
        print(f"Type: {pokemon_type}")
        print(f"Move: {pokemon_move}")
    else:
        print(f"Failed to retrieve data: {response.status_code}")


for i in range (152):
    insert_pokemon(i)
        
        
        
cursor.close()
conn.close()
