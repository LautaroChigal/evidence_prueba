---
queries:
   - primaria: primaria.sql
---

# {params.cueanexo}

```sql primaria_filtered
select * from ${primaria}
where cueanexo = '${params.cueanexo}'
```

<DataTable data={primaria_filtered}/>
