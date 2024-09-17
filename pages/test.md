---
title: Pruebas RA
---

# RA 2024

``` matricula_oferta
select * from matOferta
```

<BarChart 
    data={matricula_oferta}
    x=oferta
    y=sum
    series="sector"
    title="Matricula por oferta"
/>

``` matricula_grado
select cueanexo, nombre, oferta, sum(matricula) from matGrado
group by cueanexo, nombre, oferta
```