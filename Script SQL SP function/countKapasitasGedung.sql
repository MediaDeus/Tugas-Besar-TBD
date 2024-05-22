ALTER PROCEDURE CountKapasitasGedung(
    @noGedung int,
	@level int
)
AS
    DECLARE @in int
	DECLARE @out int
	DECLARE @current int
	DECLARE @kapasitas int

	SELECT @in = count(idUser)
	FROM rekamGedung
	WHERE statusGedung = 'in'

	SELECT @out = count(idUser)
	FROM rekamGedung
	WHERE statusGedung = 'out'

	exec @kapasitas = countPPKMLevel @level, @noGedung
	
	SET @current = @in - @out

	IF(@current >= @kapasitas)
	BEGIN
		SELECT 'Penuh'
		RETURN
	END
	ELSE
	BEGIN
		SELECT 'Tersedia'
		RETURN
	END

