BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Jernbanestasjon" (
	"Navn"	VARCHAR(50),
	"Moh"	INT,
	PRIMARY KEY("Navn")
);
CREATE TABLE IF NOT EXISTS "Banestrekning" (
	"Banenavn"	VARCHAR(50),
	"Fremdriftsenergi"	VARCHAR(50),
	"Hovedretning"	VARCHAR(50),
	PRIMARY KEY("Banenavn")
);
CREATE TABLE IF NOT EXISTS "DelbanerPåBane" (
	"StrekningsID"	INT,
	"Banenavn"	VARCHAR(50),
	PRIMARY KEY("StrekningsID","Banenavn"),
	FOREIGN KEY("Banenavn") REFERENCES "Banestrekning"("Banenavn"),
	FOREIGN KEY("StrekningsID") REFERENCES "Delstrekning"("StrekningsID")
);
CREATE TABLE IF NOT EXISTS "Operatør" (
	"OperatørID"	INT,
	"Navn"	VARCHAR(50) NOT NULL,
	PRIMARY KEY("OperatørID")
);
CREATE TABLE IF NOT EXISTS "TogRuteTabell" (
	"RuteID"	INT,
	"TabellID"	INT,
	PRIMARY KEY("RuteID","TabellID"),
	FOREIGN KEY("RuteID") REFERENCES "TogRute"("RuteID")
);
CREATE TABLE IF NOT EXISTS "Ukedag" (
	"Dag"	VARCHAR(50),
	PRIMARY KEY("Dag")
);
CREATE TABLE IF NOT EXISTS "Kundeordre" (
	"Ordrenummer"	INT,
	"Kjøpsdato"	DATE,
	"Kundenummer"	INT NOT NULL,
	PRIMARY KEY("Ordrenummer"),
	FOREIGN KEY("Kundenummer") REFERENCES "Kunde"("Kundenummer")
);
CREATE TABLE IF NOT EXISTS "StasjonITabell" (
	"TabellID"	INTEGER,
	"Stasjonsnavn"	TEXT,
	"Tid"	INTEGER NOT NULL,
	PRIMARY KEY("TabellID","Stasjonsnavn"),
	FOREIGN KEY("Stasjonsnavn") REFERENCES "Jernbanestasjon"("Navn")
);
CREATE TABLE IF NOT EXISTS "SattSammenAv" (
	"OppsettID"	INTEGER,
	"VognID"	INTEGER,
	PRIMARY KEY("OppsettID","VognID")
);
CREATE TABLE IF NOT EXISTS "Vogn" (
	"VognID"	INTEGER,
	"VognType"	INTEGER,
	"RadStørrelse"	INTEGER,
	"Kupeer"	INTEGER,
	PRIMARY KEY("VognID")
);
CREATE TABLE IF NOT EXISTS "Delstrekning" (
	"StrekningsID"	INT,
	"Lengde"	INT NOT NULL CHECK("Lengde" > 0),
	"TypeSpor"	VARCHAR(50),
	"StartStasjonNavn"	VARCHAR(50) NOT NULL,
	"EndeStasjonNavn"	VARCHAR(50) NOT NULL,
	PRIMARY KEY("StrekningsID"),
	FOREIGN KEY("EndeStasjonNavn") REFERENCES "Jernbanestasjon"("Navn"),
	FOREIGN KEY("StartStasjonNavn") REFERENCES "Jernbanestasjon"("Navn")
);
CREATE TABLE IF NOT EXISTS "TogRute" (
	"RuteID"	INT,
	"Retning"	VARCHAR(50),
	"OperatørID"	INT,
	PRIMARY KEY("RuteID"),
	FOREIGN KEY("OperatørID") REFERENCES "Operatør"("OperatørID")
);
CREATE TABLE IF NOT EXISTS "Soveplass" (
	"VognID"	INT,
	"SoveplassNummer"	INT,
	PRIMARY KEY("VognID","SoveplassNummer"),
	FOREIGN KEY("VognID") REFERENCES "Vogn"("VognID")
);
CREATE TABLE IF NOT EXISTS "TogruteKjørerDag" (
	"RuteID"	INT,
	"Dag"	VARCHAR(50),
	PRIMARY KEY("RuteID","Dag"),
	FOREIGN KEY("RuteID") REFERENCES "TogRute"("RuteID") ON DELETE CASCADE,
	FOREIGN KEY("Dag") REFERENCES "Ukedag"("Dag") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "Kunde" (
	"Epost"	VARCHAR(50) NOT NULL,
	"Fornavn"	VARCHAR(50) NOT NULL,
	"Etternavn"	VARCHAR(50) NOT NULL,
	"Telefon"	VARCHAR(20) NOT NULL,
	PRIMARY KEY("Epost")
);
CREATE TABLE IF NOT EXISTS "Vognoppsett" (
	"OppsettID"	INT,
	"RuteID"	INTEGER,
	PRIMARY KEY("OppsettID"),
	FOREIGN KEY("RuteID") REFERENCES "TogRuteForekomst"("ForekomstID")
);
CREATE TABLE IF NOT EXISTS "TogRuteForekomst" (
	"ForekomstID"	INT,
	"TogRuteID"	INTEGER,
	"Dato"	DATE,
	PRIMARY KEY("ForekomstID"),
	FOREIGN KEY("TogRuteID") REFERENCES "TogRute"("RuteID")
);
CREATE TABLE IF NOT EXISTS "Sitteplass" (
	"SitteplassID"	INTEGER,
	"VognID"	INTEGER,
	"SitteplassNummer"	INTEGER,
	PRIMARY KEY("SitteplassID"),
	FOREIGN KEY("VognID") REFERENCES "Vogn"("VognID")
);
CREATE TABLE IF NOT EXISTS "SitteplassPåBillett" (
	"BillettID"	INTEGER,
	"SitteplassID"	INTEGER,
	PRIMARY KEY("BillettID","SitteplassID"),
	FOREIGN KEY("BillettID") REFERENCES "Billett"("BillettID"),
	FOREIGN KEY("SitteplassID") REFERENCES "Sitteplass"("SitteplassID")
);
CREATE TABLE IF NOT EXISTS "Billett" (
	"BillettID"	INTEGER,
	"ForekomstID"	INTEGER NOT NULL,
	"StartStasjon"	INTEGER,
	"EndeStasjon"	INTEGER,
	PRIMARY KEY("BillettID"),
	FOREIGN KEY("StartStasjon") REFERENCES "Jernbanestasjon"("Navn"),
	FOREIGN KEY("ForekomstID") REFERENCES "TogRuteForekomst"("ForekomstID"),
	FOREIGN KEY("EndeStasjon") REFERENCES "Jernbanestasjon"("Navn")
);
INSERT INTO "Jernbanestasjon" VALUES ('Trondheim',5.1);
INSERT INTO "Jernbanestasjon" VALUES ('Steinkjer',3.6);
INSERT INTO "Jernbanestasjon" VALUES ('Mosjøen',6.8);
INSERT INTO "Jernbanestasjon" VALUES ('Mo i Rana',3.5);
INSERT INTO "Jernbanestasjon" VALUES ('Fauske',34);
INSERT INTO "Jernbanestasjon" VALUES ('Bodø',4.1);
INSERT INTO "Banestrekning" VALUES ('Nordlandsbanen','Diesel','Nord');
INSERT INTO "DelbanerPåBane" VALUES (1,'Nordlandsbanen');
INSERT INTO "DelbanerPåBane" VALUES (2,'Nordlandsbanen');
INSERT INTO "DelbanerPåBane" VALUES (3,'Nordlandsbanen');
INSERT INTO "DelbanerPåBane" VALUES (4,'Nordlandsbanen');
INSERT INTO "DelbanerPåBane" VALUES (5,'Nordlandsbanen');
INSERT INTO "Operatør" VALUES (1,'SJ');
INSERT INTO "TogRuteTabell" VALUES (1,1);
INSERT INTO "TogRuteTabell" VALUES (2,2);
INSERT INTO "TogRuteTabell" VALUES (3,3);
INSERT INTO "Ukedag" VALUES ('Mandag');
INSERT INTO "Ukedag" VALUES ('Tirsdag');
INSERT INTO "Ukedag" VALUES ('Onsdag');
INSERT INTO "Ukedag" VALUES ('Torsdag');
INSERT INTO "Ukedag" VALUES ('Fredag');
INSERT INTO "Ukedag" VALUES ('Lørdag');
INSERT INTO "Ukedag" VALUES ('Søndag');
INSERT INTO "StasjonITabell" VALUES (1,'Trondheim','07:49');
INSERT INTO "StasjonITabell" VALUES (1,'Steinkjer','09:51');
INSERT INTO "StasjonITabell" VALUES (1,'Mosjøen','13:20');
INSERT INTO "StasjonITabell" VALUES (1,'Mo i Rana','14:31');
INSERT INTO "StasjonITabell" VALUES (1,'Fauske','16:49');
INSERT INTO "StasjonITabell" VALUES (1,'Bodø','17:34');
INSERT INTO "StasjonITabell" VALUES (2,'Trondheim','23:05');
INSERT INTO "StasjonITabell" VALUES (2,'Steinkjer','00:57');
INSERT INTO "StasjonITabell" VALUES (2,'Mosjøen','04:41');
INSERT INTO "StasjonITabell" VALUES (2,'Mo i Rana','05:55');
INSERT INTO "StasjonITabell" VALUES (2,'Fauske','08:19');
INSERT INTO "StasjonITabell" VALUES (2,'Bodø','09:05');
INSERT INTO "StasjonITabell" VALUES (3,'Mo i Rana','08:11');
INSERT INTO "StasjonITabell" VALUES (3,'Mosjøen','09:14');
INSERT INTO "StasjonITabell" VALUES (3,'Steinkjer','12:31');
INSERT INTO "StasjonITabell" VALUES (3,'Trondheim','14:13');
INSERT INTO "SattSammenAv" VALUES (1,1);
INSERT INTO "SattSammenAv" VALUES (1,2);
INSERT INTO "SattSammenAv" VALUES (2,3);
INSERT INTO "SattSammenAv" VALUES (2,4);
INSERT INTO "SattSammenAv" VALUES (3,5);
INSERT INTO "Vogn" VALUES (1,'Sittevogn',4,NULL);
INSERT INTO "Vogn" VALUES (2,'Sittevogn',4,NULL);
INSERT INTO "Vogn" VALUES (3,'Sittevogn',4,NULL);
INSERT INTO "Vogn" VALUES (4,'Sovevogn',NULL,4);
INSERT INTO "Vogn" VALUES (5,'Sittevogn',4,NULL);
INSERT INTO "Delstrekning" VALUES (1,120,'Dobbel','Trondheim','Steinkjer');
INSERT INTO "Delstrekning" VALUES (2,280,'Enkel','Steinkjer','Mosjøen');
INSERT INTO "Delstrekning" VALUES (3,90,'Enkel','Mosjøen','Mo i Rana');
INSERT INTO "Delstrekning" VALUES (4,170,'Enkel','Mo i Rana','Steinkjer');
INSERT INTO "Delstrekning" VALUES (5,60,'Enkel','Fauske','Bodø');
INSERT INTO "TogRute" VALUES (1,'Nord',1);
INSERT INTO "TogRute" VALUES (2,'Nord',1);
INSERT INTO "TogRute" VALUES (3,'Sør',1);
INSERT INTO "Soveplass" VALUES (4,1);
INSERT INTO "Soveplass" VALUES (4,2);
INSERT INTO "Soveplass" VALUES (4,3);
INSERT INTO "Soveplass" VALUES (4,4);
INSERT INTO "Soveplass" VALUES (4,5);
INSERT INTO "Soveplass" VALUES (4,6);
INSERT INTO "Soveplass" VALUES (4,7);
INSERT INTO "Soveplass" VALUES (4,8);
INSERT INTO "TogruteKjørerDag" VALUES (1,'Mandag');
INSERT INTO "TogruteKjørerDag" VALUES (1,'Tirsdag');
INSERT INTO "TogruteKjørerDag" VALUES (1,'Onsdag');
INSERT INTO "TogruteKjørerDag" VALUES (1,'Torsdag');
INSERT INTO "TogruteKjørerDag" VALUES (1,'Fredag');
INSERT INTO "TogruteKjørerDag" VALUES (2,'Mandag');
INSERT INTO "TogruteKjørerDag" VALUES (2,'Tirsdag');
INSERT INTO "TogruteKjørerDag" VALUES (2,'Onsdag');
INSERT INTO "TogruteKjørerDag" VALUES (2,'Torsdag');
INSERT INTO "TogruteKjørerDag" VALUES (2,'Fredag');
INSERT INTO "TogruteKjørerDag" VALUES (2,'Lørdag');
INSERT INTO "TogruteKjørerDag" VALUES (2,'Søndag');
INSERT INTO "TogruteKjørerDag" VALUES (3,'Mandag');
INSERT INTO "TogruteKjørerDag" VALUES (3,'Tirsdag');
INSERT INTO "TogruteKjørerDag" VALUES (3,'Onsdag');
INSERT INTO "TogruteKjørerDag" VALUES (3,'Torsdag');
INSERT INTO "TogruteKjørerDag" VALUES (3,'Fredag');
INSERT INTO "Kunde" VALUES ('viktort@ntnu.no','Viktor','Tingstad','004702800');
INSERT INTO "Kunde" VALUES ('viktorti@ntnu.no','Viktor','Tingstad','004702800');
INSERT INTO "Kunde" VALUES ('john@ntnu.no','John','G','004702800');
INSERT INTO "Kunde" VALUES ('b''\x9a\xf9''mail@ntnu.no','Ola','Nordmann','12345678');
INSERT INTO "Kunde" VALUES ('b'']x''mail@ntnu.no','Ola','Nordmann','12345678');
INSERT INTO "Kunde" VALUES ('mail@ntnu.no','Ola','Nordmann','12345678');
INSERT INTO "Kunde" VALUES ('b''\x9ai''mail@ntnu.no','Ola','Nordmann','12345678');
INSERT INTO "Kunde" VALUES ('b''9\x95''mail@ntnu.no','Ola','Nordmann','12345678');
INSERT INTO "Kunde" VALUES ('b''\xa0\xa9\xf9\x1e\xce\x7f\x1b\xf1Xwm\x89\xe2\xd9\x8cP\x076\xe3\x13\x01\x1e\x1b\x07O\xb2\xed\x08\xbd\xf9G\xa9''mail@ntnu.no','Ola','Nordmann','12345678');
INSERT INTO "Vognoppsett" VALUES (1,1);
INSERT INTO "Vognoppsett" VALUES (2,2);
INSERT INTO "Vognoppsett" VALUES (3,3);
INSERT INTO "TogRuteForekomst" VALUES (1,1,'03.04.2023');
INSERT INTO "TogRuteForekomst" VALUES (2,1,'04.04.2023');
INSERT INTO "TogRuteForekomst" VALUES (3,2,'03.04.2023');
INSERT INTO "TogRuteForekomst" VALUES (4,2,'04.04.2023');
INSERT INTO "TogRuteForekomst" VALUES (5,3,'03.04.2023');
INSERT INTO "TogRuteForekomst" VALUES (6,3,'04.04.2023');
INSERT INTO "Sitteplass" VALUES (1,1,1);
INSERT INTO "Sitteplass" VALUES (2,1,2);
INSERT INTO "Sitteplass" VALUES (3,1,3);
INSERT INTO "Sitteplass" VALUES (4,1,4);
INSERT INTO "Sitteplass" VALUES (5,1,5);
INSERT INTO "Sitteplass" VALUES (6,1,6);
INSERT INTO "Sitteplass" VALUES (7,1,7);
INSERT INTO "Sitteplass" VALUES (8,1,8);
INSERT INTO "Sitteplass" VALUES (9,1,9);
INSERT INTO "Sitteplass" VALUES (10,1,10);
INSERT INTO "Sitteplass" VALUES (11,1,11);
INSERT INTO "Sitteplass" VALUES (12,1,12);
INSERT INTO "Sitteplass" VALUES (13,2,1);
INSERT INTO "Sitteplass" VALUES (14,2,2);
INSERT INTO "Sitteplass" VALUES (15,2,3);
INSERT INTO "Sitteplass" VALUES (16,2,4);
INSERT INTO "Sitteplass" VALUES (17,2,5);
INSERT INTO "Sitteplass" VALUES (18,2,6);
INSERT INTO "Sitteplass" VALUES (19,2,7);
INSERT INTO "Sitteplass" VALUES (20,2,8);
INSERT INTO "Sitteplass" VALUES (21,2,9);
INSERT INTO "Sitteplass" VALUES (22,2,10);
INSERT INTO "Sitteplass" VALUES (23,2,11);
INSERT INTO "Sitteplass" VALUES (24,2,12);
INSERT INTO "Sitteplass" VALUES (25,3,1);
INSERT INTO "Sitteplass" VALUES (26,3,2);
INSERT INTO "Sitteplass" VALUES (27,3,3);
INSERT INTO "Sitteplass" VALUES (28,3,4);
INSERT INTO "Sitteplass" VALUES (29,3,5);
INSERT INTO "Sitteplass" VALUES (30,3,6);
INSERT INTO "Sitteplass" VALUES (31,3,7);
INSERT INTO "Sitteplass" VALUES (32,3,8);
INSERT INTO "Sitteplass" VALUES (33,3,9);
INSERT INTO "Sitteplass" VALUES (34,3,10);
INSERT INTO "Sitteplass" VALUES (35,3,11);
INSERT INTO "Sitteplass" VALUES (36,3,12);
INSERT INTO "Sitteplass" VALUES (37,5,1);
INSERT INTO "Sitteplass" VALUES (38,5,2);
INSERT INTO "Sitteplass" VALUES (39,5,3);
INSERT INTO "Sitteplass" VALUES (40,5,4);
INSERT INTO "Sitteplass" VALUES (41,5,5);
INSERT INTO "Sitteplass" VALUES (42,5,6);
INSERT INTO "Sitteplass" VALUES (43,5,7);
INSERT INTO "Sitteplass" VALUES (44,5,8);
INSERT INTO "Sitteplass" VALUES (45,5,9);
INSERT INTO "Sitteplass" VALUES (46,5,10);
INSERT INTO "Sitteplass" VALUES (47,5,11);
INSERT INTO "Sitteplass" VALUES (48,5,12);
INSERT INTO "SitteplassPåBillett" VALUES (1,1);
INSERT INTO "SitteplassPåBillett" VALUES (1,2);
INSERT INTO "SitteplassPåBillett" VALUES (1,3);
INSERT INTO "SitteplassPåBillett" VALUES (1,4);
INSERT INTO "Billett" VALUES (1,1,'Trondheim','Mosjøen');
INSERT INTO "Billett" VALUES (2,1,'Trondheim','Steinkjer');
INSERT INTO "Billett" VALUES (3,2,'Trondheim','Steinkjer');
INSERT INTO "Billett" VALUES (4,3,'Mo i Rana','Steinkjer');
COMMIT;
