---
title: Mas Pruebas RA
---

# RA 2024

``` matricula_grado
select cueanexo, nombre, oferta, sum(matricula) from matGrado
group by cueanexo, nombre, oferta
```

<DataTable data={matricula_grado}/>