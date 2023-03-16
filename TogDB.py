import sqlite3

# SQLite3 Dokumentasjon:
# https://docs.python.org/3/library/sqlite3.html

print('Connecting to database...')
database = sqlite3.connect('TogDB.db')

cursor = database.cursor()

# var = input()
# cursor.execute("SELECT * FROM table WHERE attribute = ?", (var))

# cursor.fetchone()
# cursor.fetchall()
# cursor.fetchmany(n)


while(var := input('Input: ')):

    # an empty input will quit the while loop
    print(f'Loop running... Your input: {var}')


print('Closing database...')
database.close()

# cursor.execute('''CREATE TABLE person
# (id INTEGER PRIMARY KEY, name TEXT, birthday TEXT)''')
# cursor.execute('''INSERT INTO person VALUES (1, 'Ola Nordmann', '2002-02-02')''')
# database.commit()
# databse.close()
