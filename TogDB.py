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

""" 
cursor.execute('''CREATE TABLE person
(id INTEGER PRIMARY KEY, name TEXT, birthday TEXT)''')
cursor.execute('''INSERT INTO person VALUES (1, 'Ola Nordmann', '2002-02-02')''')
database.commit()
databse.close()
"""

""" 
Oppgaver:

c) For en stasjon som oppgis, skal bruker få ut alle togruter som er innom stasjonen en gitt ukedag. 


d) Bruker skal kunne søke etter togruter som går mellom en startstasjon og en sluttstasjon, med
utgangspunkt i en dato og et klokkeslett. Alle ruter den samme dagen og den neste skal
returneres, sortert på tid.


e) En bruker skal kunne registrere seg i kunderegisteret


g) Registrerte kunder skal kunne finne ledige billetter for en oppgitt strekning på en ønsket togrute
og kjøpe de billettene hen ønsker. (Husk å kun slege ledige plasser)


h) For en bruker skal man kunne finne all informasjon om de kjøpene hen har gjort for fremtidige
reiser

"""