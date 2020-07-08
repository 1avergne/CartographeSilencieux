select s.name + '.' + t.name as [table], sum(p.rows) as [rows]
from sys.partitions p
inner join sys.tables t on t.object_id = p.object_id
inner join sys.schemas s on s.schema_id = t.schema_id
--where t.name in ('dwh_fact_sales')
group by s.name, t.name