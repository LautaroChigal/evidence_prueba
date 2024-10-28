---
title: Departamentos
queries:
   - departamentos: departamentos.sql
---

Haga click en el departamento para ver sus detalles


```sql departamentos_with_link
select *, '/departamentos/' || departamento as link
from ${departamentos}
```

<AreaMap 
    data={matriculas_departamento}
    areaCol="departamento"
    geoJsonUrl='https://raw.githubusercontent.com/mgaitan/departamentos_argentina/refs/heads/master/departamentos-misiones.json'
    geoId="departamento"
    value="total_matricula"
    height={600}
    tooltipType=click
        tooltip={[
        {id: 'departamento', fmt: 'id', showColumnName: false, valueClass: 'text-xl font-semibold'},
        {id: 'total_matricula', fmt: 'id', fieldClass: 'text-[grey]', valueClass: 'text-[green]'},
        {id: 'departamento', showColumnName: false, contentType: 'link', linkLabel: 'Ver detalles', valueClass: 'font-bold mt-1'}
    ]}
/>


```sql matriculas_departamento
SELECT
  departamento,
  SUM(matricula) AS total_matricula
FROM matCompleta
GROUP BY departamento;
```