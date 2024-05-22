DROP TABLE Pengguna
DROP TABLE Gate
DROP TABLE Gedung
DROP TABLE adminUniv
DROP TABLE History
DROP TABLE rekamGedung
DROP TABLE rekamGate
DROP TABLE rekamPositive
DROP TABLE KontakPositive

CREATE TABLE Pengguna(
	id int NOT NULL,
	notifikasi bit NOT NULL,
	nama varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	[password] varchar(50) NOT NULL
)

CREATE TABLE Gate(
	nomorGate int NOT NULL
)

CREATE TABLE Gedung(
	nomorGedung int NOT NULL,
	kapasitas int NOT NULL
)

CREATE TABLE adminUniv(
	idAdmin int NOT NULL,
	emailAdmin varchar(50) NOT NULL,
	passwordAdmin varchar(50) NOT NULL
)

CREATE TABLE History(
	idHistory int IDENTITY(1,1) NOT NULL,
	idUser int NOT NULL,
	waktuMasukGate datetime NOT NULL,
	waktuKeluarGate datetime NOT NULL,
	waktuMasukGedung datetime NOT NULL,
	waktuKeluarGedung datetime NOT NULL,
	NOGate int,
	NOGedung int
)

CREATE TABLE rekamGedung(
	idRekamGedung int IDENTITY(1,1) NOT NULL,
	idUser int NOT NULL,
	nomorGedung int NOT NULL,
	waktuGedung datetime NOT NULL,
	statusGedung varchar(5) NOT NULL
)

CREATE TABLE rekamGate(
	idRekamgate int IDENTITY(1,1) NOT NULL,
	idUser int NOT NULL,
	nomorGate int NOT NULL,
	waktuGate datetime NOT NULL,
	statusGate varchar(5) NOT NULL
)

CREATE TABLE KontakPositive(
	idRekam int IDENTITY(1,1) NOT NULL,
	idUser int NOT NULL,
	nomorGedung int NOT NULL
)