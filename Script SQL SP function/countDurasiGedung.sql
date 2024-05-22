ALTER PROCEDURE CountDurasiGedung
	(
	@user int,
	@gedung int
	)
	AS
	DECLARE curGedung CURSOR
	FOR
	SELECT waktuGedung, statusGedung
	FROM rekamGedung
	WHERE idUser = @user AND nomorGedung = @gedung
	ORDER BY waktuGedung ASC

	OPEN curGedung

	DECLARE
		@curWaktu datetime,
		@curStatus varchar(5),
		@start datetime,
		@stop datetime,
		@count int = 0


	FETCH NEXT FROM curGedung INTO @curWaktu, @curStatus

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		IF (@curStatus = 'out')
		BEGIN
			SET @start = @curWaktu
		END
		ELSE
		BEGIN
			SET @stop = @curWaktu
			
			SELECT @count = @count + DATEDIFF(MINUTE, @start, @stop)
		END
		
		FETCH NEXT FROM curGedung INTO @curWaktu, @curStatus
	END

	CLOSE curGedung
	DEALLOCATE curGedung

	SELECT @count AS [Durasi di dalam gedung dalam menit]