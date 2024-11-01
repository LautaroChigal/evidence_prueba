---
queries:
   - primaria: primaria.sql
---

```sql primaria_filtered
select * from ${primaria}
where cueanexo = '${params.cueanexo}'
```

# <Value data={primaria_filtered} column=nombre/> 

<Accordion class="rounded-xl bg-gray-50 px-4 mt-4">
  <AccordionItem title="Ver Detalles" class="border-none">

      **Cueanexo:** _<Value data={primaria_filtered} column=cueanexo/>_

      **Cuise:** _<Value data={primaria_filtered} column=cuise/>_

      **Departamento:** _<Value data={primaria_filtered} column=departamento/>_

      **Municipio:** _<Value data={primaria_filtered} column=municipio/>_

      **Localidad:** _<Value data={primaria_filtered} column=localidad/>_

      **Sector:** _<Value data={primaria_filtered} column=sector/>_

      **Ambito:** _<Value data={primaria_filtered} column=ambito/>_

      **Responsable:** _<Value data={primaria_filtered} column=responsable/>_

      **Email:** _<Value data={primaria_filtered} column=email/>_

      **Telefono:** _<Value data={primaria_filtered} column=telefono/>_

   </AccordionItem>
</Accordion>

## Matricula y Repitentes Total

```sql matricula_repitentes
select 'Matricula' as pie, sum(matricula) as count from matricula
where cueanexo = '${params.cueanexo}' and oferta = 'Común - Primaria de 7 años '
union all
select 'Repitentes' as pie, sum(repitentes) as count from matricula
where cueanexo = '${params.cueanexo}' and oferta = 'Común - Primaria de 7 años '
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
where cueanexo = '${params.cueanexo}' and oferta = 'Común - Primaria de 7 años '
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