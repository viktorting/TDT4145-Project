import sqlite3
import datetime
import random

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
weekdays = {1 : 'Mandag', 
            2 : 'Tirsdag', 
            3 : 'Onsdag', 
            4 : 'Torsdag', 
            5 : 'Fredag', 
            6 : 'Lørdag', 
            7 : 'Søndag'
        }

def get_all_routes_between(start, end, date):
    year, month, day = map(int, date.split('-'))
    date = int(datetime.date(year, month, day).strftime("%u"))

    output = []

    for i in range(2):  # Return for selected day and day after
        cursor.execute(f"""
            SELECT TogRuteTabell.RuteID, Start.Stasjonsnavn, Start.Tid, EndStation.Stasjonsnavn, EndStation.Tid, TogruteKjørerDag.Dag 
            FROM TogRuteTabell
	            NATURAL JOIN StasjonITabell as Start
	            CROSS JOIN StasjonITabell as EndStation
	            NATURAL JOIN TogruteKjørerDag
	
            WHERE Dag = "{weekdays[date + i]}"
	            AND (Start.Stasjonsnavn = "{start}" AND EndStation.Stasjonsnavn = "{end}")
	            AND (Start.TabellID = EndStation.TabellID)
	            AND ((Start.Tid < EndStation.Tid) OR Start.Tid > "23:00") -- Fungerer ikke når toget går før midatt over natten

            ORDER BY Start.Tid
        """)
        output.append(cursor.fetchall())
    return output

"""
e) En bruker skal kunne registrere seg i kunderegisteret
"""

def register_customer(email, firstname, lastname, phone):
    try:
        cursor.execute(f"""
                INSERT INTO Kunde
                VALUES ("{email}", "{firstname}", "{lastname}", "{phone}")
            """)
        database.commit()
        return 'Kunde registrert! ' + str(get_customer(email))
    except Exception as e:
        return 'Kunde ikke registrert! Feilmelding: ' + str(e)

"""
g) Registrerte kunder skal kunne finne ledige billetter for en oppgitt strekning på en ønsket togrute
og kjøpe de billettene hen ønsker. (Husk å kun slege ledige plasser)
"""
def get_stations_between(start, end, route):
    return f"""
        SELECT Stasjonsnavn
        FROM StasjonITabell NATURAL JOIN TogRuteTabell
        WHERE RuteID = {route}
            AND tid > (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "{start}")
            AND tid < (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "{end}")
    """

def get_available_seats(start, stop, route):

    cursor.execute(get_stations_between(start, stop, route))
    stations = cursor.fetchall()

    unavailable_trips = []

    for station in stations:
        cursor.execute(f'''
            SELECT Dato, RuteID, VognType, SitteplassID, BillettID, StartStasjon, EndeStasjon
            FROM TogRuteForekomst
                NATURAL JOIN Vognoppsett
                NATURAL JOIN SattSammenAv
                NATURAL JOIN Vogn
                NATURAL JOIN Sitteplass
                NATURAL JOIN SitteplassPåBillett
                NATURAL JOIN Billett
            WHERE ForekomstID = {route}
                AND RuteID = {route}
                AND StartStasjon = "{start}"
                AND EndeStasjon = "{station}"
                AND EXISTS (SELECT SitteplassID 
                    FROM SitteplassPåBillett 
                    WHERE SitteplassPåBillett.SitteplassID = Sitteplass.SitteplassID
                )
        ''')
        unavailable_trips.append(cursor.fetchall())
    
    print(unavailable_trips)

    '''
    cursor.execute(f"""
        SELECT ForekomstID, Dato, SitteplassID
FROM TogRuteForekomst
	NATURAL JOIN SattSammenAv
	NATURAL JOIN Sitteplass
WHERE ForekomstID = 1
	AND ForekomstID = OppsettID

EXCEPT

SELECT ForekomstID, Dato, SitteplassID
FROM TogRuteForekomst
	NATURAL JOIN Vognoppsett
	NATURAL JOIN SattSammenAv
	NATURAL JOIN Vogn
	NATURAL JOIN Sitteplass
	NATURAL JOIN SitteplassPåBillett
	NATURAL JOIN Billett
WHERE ForekomstID = 1
	AND RuteID = 1
    AND EXISTS (SELECT SitteplassID 
		FROM SitteplassPåBillett
		WHERE SitteplassPåBillett.SitteplassID = Sitteplass.SitteplassID
            AND Billett.StartStasjon <> {get_stations_between(start, stop, route)}
            AND Billett.StartStasjon <> {start}
            AND Billett.EndeStasjon <> {get_stations_between(start, stop, route)}
            AND Billett.EndeStasjon <> {stop}
	)
    """)
    
    return cursor.fetchall()
    '''

# h) For en bruker skal man kunne finne all informasjon om de kjøpene hen har gjort for fremtidige reiser




""" Henter opptatte plasser:
SELECT Dato, RuteID, VognType, SitteplassID, BillettID, StartStasjon, EndeStasjon
FROM TogRuteForekomst
	NATURAL JOIN Vognoppsett
	NATURAL JOIN SattSammenAv
	NATURAL JOIN Vogn
	NATURAL JOIN Sitteplass
	NATURAL JOIN SitteplassPåBillett
	NATURAL JOIN Billett
WHERE ForekomstID = 1
	AND RuteID = 1
    AND EXISTS (SELECT SitteplassID 
		FROM SitteplassPåBillett 
		WHERE SitteplassPåBillett.SitteplassID = Sitteplass.SitteplassID
	)
"""

