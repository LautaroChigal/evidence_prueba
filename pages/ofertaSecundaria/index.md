---
title: Ofertasecundaria
queries:
   - ofertaSecundaria: ofertaSecundaria.sql
---

Click on an item to see more detail


```sql ofertaSecundaria_with_link
select *, '/ofertaSecundaria/' || cueanexo as link
from ${ofertaSecundaria}
```

<DataTable data={ofertaSecundaria_with_link} link=link/>
