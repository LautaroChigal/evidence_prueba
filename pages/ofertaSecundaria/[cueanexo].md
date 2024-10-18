---
queries:
   - ofertaSecundaria: ofertaSecundaria.sql
---

# {params.cueanexo}

```sql ofertaSecundaria_filtered
select * from ${ofertaSecundaria}
where cueanexo = '${params.cueanexo}'
```

<DataTable data={ofertaSecundaria_filtered}/>
