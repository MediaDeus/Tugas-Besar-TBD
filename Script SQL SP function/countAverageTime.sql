ALTER PROCEDURE CountAverageTime
AS
	DECLARE @in TABLE(
		idUser int,
		waktuGate datetime
	)

	DECLARE @out TABLE(
		idUser int,
		waktuGate datetime
	)

	DECLARE @joined TABLE(
		idUser int,
		waktuIn datetime,
		waktuOut datetime,
		durasiMenit int
	)

	INSERT INTO @in
	SELECT idUser, waktuGate
	FROM rekamGate
	WHERE statusGate = 'out'

	INSERT INTO @out
	SELECT idUser, waktuGate
	FROM rekamGate
	WHERE statusGate = 'out'

	INSERT INTO @joined
	SELECT inTable.idUser, inTable.waktuGate, outTable1.waktuGate, abs(datediff(minute, inTable.waktuGate, outTable1.waktuGate))
	FROM @in as inTable 
		INNER JOIN @out as outTable1 ON inTable.idUser = outTable1.idUser

	SELECT AVG(durasiMenit) as 'durasi(Menit)'
	FROM @joined