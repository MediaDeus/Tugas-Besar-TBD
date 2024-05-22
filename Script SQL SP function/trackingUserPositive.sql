ALTER PROCEDURE TrackingUserPositive
(
    @idUser int
)
AS
    DECLARE @tabelUserPositive table(
        id int,
        noGedung int,
        waktuMasuk datetime,
        waktuKeluar datetime
    )

    DECLARE curTrackingPositive CURSOR
    FOR
    SELECT rekamGedung.idUser, rekamGedung.nomorGedung, rekamGedung.waktuGedung, rekamGedung.statusGedung
    FROM rekamGedung
    WHERE rekamGedung.idUser = @idUser
    ORDER BY waktuGedung ASC

    OPEN curTrackingPositive

    DECLARE
        @curId int,
        @noGedung int,
        @curWaktu datetime,
        @curStatus varchar(5),
        @masuk datetime,
        @keluar datetime,
        @prevId int,
        @prevWaktu datetime,
        @prevStatus varchar(5)
        SET @prevId = @curId
        SET @prevWaktu = @curWaktu
        SET @prevStatus = @curStatus

    FETCH NEXT FROM curTrackingPositive INTO @curId, @noGedung, @curWaktu, @curStatus
    SET @prevId = @curId
    SET @prevWaktu = @curWaktu
    SET @prevStatus = @curStatus

    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        IF (@curStatus = 'in')
        BEGIN
            SET @masuk = @curWaktu
        END
        ELSE
        BEGIN
            SET @keluar = @curWaktu
            INSERT INTO @tabelUserPositive
            SELECT id = @curId, noGedung = @noGedung, waktuMasuk = @masuk, waktuKeluar = @keluar
        END

        FETCH NEXT FROM curTrackingPositive INTO @curId, @noGedung, @curWaktu, @curStatus
    END
    CLOSE curTrackingPositive
    DEALLOCATE curTrackingPositive

    SELECT * FROM @tabelUserPositive