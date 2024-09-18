---
title: Mas Pruebas RA
---

# RA 2024

``` matricula_grado
select cueanexo, nombre, oferta, sum(matricula) from matGrado
group by cueanexo, nombre, oferta
```

<DataTable data={matricula_grado}>
    <Column id=cueanexo fmt=id/>
    <Column id=nombre/>
    <Column id=oferta/>
    <Column id=sum(matricula) title="Matricula Total"/>
</DataTable>