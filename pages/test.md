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