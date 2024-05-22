ALTER PROCEDURE countPPKMLevel
(
	@level int,
	@nomorGedung int
)
AS
	DECLARE @tbl int


if @level = 1
	SELECT @tbl = 1 * kapasitas
	FROM Gedung
	WHERE @nomorGedung = Gedung.nomorGedung

if @level = 2
	SELECT @tbl = 0.75 * kapasitas
	FROM Gedung
	WHERE @nomorGedung = Gedung.nomorGedung

if @level = 3
	SELECT @tbl = 0.5 * kapasitas
	FROM Gedung
	WHERE @nomorGedung = Gedung.nomorGedung

if @level = 4
	SELECT @tbl = 0.25 * kapasitas
	FROM Gedung
	WHERE @nomorGedung = Gedung.nomorGedung

SELECT @tbl
