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

<DataTable data={matricula_completa} search=true totalRow=true rowShading=true>
  <Column id="cueanexo" fmt=id totalAgg="Total Oferta" align=left/>
  <Column id="nombre" align=left/>
  <Column id="sum(matricula)" title="Matricula Total" align=right/>  
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

## Matricula por Departamento

Haga click en un Departamento para ver la matricula detallada en el cuadro debajo.

```sql ofertas_mapa
select oferta from matCompleta
group by 1
```

<Dropdown
  name=oferta_mapa
  data={ofertas_mapa}
  value=oferta
  title="Seleccione una Oferta"
  defaultValue="Común - Primaria de 7 años "
/>

```sql matricula_departamento
select departamento, sum(matricula) as matricula from matCompleta
where oferta = '${inputs.oferta_mapa.value}'
group by 1
```

<AreaMap 
  data={matricula_departamento} 
  areaCol=departamento
  geoJsonUrl=https://raw.githubusercontent.com/mgaitan/departamentos_argentina/refs/heads/master/departamentos-misiones.json
  geoId=departamento
  value=matricula
  borderWidth=2
  height=600
  name=mapaMisiones
/>

```sql localidades
select localidad from matCompleta
where departamento = '${inputs.mapaMisiones.departamento}'
group by 1
```

<Dropdown
  name=localidad_seleccionada
  data={localidades}
  value=localidad
  multiple=true
  title="Seleccione Localidades"
/>

```sql sectores
select sector from matCompleta
group by 1
```

<ButtonGroup data={sectores} name=sector_seleccionado value=sector display=buttons title="Seleccione un Sector" defaultValue="Estatal">
  <ButtonGroupItem valueLabel="Ambos" value="Estatal','Privado"/>
</ButtonGroup>

```sql departamento_seleccionado
select cueanexo, nombre, localidad, ambito, sum(matricula) as matricula from matCompleta
where 
  departamento = '${inputs.mapaMisiones.departamento}' and 
  localidad in ${inputs.localidad_seleccionada.value} and
  oferta = '${inputs.oferta_mapa.value}' and
  sector in ('${inputs.sector_seleccionado}')
group by cueanexo, nombre, localidad, ambito
```

<DataTable data={departamento_seleccionado} search=true totalRow=true rowShading=true emptyMessage="No hay datos para mostrar">
  <Column id="cueanexo" fmt=id totalAgg="Total Escuelas" align=left/>
  <Column id="nombre" totalAgg=nombre align=left/>
  <Column id="localidad"  align=left/>
  <Column id="ambito"  align=left/>
  <Column id="matricula" title="Matricula" align=right/>  
</DataTable>