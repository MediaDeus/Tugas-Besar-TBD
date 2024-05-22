CREATE PROCEDURE CheckOutUserGate
(
	@idUser int,
	@nomorGate int,
	@waktuGate datetime
)
AS
	INSERT INTO rekamGate(id int, nomorGate int, waktuGate datetime, statusGate varchar(50)) 
	VALUES(@idUser, @nomorGate, @waktuGate, 'out')