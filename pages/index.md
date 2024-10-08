---
title: Relevamiento Anual
---

<Details title='Sobre esta página'>
  Esta página tiene como objetivo mantener todas las pruebas de visualización de datos que se hagan antes de lanzar la página oficial.
</Details>

```sql solo_ofertas
select oferta from matricula
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