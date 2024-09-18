---
title: Pruebas RA
---

## RA 2024

``` matricula_comun
select * from matOferta
where matOferta.oferta in ('Común - Primaria de 7 años ', 'Común - Secundaria Completa req. 7 años ', 'Común - SNU ', 'Común - Jardín de infantes ')
```

<BarChart 
    data={matricula_comun}
    x=oferta
    y=sum
    yFmt=num0
    series=sector
    type=grouped
    title="Matricula por oferta"
    showAllXAxisLabels=true
    subtitle="Modalidad Común"
/>

<DataTable data={matricula_comun}>
    <Column id=oferta/>
    <Column id=sector/>
    <Column id=sum title=Matricula fmt=num0/>
</DataTable>

``` matricula_adultos
select * from matOferta
where matOferta.oferta in ('Adultos-Formación Profesional/Capacitación Laboral', 'Adultos - Primaria ', 'Adultos - Secundaria Completa')
```

<BarChart 
    data={matricula_adultos}
    x=oferta
    y=sum
    yFmt=num0
    series=sector
    type=grouped
    title="Matricula por oferta"
    showAllXAxisLabels=true
    subtitle="Modalidad Adultos"
/>

<DataTable data={matricula_adultos}>
    <Column id=oferta/>
    <Column id=sector/>
    <Column id=sum title=Matricula fmt=num0/>
</DataTable>