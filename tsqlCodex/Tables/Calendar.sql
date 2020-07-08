--https://1avergne.azurewebsites.net/post/2020/06/11/t-sql-creer-une-table-calendrier
CREATE TABLE [dbo].[Calendar](
    [date] [date] NOT NULL,
    [day]  AS (datepart(day,[date])),
    [month_num]  AS (datepart(month,[date])),
    [month]  AS (datename(month,[date])),
    [year_month_num]  AS (CONVERT([int],format([date],'yyyyMM'))),
    [year_month]  AS (format([date],'MMMM yyyy')),
    [week]  AS (datepart(week,[date])),
    [iso_week]  AS (datepart(iso_week,[date])),
    [day_of_week]  AS (datepart(weekday,[date])),
    [quarter]  AS (datepart(quarter,[date])),
    [year]  AS (datepart(year,[date])),
PRIMARY KEY CLUSTERED 
(
    [date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]