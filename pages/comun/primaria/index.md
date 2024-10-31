---
title: Primaria
queries:
   - primaria: primaria.sql
---

Click on an item to see more detail


```sql primaria_with_link
select *, '/comun/primaria/' || cueanexo as link
from ${primaria}
```

<DataTable data={primaria_with_link} link=link/>
