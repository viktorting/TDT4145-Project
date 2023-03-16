/* 
a); Databasen skal kunne registrere data om alle jernbanestrekninger i Norge. Dere skal legge inn
data for Nordlandsbanen (som vist i figuren).
*/


 -- Jernbanestasjon(Navn, Moh)
INSERT INTO Jernbanestasjon VALUES ("Trondheim", 5.1);
INSERT INTO Jernbanestasjon VALUES ("Steinkjer", 3.6);
INSERT INTO Jernbanestasjon VALUES ("Mosjøen", 6.8);
INSERT INTO Jernbanestasjon VALUES ("Mo i Rana", 3.5);
INSERT INTO Jernbanestasjon VALUES ("Fauske", 34.0);
INSERT INTO Jernbanestasjon VALUES ("Bodø", 4.1);


 -- Banestrekning(Banenavn, Fremdriftsenergi, Hovedretning)
INSERT INTO Banestrekning VALUES ("Nordlandsbanen", "Diesel", "Nord");


 -- Delstrekning(StrekningsID, Lengde, TypeSpor, Navn (start), Navn (ende))
INSERT INTO Delstrekning VALUES (1, 120, "Dobbel", "Trondheim", "Steinkjer");
INSERT INTO Delstrekning VALUES (2, 280, "Enkel", "Steinkjer", "Mosjøen");
INSERT INTO Delstrekning VALUES (3, 90, "Enkel", "Mosjøen", "Mo i Rana");
INSERT INTO Delstrekning VALUES (4, 170, "Enkel", "Mo i Rana", "Steinkjer");
INSERT INTO Delstrekning VALUES (5, 60, "Enkel", "Fauske", "Bodø");


 -- DelbanerPåBane(StrekningsID, Banenavn)
INSERT INTO DelbanerPåBane VALUES (1, "Nordlandsbanen");
INSERT INTO DelbanerPåBane VALUES (2, "Nordlandsbanen");
INSERT INTO DelbanerPåBane VALUES (3, "Nordlandsbanen");
INSERT INTO DelbanerPåBane VALUES (4, "Nordlandsbanen");
INSERT INTO DelbanerPåBane VALUES (5, "Nordlandsbanen");


/*
b); Dere skal kunne registrere data om togruter. Dere skal legge inn data for de tre togrutene på
Nordlandsbanen som er beskrevet i vedlegget til denne oppgave.
*/ 


 -- Operatør(OperatørID, Navn)
INSERT INTO Operatør VALUES (1, "SJ");


 -- Togrute(RuteID, Retning, OperatørID)
INSERT INTO Togrute VALUES (1, "Nord", 1);
INSERT INTO Togrute VALUES (2, "Nord", 1);
INSERT INTO Togrute VALUES (3, "Sør", 1);


 -- Togruteforekomst(ForekomstID, RuteID, Dato)
INSERT INTO Togruteforekomst VALUES (1, 1, "03.04.2023");
INSERT INTO Togruteforekomst VALUES (2, 1, "04.04.2023");

INSERT INTO Togruteforekomst VALUES (3, 2, "03.04.2023");
INSERT INTO Togruteforekomst VALUES (4, 2, "04.04.2023");

INSERT INTO Togruteforekomst VALUES (5, 3, "03.04.2023");
INSERT INTO Togruteforekomst VALUES (6, 3, "04.04.2023");


 -- Togrutetabell(TabellID, RuteID)
INSERT INTO Togrutetabell VALUES (1, 1);
INSERT INTO Togrutetabell VALUES (2, 2);
INSERT INTO Togrutetabell VALUES (3, 3);


 -- StasjonITabell(TabellID, Stasjonsnavn, Tid)
INSERT INTO StasjonITabell VALUES (1, "Trondheim", "07:49");
INSERT INTO StasjonITabell VALUES (1, "Steinkjer", "09:51");
INSERT INTO StasjonITabell VALUES (1, "Mosjøen", "13:20");
INSERT INTO StasjonITabell VALUES (1, "Mo i Rana", "14:31");
INSERT INTO StasjonITabell VALUES (1, "Fauske", "16:49");
INSERT INTO StasjonITabell VALUES (1, "Bodø", "17:34");

INSERT INTO StasjonITabell VALUES (2, "Trondheim", "23:05");
INSERT INTO StasjonITabell VALUES (2, "Steinkjer", "00:57");
INSERT INTO StasjonITabell VALUES (2, "Mosjøen", "04:41");
INSERT INTO StasjonITabell VALUES (2, "Mo i Rana", "05:55");
INSERT INTO StasjonITabell VALUES (2, "Fauske", "08:19");
INSERT INTO StasjonITabell VALUES (2, "Bodø", "09:05");

INSERT INTO StasjonITabell VALUES (3, "Mo i Rana", "08:11");
INSERT INTO StasjonITabell VALUES (3, "Mosjøen", "09:14");
INSERT INTO StasjonITabell VALUES (3, "Steinkjer", "12:31");
INSERT INTO StasjonITabell VALUES (3, "Trondheim", "14:13");


 -- Ukedag(Dag)
