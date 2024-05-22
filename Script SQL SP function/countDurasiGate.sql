ALTER PROCEDURE CountDurasiGate
(
	@user int
)
AS
	DECLARE curGate CURSOR
	FOR
	SELECT waktuGate, statusGate
	FROM rekamGate
	WHERE idUser = @user
	ORDER BY waktuGate ASC

	OPEN curGate

	DECLARE
		@curWaktu datetime,
		@curStatus varchar(5),
		@start datetime,
		@stop datetime,
		@count int = 0

	FETCH NEXT FROM curGate INTO @curWaktu, @curStatus

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
		
		FETCH NEXT FROM curGate INTO @curWaktu, @curStatus
	END

	CLOSE curGate
	DEALLOCATE curGate

	SELECT @count AS [Durasi di dalam kampus dalam menit]