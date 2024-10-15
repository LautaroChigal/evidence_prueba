---
title: Relevamiento Anual
---

Esta página tiene como objetivo mantener todas las pruebas de visualización de datos que se hagan antes de lanzar la página oficial.

## Resumen

```sql matricula_comun
select matricula2024, (matricula2024-matricula2023)/matricula2023 as variacion from matModalidad
where modalidad = 'Común'
```

```sql matricula_adultos
select matricula2024, (matricula2024-matricula2023)/matricula2023 as variacion from matModalidad
where modalidad = 'Adultos'
```

```sql matricula_especial
select matricula2024, (matricula2024-matricula2023)/matricula2023 as variacion from matModalidad
where modalidad = 'Especial'
```

<BigValue 
  data={matricula_comun}
  title="Matricula Común" 
  value=matricula2024
  comparison=variacion
  comparisonFmt=pct1
  comparisonTitle="con respecto a 2023"
/>

<BigValue 
  data={matricula_adultos}
  title="Matricula Adultos" 
  value=matricula2024
  fmt=num0
  comparison=variacion
  comparisonFmt=pct1
  comparisonTitle="con respecto a 2023"
/>

<BigValue 
  data={matricula_especial}
  title="Matricula Especial" 
  value=matricula2024
  comparison=variacion
  comparisonFmt=pct1
  comparisonTitle="con respecto a 2023"
/>

## Matricula por escuela

```sql solo_ofertas
select oferta from matricula
group by 1
```

<Dropdown
  name=oferta_seleccionada
  data={solo_ofertas}
  value=oferta
  title="Seleccione una Oferta"
  defaultValue="Común - Primaria de 7 años "
/>

```sql matricula_completa
select cueanexo, nombre, sum(matricula) from matricula
where oferta = '${inputs.oferta_seleccionada.value}'
group by cueanexo, nombre
order by cueanexo
```

<DataTable data={matricula_completa}>
  <Column id="cueanexo" fmt=id/>
  <Column id="nombre"/>
  <Column id="sum(matricula)" title="Matricula Total"/>  
</DataTable>

## Evolución de Matricula

```sql ofertas_anio
select oferta from matAnio
group by 1
```

<Dropdown
  name=oferta_anio
  data={ofertas_anio}
  value=oferta
  title="Seleccione una Oferta"
  defaultValue="Común - Primaria de 7 años "
/>

```sql matricula_anio
select oferta, año, sum(matricula) from matAnio
where oferta = '${inputs.oferta_anio.value}'
group by oferta, año
```

<LineChart 
  data={matricula_anio}
  x=año
  y=sum(matricula)
  yFmt=num0
  yScale=true
  echartsOptions={{xAxis: {
      type: 'category',
      boundaryGap: false,
    }
  }}
  series=oferta
/>

## Matricula Secundaria por Departamento

Haga click en un Departamento para ver la matricula detallada en el cuadro debajo.

```sql matricula_departamento
select departamento, sum(mat_secundaria) from matDepartamento
group by 1
```

<AreaMap 
  data={matricula_departamento} 
  areaCol=departamento
  geoJsonUrl=https://raw.githubusercontent.com/mgaitan/departamentos_argentina/refs/heads/master/departamentos-misiones.json
  geoId=departamento
  value=sum(mat_secundaria)
  borderWidth=2
  height=600
  name=mapaMisiones
/>

```sql departamento_seleccionado
select cueanexo, nombre, sum(mat_secundaria) from matDepartamento
where departamento = '${inputs.mapaMisiones.departamento}'
group by cueanexo, nombre
```

<DataTable data={departamento_seleccionado}>
  <Column id="cueanexo" fmt=id/>
  <Column id="nombre"/>
  <Column id="sum(mat_secundaria)" title="Matricula Total"/>  
</DataTable>