INSERT INTO Ukedag VALUES ("Mandag");
INSERT INTO Ukedag VALUES ("Tirsdag");
INSERT INTO Ukedag VALUES ("Onsdag");
INSERT INTO Ukedag VALUES ("Torsdag");
INSERT INTO Ukedag VALUES ("Fredag");
INSERT INTO Ukedag VALUES ("Lørdag");
INSERT INTO Ukedag VALUES ("Søndag");


 -- Vognoppsett(OppsettID, RuteID)
INSERT INTO Vognoppsett VALUES (1, 1);
INSERT INTO Vognoppsett VALUES (2, 2);
INSERT INTO Vognoppsett VALUES (3, 3);


 -- SattSammenAv(OppsettID, VognID)
INSERT INTO SattSammenAv VALUES (1, 1);
INSERT INTO SattSammenAv VALUES (1, 2);
INSERT INTO SattSammenAv VALUES (2, 3);
INSERT INTO SattSammenAv VALUES (2, 4);
INSERT INTO SattSammenAv VALUES (3, 5);


 -- Vogn(VognID, VognType, RadStørrelse, Kupeer)
INSERT INTO Vogn VALUES (1, "Sittevogn", 4, NULL);
INSERT INTO Vogn VALUES (2, "Sittevogn", 4, NULL);
INSERT INTO Vogn VALUES (3, "Sittevogn", 4, NULL);
INSERT INTO Vogn VALUES (4, "Sovevogn", NULL, 4);
INSERT INTO Vogn VALUES (5, "Sittevogn", 4, NULL);


 -- Sitteplass(VognID, SitteplassNummer)
INSERT INTO Sitteplass VALUES (1, 1);
INSERT INTO Sitteplass VALUES (1, 2);
INSERT INTO Sitteplass VALUES (1, 3);
INSERT INTO Sitteplass VALUES (1, 4);
INSERT INTO Sitteplass VALUES (1, 5);
INSERT INTO Sitteplass VALUES (1, 6);
INSERT INTO Sitteplass VALUES (1, 7);
INSERT INTO Sitteplass VALUES (1, 8);
INSERT INTO Sitteplass VALUES (1, 9);
INSERT INTO Sitteplass VALUES (1, 10);
INSERT INTO Sitteplass VALUES (1, 11);
INSERT INTO Sitteplass VALUES (1, 12);

INSERT INTO Sitteplass VALUES (2, 1);
INSERT INTO Sitteplass VALUES (2, 2);
INSERT INTO Sitteplass VALUES (2, 3);
INSERT INTO Sitteplass VALUES (2, 4);
INSERT INTO Sitteplass VALUES (2, 5);
INSERT INTO Sitteplass VALUES (2, 6);
INSERT INTO Sitteplass VALUES (2, 7);
INSERT INTO Sitteplass VALUES (2, 8);
INSERT INTO Sitteplass VALUES (2, 9);
INSERT INTO Sitteplass VALUES (2, 10);
INSERT INTO Sitteplass VALUES (2, 11);
INSERT INTO Sitteplass VALUES (2, 12);

INSERT INTO Sitteplass VALUES (3, 1);
INSERT INTO Sitteplass VALUES (3, 2);
INSERT INTO Sitteplass VALUES (3, 3);
INSERT INTO Sitteplass VALUES (3, 4);
INSERT INTO Sitteplass VALUES (3, 5);
INSERT INTO Sitteplass VALUES (3, 6);
INSERT INTO Sitteplass VALUES (3, 7);
INSERT INTO Sitteplass VALUES (3, 8);
INSERT INTO Sitteplass VALUES (3, 9);
INSERT INTO Sitteplass VALUES (3, 10);
INSERT INTO Sitteplass VALUES (3, 11);
INSERT INTO Sitteplass VALUES (3, 12);

INSERT INTO Sitteplass VALUES (5, 1);
INSERT INTO Sitteplass VALUES (5, 2);
INSERT INTO Sitteplass VALUES (5, 3);
INSERT INTO Sitteplass VALUES (5, 4);
INSERT INTO Sitteplass VALUES (5, 5);
INSERT INTO Sitteplass VALUES (5, 6);
INSERT INTO Sitteplass VALUES (5, 7);
INSERT INTO Sitteplass VALUES (5, 8);
INSERT INTO Sitteplass VALUES (5, 9);
INSERT INTO Sitteplass VALUES (5, 10);
INSERT INTO Sitteplass VALUES (5, 11);
INSERT INTO Sitteplass VALUES (5, 12);


 -- Soveplass(VognID, SoveplassNummer)
INSERT INTO Soveplass VALUES (4, 1);
INSERT INTO Soveplass VALUES (4, 2);
INSERT INTO Soveplass VALUES (4, 3);
INSERT INTO Soveplass VALUES (4, 4);
INSERT INTO Soveplass VALUES (4, 5);
INSERT INTO Soveplass VALUES (4, 6);
INSERT INTO Soveplass VALUES (4, 7);
INSERT INTO Soveplass VALUES (4, 8);
