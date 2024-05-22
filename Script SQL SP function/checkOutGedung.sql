CREATE PROCEDURE CheckOutUserGedung
(
	@idUser int,
	@nomorGedung int,
	@waktuGedung datetime
)
AS
	DECLARE 
		@kapasitas int

	@kapasitas = exec CountKapasitasGedung @nomorGedung

	INSERT INTO rekamGedung(id int NOT NULL, nomorGedung int NOT NULL, kapasitasSaatIni int NOT NULL, waktuGedung datetime NOT NULL, statusGedung varchar(5) NOT NULL)
	VALUES(@idUser, @nomorGedung, @kapasitas, @waktuGedung, 'out')