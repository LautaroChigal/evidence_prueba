---
queries:
   - secundaria: secundaria.sql
---

```sql secundaria_filtered
select * from ${secundaria}
where cueanexo = '${params.cueanexo}'
```

# <Value data={secundaria_filtered} column=nombre/> 

<Details title="Ver Detalles">

**Cueanexo:** _<Value data={secundaria_filtered} column=cueanexo/>_

**Cuise:** _<Value data={secundaria_filtered} column=cuise/>_

**Departamento:** _<Value data={secundaria_filtered} column=departamento/>_

**Localidad:** _<Value data={secundaria_filtered} column=localidad/>_

**Sector:** _<Value data={secundaria_filtered} column=sector/>_

**Ambito:** _<Value data={secundaria_filtered} column=ambito/>_

</Details>

## Matricula y Repitentes Total

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

## Matricula y Repitentes por Grado

```sql matricula_grado
select grado, tipo_alumno, total from matGrado
where cueanexo = '${params.cueanexo}' and oferta = 'Común - Secundaria Completa req. 7 años '
```

<BarChart 
    data={matricula_grado}
    x=grado
    y=total
    series=tipo_alumno
    type=grouped
    sort=false
    showAllXAxisLabels=true
/>

## Egresados por Titulo

```sql egresados
select titulo, egresados from egresadosSecundaria
where cueanexo = '${params.cueanexo}'
```

<BarChart 
    data={egresados}
    x=titulo
    y=egresados
    swapXY=true
    sort=false
/>