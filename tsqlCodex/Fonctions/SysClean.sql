--https://1avergne.azurewebsites.net/post/2020/02/28/sql-retirer-les-accents-et-caractere-speciaux
CREATE FUNCTION [dbo].[SysClean]
(
    @label nvarchar(255)
)
RETURNS varchar(255)
AS
BEGIN
     
    DECLARE @i int = 0
    DECLARE @t table(k int, c char)
    DECLARE @l2 varchar(255)
    DECLARE @l3 varchar(255) = ''
    select @l2 = LOWER(convert(VARCHAR(255), @label))   -- collate SQL_Latin1_General_Cp1251_CS_AS
 
    while @i < LEN(@l2)
    begin
        select @i = @i+1
        insert into @t values(@i, CONVERT(char, SUBSTRING(@l2, @i, 1)))
    end
 
    select @l3 = @l3 + convert(varchar(255), l.[Ref])
    from @t t
    inner join [dbo].[SysLookup] l on l.[Lookup] = t.[c]
    order by t.k
 
    RETURN @l3
END