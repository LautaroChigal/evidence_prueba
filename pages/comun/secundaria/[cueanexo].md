---
queries:
   - secundaria: secundaria.sql
---

```sql secundaria_filtered
select * from ${secundaria}
where cueanexo = '${params.cueanexo}'
```

# <Value data={secundaria_filtered} column=nombre/> 

<DataTable data={secundaria_filtered}/>

```sql matricula_repitentes
select 'Matricula' as pie, matricula as count from matSecundaria
where cueanexo = '${params.cueanexo}'
union all
select 'Repitentes' as pie, repitentes as count from matSecundaria
where cueanexo = '${params.cueanexo}'
```

```sql pie_data
select pie as name, count as value
from ${matricula_repitentes}
```

<ECharts config={
   {
      tooltip: {
         formatter: '{b}: {c} ({d}%)'
      },
      series: [
         {
            type: 'pie',
            radius: ['40%', '70%'],
            data: [...pie_data],
         }
      ]
   }
}/>