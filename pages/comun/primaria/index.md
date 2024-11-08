---
title: Primaria
queries:
   - primaria: primaria.sql
---

```sql primaria_hidden
select *, '/comun/primaria/' || cueanexo as link
from ${primaria}
```

{#each primaria_hidden as row}

<a href={row.link}/>

{/each}

## Ver datos por escuela

Haga click en una escuela en el siguiente cuadro para ver mas detalles.

```sql departamentos
select distinct(departamento) from primarias
```

<Dropdown
  name=dropdown_departamentos
  data={departamentos}
  value=departamento
  title="Seleccione un Departamento"
  defaultValue="CAPITAL"
/>

```sql sectores
select distinct(sector) from primarias
```

<ButtonGroup data={sectores} name=sector_seleccionado value=sector display=buttons title="Seleccione un Sector" defaultValue="Estatal">
  <ButtonGroupItem valueLabel="Ambos" value="Estatal','Privado"/>
</ButtonGroup>

```sql primaria_with_link
select *
from ${primaria_hidden}
where departamento = '${inputs.dropdown_departamentos.value}' and sector in ('${inputs.sector_seleccionado}')
```

<DataTable data={primaria_with_link} link=link totalRow=true emptyMessage="No hay datos para mostrar" search=true>
   <Column id="cueanexo" totalAgg="Cantidad de Escuelas" align=left/>
   <Column id="cuise" align=left/>
   <Column id="nombre" align=left/>
   <Column id="municipio" align=left/>
   <Column id="ambito" totalAgg=count align=left/>
</DataTable>

## Alumnos Extranjeros

```sql alumnos_extranjeros
select origen, sum(total) as total from alumExtranjeros
group by origen
```

<BarChart 
    data={alumnos_extranjeros}
    x=origen
    y=total
    swapXY=true
/>

```sql origenes
select distinct(origen) from alumExtranjeros
order by origen asc
```

<ButtonGroup
  name=origen_seleccionado  
  data={origenes}
  value=origen
  defaultValue="Paraguay"
  title="Seleccione un origen"
/>

```sql escuelas_con_extranjeros
select cueanexo, nombre, sector, ambito, sum(total) as total from alumExtranjeros
where origen = '${inputs.origen_seleccionado}'
group by cueanexo, nombre, sector, ambito
```

<DataTable data={escuelas_con_extranjeros} totalRow=true emptyMessage="No hay datos para mostrar" search=true>
   <Column id="cueanexo" totalAgg="Total de Alumnos Extranjeros" fmt=id align=left/>
   <Column id="nombre" align=left/>
   <Column id="sector" align=left/>
   <Column id="ambito" align=left/>
   <Column id="total" align=right/>
</DataTable>