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
        SELECT  *
        FROM TogRuteTabell
	        NATURAL JOIN StasjonITabell as Start
	        CROSS JOIN StasjonITabell as EndStation
	        NATURAL JOIN TogruteKjørerDag
	
        WHERE Dag = "Mandag"
	        AND (Start.Stasjonsnavn = "Steinkjer" AND EndStation.Stasjonsnavn ="Mosjøen")
	        AND (Start.TabellID = EndStation.TabellID)
	        AND (Start.Tid < EndStation.Tid) -- Fungerer ikke når toget går før midatt over natten

        ORDER BY Start.Tid
    """)
    
    return cursor.fetchall()


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
    Fetch - Get all routes stopping at a chosen station on said day.   
    Between - Get all routes running between two chosen station on a said day.

    Press 'Enter' to quit...
    
    Select action: ''')):

    if (action == 'Fetch'):  # fix return formatting
        print(get_all_routes(input('Station: '), 
                            input('Day: ')))
    if (action == "Between"):
        print(get_all_routes_between(input('Start Station: '), 
                                     input('End Station: '), 
                                     input('Day: ')))


print('Closing database...')
database.close()