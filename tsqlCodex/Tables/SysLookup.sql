--https://1avergne.azurewebsites.net/post/2020/02/28/sql-retirer-les-accents-et-caractere-speciaux
CREATE TABLE [dbo].[SysLookup]
(
    [Lookup] [char](1) NOT NULL,
    [Ref] [char](1) NOT NULL
) ON [PRIMARY]