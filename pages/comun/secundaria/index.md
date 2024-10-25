---
title: Secundaria
queries:
   - secundaria: secundaria.sql
---

Haga click en una escuela para ver mas detalles.

```sql departamentos
select distinct(departamento) from matSecundaria
```

<Dropdown
  name=dropdown_departamentos
  data={departamentos}
  value=departamento
  title="Seleccione un Departamento"
  defaultValue="CAPITAL"
/>

```sql sectores
select distinct(sector) from matSecundaria
```

<ButtonGroup data={sectores} name=sector_seleccionado value=sector display=buttons title="Seleccione un Sector" defaultValue="Estatal">
  <ButtonGroupItem valueLabel="Ambos" value="Estatal','Privado"/>
</ButtonGroup>

```sql secundaria_with_link
select *, '/comun/secundaria/' || cueanexo as link
from ${secundaria}
where departamento = '${inputs.dropdown_departamentos.value}' and sector in ('${inputs.sector_seleccionado}')
```

<DataTable data={secundaria_with_link} link=link totalRow=true emptyMessage="No hay datos para mostrar" search=true>
   <Column id="cueanexo" totalAgg="Cantidad de Escuelas" align=left/>
   <Column id="cuise" align=left/>
   <Column id="nombre" align=left/>
   <Column id="localidad" align=left/>
   <Column id="ambito" totalAgg=count align=left/>
</DataTable>