""" Henter alle plasser til en TogRuteForekomst
SELECT ForekomstID, Dato, SitteplassID
FROM TogRuteForekomst
	NATURAL JOIN SattSammenAv
	NATURAL JOIN Sitteplass
WHERE ForekomstID = 1
	AND ForekomstID = OppsettID
"""


""" Henter alle LEDIGE plasser på en TogRuteForekomst
SELECT ForekomstID, Dato, SitteplassID
FROM TogRuteForekomst
	NATURAL JOIN SattSammenAv
	NATURAL JOIN Sitteplass
WHERE ForekomstID = 1
	AND ForekomstID = OppsettID
    AND Billett.StartStasjon <> (SELECT Stasjonsnavn
        FROM StasjonITabell NATURAL JOIN TogRuteTabell
        WHERE RuteID = 1
            AND tid > (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Trondheim")
            AND tid < (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Mosjøen")
    )
    AND Billett.StartStasjon <> "Trondheim"
    AND Billett.EndeStasjon <> (SELECT Stasjonsnavn
        FROM StasjonITabell NATURAL JOIN TogRuteTabell
        WHERE RuteID = 1
            AND tid > (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Trondheim")
            AND tid < (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Mosjøen")
    )
    AND Billett.EndeStasjon <> "Mosjøen"

EXCEPT

SELECT ForekomstID, Dato, SitteplassID
FROM TogRuteForekomst
	NATURAL JOIN Vognoppsett
	NATURAL JOIN SattSammenAv
	NATURAL JOIN Vogn
	NATURAL JOIN Sitteplass
	NATURAL JOIN SitteplassPåBillett
	NATURAL JOIN Billett
WHERE ForekomstID = 1
	AND RuteID = 1
    AND EXISTS (SELECT SitteplassID 
		FROM SitteplassPåBillett
		WHERE SitteplassPåBillett.SitteplassID = Sitteplass.SitteplassID
	)
"""


def get_customer(id): 
    return cursor.execute(f'''SELECT * FROM Kunde WHERE epost = "{id}"''').fetchone()

# tests
def test():
    # register_customer(id := (str(random.randbytes(2)) + "mail@ntnu.no"), "Ola", "Nordmann", "12345678")
    print(f'''
    - - - Start testing... - - -

    Fetch: {str(get_all_routes('Steinkjer', 'Mandag')).replace('(', '').replace(',)', '')})
    Between: {get_all_routes_between('Trondheim', 'Mosjøen', '2023-04-03')})
    Register Fail: {register_customer("mail@ntnu.no", "Ola", "Nordmann", "12345678")}
    Register Success: {register_customer(str(random.randbytes(2)) + "mail@ntnu.no", "Ola", "Nordmann", "12345678")}

    Get available seats: {get_available_seats('Trondheim', 'Mo i Rana', 1)}

    - - - End testing - - -\n''')

# an empty input will quit the while loop
while(action := input('''Actions:
 
    Test - Test all.
    Fetch - Get all routes stopping at a chosen station on said day.   
    Between - Get all routes running between two chosen station on a said day.
    Register - Register new customer.
    Available - Get available seats

    Press 'Enter' to quit...
    
    Select action: ''')):
    if (action == "Test"):
        test()
    
    if (action == 'Fetch'):
        print(str(get_all_routes(input('Station: '), 
                            input('Day: '))).replace('(', '').replace(',)', ''))
   
    if (action == "Between"):
        print(get_all_routes_between(input('Start Station: '), 
                                     input('End Station: '), 
                                     input('Enter a date in YYYY-MM-DD format: ')))
    
    if (action == "Register"):
        register_customer(input('Email: '), 
                          input('First name: '), 
                          input('Last name: '), 
                          input('Phone: '))
        
    if (action == "Available"):
        get_available_seats(input('Start Station: '), 
                          input('End Station: '), 
                          input('Route: '))
    

print('Closing database...')
database.close()







'''
SELECT *
FROM StasjonITabell NATURAL JOIN TogRuteTabell
WHERE RuteID = 1
	AND Stasjonsnavn <> (SELECT Stasjonsnavn
				FROM StasjonITabell NATURAL JOIN TogRuteTabell
				WHERE RuteID = 1
					AND tid > (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Trondheim")
					AND tid < (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Mosjøen")
				)
	AND Stasjonsnavn <> "Trondheim"
'''


'''
SELECT ForekomstID, RuteID, Dato, VognID, VognType, RadStørrelse, SitteplassID
    FROM TogRuteForekomst
        NATURAL JOIN Vognoppsett
        NATURAL JOIN SattSammenAv
        NATURAL JOIN Vogn
        NATURAL JOIN Sitteplass
    WHERE ForekomstID = 1
        AND RuteID = 1
        AND NOT EXISTS (SELECT SitteplassID 
            FROM SitteplassPåBillett NATURAL JOIN Billett
            WHERE SitteplassPåBillett.SitteplassID = Sitteplass.SitteplassID
                AND Billett.StartStasjon <> (SELECT Stasjonsnavn
                    FROM StasjonITabell NATURAL JOIN TogRuteTabell
                    WHERE RuteID = 1
                        AND tid > (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Trondheim")
                        AND tid < (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Mosjøen")
                    )
                AND Billett.StartStasjon <> "Trondheim"
                AND Billett.EndeStasjon <> (SELECT Stasjonsnavn
                    FROM StasjonITabell NATURAL JOIN TogRuteTabell
                    WHERE RuteID = 1
                        AND tid > (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Trondheim")
                        AND tid < (SELECT tid FROM StasjonITabell WHERE Stasjonsnavn = "Mosjøen")
                    )
                AND Billett.EndeStasjon <> "Mosjøen"
        )
'''