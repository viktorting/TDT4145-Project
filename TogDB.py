import sqlite3

# SQLite3 Dokumentasjon:
# https://docs.python.org/3/library/sqlite3.html

print('Connecting to database...')
database = sqlite3.connect('TogDB.db')

cursor = database.cursor()

"""
c) For en stasjon som oppgis, skal bruker få ut alle togruter som er innom stasjonen en gitt ukedag.
"""
# Param: station (string), day (string)
def get_all_routes(station, day):
    cursor.execute(f"""
        SELECT TogruteTabell.RuteID
        FROM TogruteKjørerDag
            NATURAL JOIN TogruteTabell
            NATURAL JOIN StasjonITabell
        WHERE TogruteKjørerDag.Dag = '{day}' AND StasjonITabell.Stasjonsnavn = '{station}'
    """)
    
    return cursor.fetchall()


"""
d) Bruker skal kunne søke etter togruter som går mellom en startstasjon og en sluttstasjon, 
med utgangspunkt i en dato og et klokkeslett. 
Alle ruter den samme dagen og den neste skal returneres, sortert på tid.
"""
# Param: station (string), day (string)
def get_all_routes_between(start, end, day):
    cursor.execute(f"""
        SELECT TogRuteTabell.RuteID, StasjonITabell.Stasjonsnavn, TogruteKjørerDag.Dag, StasjonITabell.Tid
        FROM TogRuteTabell
	        NATURAL JOIN StasjonITabell
	        NATURAL JOIN TogruteKjørerDag
        WHERE 
	        Dag = {day} AND
	        (Stasjonsnavn = {start} OR Stasjonsnavn = {end})
        ORDER BY Tid
    """)
    
    return cursor.fetchall()


""" Funker i SQL men IKKE Python, møkk.
SELECT TogRuteTabell.RuteID, StasjonITabell.Stasjonsnavn, TogruteKjørerDag.Dag, StasjonITabell.Tid
FROM TogRuteTabell
	NATURAL JOIN StasjonITabell
	NATURAL JOIN TogruteKjørerDag
WHERE 
	Dag = "Mandag" AND
	(Stasjonsnavn = "Trondheim" OR Stasjonsnavn = "Bodø")
	
ORDER BY Tid
 """



"""
e) En bruker skal kunne registrere seg i kunderegisteret
"""

"""
g) Registrerte kunder skal kunne finne ledige billetter for en oppgitt strekning på en ønsket togrute
og kjøpe de billettene hen ønsker. (Husk å kun slege ledige plasser)
"""

# h) For en bruker skal man kunne finne all informasjon om de kjøpene hen har gjort for fremtidige reiser


# an empty input will quit the while loop
while(action := input('''Actions: 
    Fetch - Get all routes stopping at a chosen station on said day. Format example: Trondheim Mandag   
    Between - 

    Press 'Enter' to quit...
    
    Select action: ''')):

    if (action == 'Fetch'):
        tmp = input('Station + Day (Seperate by space): ').split(' ')
        print(get_all_routes(tmp[0], tmp[1]))
    if (action == "Between"):
        tmp = input('Start Station + End Station + Day: ').split(' ')
        print(get_all_routes_between(tmp[0], tmp[1], tmp[2]))


print('Closing database...')
database.close()