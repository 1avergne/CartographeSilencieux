--utilise une requête CTE récursive pour concaténer les valeurs d'une colonne en faisant les regroupement sur une autre colonne.

IF OBJECT_ID('tempdb..#t') is not null drop table #t

create table #t (
	k int,
	v nvarchar(55)
);

insert into #t values
(1, 'a')
, (1, 'b')
, (2, 'g')
, (3, 'k')
, (1, 'c')
, (2, 'h')
, (2, 'i')
, (1, 'd')
, (3, 'l')
, (3, 'm')
, (1, 'e')
, (2, 'j')
, (1, 'f')
;

with t0 as (
select k, v
	, RANK() over (partition by k order by v desc) as r
from #t
)

, t1 as (select k, convert(nvarchar(55), '') as v, max(r) + 1 as r
from t0
group by k
union all select t1.k, convert(nvarchar(55), t1.v + t0.v), t0.r
from t1 inner join t0 on t0.k = t1.k and t0.r = t1.r - 1
)

select k, v from t1 where r = 1