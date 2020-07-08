--https://1avergne.azurewebsites.net/post/2020/06/24/t-sql-convertir-les-caracteres-ascii-du-code-hexa-au-symbole
CREATE FUNCTION [dbo].[ReplaceHex] (@str NVARCHAR(max))
RETURNS NVARCHAR(max)
AS
BEGIN
    DECLARE @res NVARCHAR(max) = ''
    DECLARE @uchar NVARCHAR(3)
    DECLARE @i INT = PATINDEX('%[$][0-7][0123456789ABCDEF]%', UPPER(@str))
 
    WHILE @i > 0
    BEGIN
        SELECT @res += LEFT(@str, @i - 1)
            ,@uchar = UPPER(SUBSTRING(@str, @i, 3))
            ,@str = SUBSTRING(@str, @i + 3, LEN(@str))
 
        SELECT @res += CHAR((16 * convert(INT, SUBSTRING(@uchar, 2, 1))) + isnull(try_convert(INT, SUBSTRING(@uchar, 3, 1)), ascii(SUBSTRING(@uchar, 3, 1)) - 55))
            ,@i = PATINDEX('%[$][0-7][0123456789ABCDEF]%', @str)
    END
 
    SELECT @res += @str
 
    RETURN @res
END