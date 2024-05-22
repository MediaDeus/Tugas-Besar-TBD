ALTER PROCEDURE CekHistory
(
    @id int
)
AS
	DECLARE @res TABLE(
		idUser int,
		waktuMasukGate datetime,
		waktuKeluarGate datetime,
		waktuMasukGedung datetime,
		waktuKeluarGedung datetime,
		NOGate int,
		NOGedung int
	)
	
	DECLARE curHistory CURSOR
	FOR
	SELECT rekamGate.idUser, rekamGate.nomorGate, rekamGate.waktuGate, rekamGate.statusGate, rekamGedung.nomorGedung, rekamGedung.waktuGedung, rekamGedung.statusGedung
	FROM rekamGate
	JOIN Pengguna ON Pengguna.id = rekamGate.idUser
	JOIN rekamGedung ON rekamGate.idUser = rekamGedung.idUser
	WHERE rekamGedung.idUser = @id
	ORDER BY waktuGedung ASC

	OPEN curHistory

	DECLARE
		@curId int,
		@noGedung int,
		@noGate int,
		@curWaktuGedung datetime,
		@curWaktuGate datetime,
		@curStatusGedung varchar(5),
		@curStatusGate varchar(5),
		@masukGate datetime,
		@keluarGate datetime,
		@masukGedung datetime,
		@keluarGedung datetime

	FETCH NEXT FROM curHistory INTO @curId, @noGate, @curWaktuGate, @curStatusGate, @noGedung, @curWaktuGedung, @curStatusGedung

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		IF (@curStatusGate = 'in')
		BEGIN
			SET @masukGate = @curWaktuGate
			SET @masukGedung = @curWaktuGedung
		END
		ELSE
		BEGIN
			SET @keluarGate = @curWaktuGate
			SET @keluarGedung = @curWaktuGedung
			INSERT INTO @res
			SELECT idUser = @curId, waktuMasukGate = @masukGate, waktuKeluarGate = @keluarGate, waktuMasukGedung = @masukGedung, waktuKeluarGedung = @keluarGedung, NOGate = @noGate, NOGedung = @noGedung
		END
		
		FETCH NEXT FROM curHistory INTO @curId, @noGate, @curWaktuGate, @curStatusGate, @noGedung, @curWaktuGedung, @curStatusGedung 
	END
	CLOSE curHistory
	DEALLOCATE curHistory
	SELECT * FROM @res