CREATE TABLE "Jernbanestasjon" (
	"Navn"	VARCHAR(50),
	"Moh"	INT,
	PRIMARY KEY("Navn")
);
CREATE TABLE "Banestrekning" (
	"Banenavn"	VARCHAR(50),
	"Fremdriftsenergi"	VARCHAR(50),
	"Hovedretning"	VARCHAR(50),
	PRIMARY KEY("Banenavn")
);
CREATE TABLE "DelbanerPåBane" (
	"StrekningsID"	INT,
	"Banenavn"	VARCHAR(50),
	PRIMARY KEY("StrekningsID","Banenavn"),
	FOREIGN KEY("Banenavn") REFERENCES "Banestrekning"("Banenavn"),
	FOREIGN KEY("StrekningsID") REFERENCES "Delstrekning"("StrekningsID")
);
CREATE TABLE "Operatør" (
	"OperatørID"	INT,
	"Navn"	VARCHAR(50) NOT NULL,
	PRIMARY KEY("OperatørID")
);
CREATE TABLE "TogRuteTabell" (
	"RuteID"	INT,
	"TabellID"	INT,
	PRIMARY KEY("RuteID","TabellID"),
	FOREIGN KEY("RuteID") REFERENCES "TogRute"("RuteID")
);
CREATE TABLE "Ukedag" (
	"Dag"	VARCHAR(50),
	PRIMARY KEY("Dag")
);
CREATE TABLE "Kundeordre" (
	"Ordrenummer"	INT,
	"Kjøpsdato"	DATE,
	"Kundenummer"	INT NOT NULL,
	PRIMARY KEY("Ordrenummer"),
	FOREIGN KEY("Kundenummer") REFERENCES "Kunde"("Kundenummer")
);
CREATE TABLE "StasjonITabell" (
	"TabellID"	INTEGER,
	"Stasjonsnavn"	TEXT,
	"Tid"	INTEGER NOT NULL,
	PRIMARY KEY("TabellID","Stasjonsnavn"),
	FOREIGN KEY("Stasjonsnavn") REFERENCES "Jernbanestasjon"("Navn")
);
CREATE TABLE "SattSammenAv" (
	"OppsettID"	INTEGER,
	"VognID"	INTEGER,
	PRIMARY KEY("OppsettID","VognID")
);
CREATE TABLE "Vogn" (
	"VognID"	INTEGER,
	"VognType"	INTEGER,
	"RadStørrelse"	INTEGER,
	"Kupeer"	INTEGER,
	PRIMARY KEY("VognID")
);
CREATE TABLE "Delstrekning" (
	"StrekningsID"	INT,
	"Lengde"	INT NOT NULL CHECK("Lengde" > 0),
	"TypeSpor"	VARCHAR(50),
	"StartStasjonNavn"	VARCHAR(50) NOT NULL,
	"EndeStasjonNavn"	VARCHAR(50) NOT NULL,
	PRIMARY KEY("StrekningsID"),
	FOREIGN KEY("EndeStasjonNavn") REFERENCES "Jernbanestasjon"("Navn"),
	FOREIGN KEY("StartStasjonNavn") REFERENCES "Jernbanestasjon"("Navn")
);
CREATE TABLE "TogRute" (
	"RuteID"	INT,
	"Retning"	VARCHAR(50),
	"OperatørID"	INT,
	PRIMARY KEY("RuteID"),
	FOREIGN KEY("OperatørID") REFERENCES "Operatør"("OperatørID")
);
CREATE TABLE "Soveplass" (
	"VognID"	INT,
	"SoveplassNummer"	INT,
	PRIMARY KEY("VognID","SoveplassNummer"),
	FOREIGN KEY("VognID") REFERENCES "Vogn"("VognID")
);
CREATE TABLE "TogruteKjørerDag" (
	"RuteID"	INT,
	"Dag"	VARCHAR(50),
	PRIMARY KEY("RuteID","Dag"),
	FOREIGN KEY("RuteID") REFERENCES "TogRute"("RuteID") ON DELETE CASCADE,
	FOREIGN KEY("Dag") REFERENCES "Ukedag"("Dag") ON DELETE CASCADE
);
CREATE TABLE "Kunde" (
	"Epost"	VARCHAR(50) NOT NULL,
	"Fornavn"	VARCHAR(50) NOT NULL,
	"Etternavn"	VARCHAR(50) NOT NULL,
	"Telefon"	VARCHAR(20) NOT NULL,
	PRIMARY KEY("Epost")
);
CREATE TABLE "Vognoppsett" (
	"OppsettID"	INT,
	"RuteID"	INTEGER,
	PRIMARY KEY("OppsettID"),
	FOREIGN KEY("RuteID") REFERENCES "TogRuteForekomst"("ForekomstID")
);
CREATE TABLE "TogRuteForekomst" (
	"ForekomstID"	INT,
	"TogRuteID"	INTEGER,
	"Dato"	DATE,
	PRIMARY KEY("ForekomstID"),
	FOREIGN KEY("TogRuteID") REFERENCES "TogRute"("RuteID")
);
CREATE TABLE "Sitteplass" (
	"SitteplassID"	INTEGER,
	"VognID"	INTEGER,
	"SitteplassNummer"	INTEGER,
	PRIMARY KEY("SitteplassID"),
	FOREIGN KEY("VognID") REFERENCES "Vogn"("VognID")
);
CREATE TABLE "SitteplassPåBillett" (
	"BillettID"	INTEGER,
	"SitteplassID"	INTEGER,
	PRIMARY KEY("BillettID","SitteplassID"),
	FOREIGN KEY("BillettID") REFERENCES "Billett"("BillettID"),
	FOREIGN KEY("SitteplassID") REFERENCES "Sitteplass"("SitteplassID")
);
CREATE TABLE "Billett" (
	"BillettID"	INTEGER,
	"ForekomstID"	INTEGER NOT NULL,
	"StartStasjon"	INTEGER,
	"EndeStasjon"	INTEGER,
	PRIMARY KEY("BillettID"),
	FOREIGN KEY("StartStasjon") REFERENCES "Jernbanestasjon"("Navn"),
	FOREIGN KEY("ForekomstID") REFERENCES "TogRuteForekomst"("ForekomstID"),
	FOREIGN KEY("EndeStasjon") REFERENCES "Jernbanestasjon"("Navn")
);