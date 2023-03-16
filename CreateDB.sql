-- Opprett tabellen for Jernbanestasjon
CREATE TABLE Jernbanestasjon (
    Navn VARCHAR(50) PRIMARY KEY,
    Moh INT
);

-- Opprett tabellen for Banestrekning
CREATE TABLE Banestrekning (
    Banenavn VARCHAR(50) PRIMARY KEY,
    Fremdriftsenergi VARCHAR(50),
    Hovedretning VARCHAR(50)
);

-- Opprett tabellen for Delstrekning
CREATE TABLE Delstrekning (
    StrekningsID INT PRIMARY KEY,
    Lengde INT CHECK (Lengde > 0) NOT NULL,
    TypeSpor VARCHAR(50),
    StartStasjonNavn VARCHAR(50) NOT NULL,
    EndeStasjonNavn VARCHAR(50) NOT NULL,
    FOREIGN KEY (StartStasjonNavn) REFERENCES Jernbanestasjon(Navn) ON DELETE CASCADE,
    FOREIGN KEY (EndeStasjonNavn) REFERENCES Jernbanestasjon(Navn) ON DELETE CASCADE
);

-- Opprett tabellen for DelbanerPåBane
CREATE TABLE DelbanerPåBane (
    StrekningsID INT,
    Banenavn VARCHAR(50),
    PRIMARY KEY (StrekningsID, Banenavn),
    FOREIGN KEY (StrekningsID) REFERENCES Delstrekning(StrekningsID) ON DELETE CASCADE,
    FOREIGN KEY (Banenavn) REFERENCES Banestrekning(Banenavn) ON DELETE CASCADE
);

-- Opprett tabellen for Operatør
CREATE TABLE Operatør (
    OperatørID INT PRIMARY KEY,
    Navn VARCHAR(50) NOT NULL
);

-- Opprett tabellen for TogRute
CREATE TABLE TogRute (
    RuteID INT PRIMARY KEY,
    Retning VARCHAR(50),
    OperatørID INT NOT NULL,
    FOREIGN KEY (OperatørID) REFERENCES Operatør(OperatørID) ON DELETE CASCADE
);

-- Opprett tabellen for TogRuteForekomst
CREATE TABLE TogRuteForekomst (
    ForekomstID INT,
    RuteID INT,
    Dato DATE,
    PRIMARY KEY (RuteID, ForekomstID),
    FOREIGN KEY (RuteID) REFERENCES TogRute(RuteID) ON DELETE CASCADE
);

-- Opprett tabellen for  TogRuteTabell
CREATE TABLE TogRuteTabell (
    RuteID INT,
    TabellID INT,
    PRIMARY KEY (RuteID, TabellID),
    FOREIGN KEY (RuteID) REFERENCES TogRute(RuteID) ON DELETE CASCADE
);

-- Oppprett tabellen for TogruteKjørerDag
CREATE TABLE TogruteKjørerDag (
    RuteID INT,
    Dag VARCHAR(50),
    PRIMARY KEY (RuteID, Dag),
    FOREIGN KEY (RuteID) REFERENCES TogRute(RuteID) ON DELETE CASCADE,
    FOREIGN KEY (Dag) REFERENCES Ukedag(Dag) ON DELETE CASCADE
);

-- Opprett tabellen for Ukedag
CREATE TABLE Ukedag (
    Dag VARCHAR(50) PRIMARY KEY
);

-- Opprett tabellen for Vognoppsett
CREATE TABLE Vognoppsett (
    OppsettID INT PRIMARY KEY
);

-- Opprett tabellen for Vogn
CREATE TABLE Vogn (
    VognID INT PRIMARY KEY,
    VognType VARCHAR(50),
    RadStørrelse INT CHECK (RadStørrelse > 0),
    Kupeer INT CHECK (Kupeer > 0)
);

-- Opprett tabellen for Sitteplas
CREATE TABLE Sitteplass (
    VognID INT,
    SitteplassNummer INT,
    PRIMARY KEY (VognID, SitteplassNummer),
    FOREIGN KEY (VognID) REFERENCES Vogn(VognID) ON DELETE CASCADE
);

-- Opprett tabellen for Soveplass
CREATE TABLE Soveplass (
    VognID INT,
    SoveplassNummer INT,
    PRIMARY KEY (VognID, SoveplassNummer),
    FOREIGN KEY (VognID) REFERENCES Vogn(VognID) ON DELETE CASCADE
);

-- Opprett tabellen for Billett
CREATE TABLE Billett (
    BillettID INT PRIMARY KEY,
    ForekomstID INT NOT NULL,
    StartStasjonNavn VARCHAR(50) NOT NULL,
    EndeStasjonNavn VARCHAR(50) NOT NULL,
    FOREIGN KEY (ForekomstID) REFERENCES Forekomst (ForekomstID) ON DELETE CASCADE,
    FOREIGN KEY (StartStasjonNavn) REFERENCES Jernbanestasjon (Navn) ON DELETE CASCADE,
    FOREIGN KEY (EndeStasjonNavn) REFERENCES Jernbanestasjon (Navn) ON DELETE CASCADE
);

-- Opprett tabellen for Kundeordre
CREATE TABLE Kundeordre (
    Ordrenummer INT PRIMARY KEY,
    Kjøpsdato DATE,
    Kundenummer INT NOT NULL,
    FOREIGN KEY (Kundenummer) REFERENCES Kunde (Kundenummer) ON DELETE CASCADE
);

-- Opprett tabellen for Kunde
CREATE TABLE Kunde (
    Kundenummer INT PRIMARY KEY,
    Fornavn VARCHAR(50),
    Etternavn VARCHAR(50),
    Telefon VARCHAR(20),
    Epost VARCHAR(50)
);
