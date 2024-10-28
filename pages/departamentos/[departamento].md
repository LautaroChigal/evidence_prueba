---
queries:
   - departamentos: departamentos.sql
---

# DETALLES DE {params.departamento}

```sql departamentos_filtered
select * from ${departamentos}
where departamento = '${params.departamento}' AND
localidad = '${inputs.selected_item.value}'
```


```sql datos_totales
select * from ${departamentos}
where departamento = '${params.departamento}'
```

## Cantidad de matriculas totales de {params.departamento} por sector y ámbito   

<BarChart
data={filtro}
x=ambito
y=cantidad
series= sector
showAllXAxisLabels = true
colorPalette={
[
'#40b708',
'#fbba24',
]
}
/>



## Cantidad de matriculas de {inputs.selected_item.value} por sector y ámbito  
#
*Seleccione la localidad para ver sus detalles*

<Dropdown
    name=selected_item
    data={localidades_filtered}
    value=localidad
/>

<DataTable data={departamentos_filtered} search=true>
    <Column id=cueanexo fmt=id/>
    <Column id=nombre/>
    <Column id=departamento/>
    <Column id=localidad/>
    <Column id=sector/>
    <Column id=ambito/>
    <Column id=oferta/>
    <Column id=grado/>
    <Column id=matricula/>
</DataTable>

 

<BarChart
data={filtro_localidad}
x=ambito
y=cantidad
series= sector
showAllXAxisLabels = true
colorPalette={
[
'#40b708',
'#fbba24',
]
}
/>

## Cantidad de matriculas de {inputs.selected_item.value} por escuela

<BarChart
data={suma_matricula}
x=nombre
y=total_matricula
showAllXAxisLabels = true
colorPalette={
[
'#40b708',
'#fbba24',
]
}
/>

```sql suma_matricula
SELECT 
  nombre,
  SUM(matricula) AS total_matricula
FROM 
  ${departamentos}
WHERE 
  localidad = '${inputs.selected_item.value}'
GROUP BY 
  nombre;
```

```sql filtro
SELECT
 sector, ambito,
  SUM( matricula) AS cantidad
FROM ${departamentos}
where departamento = '${params.departamento}'
GROUP BY sector, ambito;
```

```sql filtro_localidad
SELECT
 sector, ambito,
  SUM( matricula) AS cantidad
FROM ${departamentos}
where localidad = '${inputs.selected_item.value}'
GROUP BY sector, ambito;
```


```sql localidades_filtered
SELECT localidad, matricula 
FROM ${departamentos}
WHERE departamento = '${params.departamento}'
```

```sql filtro_oferta
SELECT 
  CASE 
    WHEN oferta LIKE '%Común%' THEN 'Común'
    WHEN oferta LIKE '%Adultos%' THEN 'Adultos'
    WHEN oferta LIKE '%Especial%' THEN 'Especial'
  END AS tipo_oferta,
  SUM(matricula) AS total_matricula
FROM ${departamentos}
WHERE (oferta LIKE '%Común%' 
   OR oferta LIKE '%Adultos%' 
   OR oferta LIKE '%Especial%')
   AND departamento = '${params.departamento}'
GROUP BY tipo_oferta;
```

```sql datos_oferta
SELECT 
  CASE 
    WHEN oferta LIKE '%Común%' THEN 'Común'
    WHEN oferta LIKE '%Adultos%' THEN 'Adultos'
    WHEN oferta LIKE '%Especial%' THEN 'Especial'
  END AS donut, 
  SUM(matricula) AS total_matricula
FROM ${departamentos}
WHERE (oferta LIKE '%Común%' 
   OR oferta LIKE '%Adultos%' 
   OR oferta LIKE '%Especial%')
   AND departamento = '${params.departamento}'
GROUP BY donut
```

```sql dona_datos_oferta
SELECT donut AS name, total_matricula AS value
FROM ${datos_oferta} AS datos
```

## Cantidad de matriculas de {params.departamento} por oferta


<ECharts config={{
    tooltip: {
        formatter: '{b}: {c} ({d}%)'
    },
    series: [
        {
            type: 'pie',
            radius: ['40%', '80%'],
            data: [...dona_datos_oferta],  // Asegúrate de que dona_data esté definido correctamente
        }
    ]
}} />

## Cantidad de matriculas de {inputs.selected_localidad.value} por oferta
#
*Seleccione la localidad para ver sus detalles*

<Dropdown
    name=selected_localidad
    data={localidades_filtered}
    value=localidad
/>

```sql datos_oferta_localidad
SELECT 
  CASE 
    WHEN oferta LIKE '%Común%' THEN 'Común'
    WHEN oferta LIKE '%Adultos%' THEN 'Adultos'
    WHEN oferta LIKE '%Especial%' THEN 'Especial'
  END AS donut, 
  SUM(matricula) AS total_matricula
FROM ${departamentos}
WHERE (oferta LIKE '%Común%' 
   OR oferta LIKE '%Adultos%' 
   OR oferta LIKE '%Especial%')
   AND departamento = '${params.departamento}'
   AND localidad = '${inputs.selected_localidad.value}'
GROUP BY donut
```

```sql dona_datos_oferta_localidad
SELECT donut AS name, total_matricula AS value
FROM ${datos_oferta_localidad} AS datos
```

<ECharts config={{
    tooltip: {
        formatter: '{b}: {c} ({d}%)'
    },
    series: [
        {
            type: 'pie',
            radius: ['40%', '80%'],
            data: [...dona_datos_oferta_localidad],  // Asegúrate de que dona_data esté definido correctamente
        }
    ]
}} />

## Cantidad de matriculas totales de {params.departamento} por ofertas en cada sector

<SankeyDiagram 
    data={tabla} 
    sourceCol="source"
    targetCol="target"
    valueCol="value"
/>

```sql tabla
SELECT 
    'Estatal' AS source, 
    CASE 
        WHEN oferta LIKE '%Común%' THEN 'Común'
        WHEN oferta LIKE '%Adultos%' THEN 'Adultos'
        WHEN oferta LIKE '%Especial%' THEN 'Especial'
    END AS target, 
    SUM(matricula) AS value 
FROM 
    ${departamentos}
WHERE 
    sector = 'Estatal' 
    AND (oferta LIKE '%Común%' 
         OR oferta LIKE '%Adultos%' 
         OR oferta LIKE '%Especial%')
    AND departamento = '${params.departamento}'
GROUP BY 
    target

UNION ALL

SELECT 
    'Privado' AS source, 
    CASE 
        WHEN oferta LIKE '%Común%' THEN 'Común'
        WHEN oferta LIKE '%Adultos%' THEN 'Adultos'
        WHEN oferta LIKE '%Especial%' THEN 'Especial'
    END AS target, 
    SUM(matricula) AS value 
FROM 
    ${departamentos}
WHERE 
    sector = 'Privado' 
    AND (oferta LIKE '%Común%' 
         OR oferta LIKE '%Adultos%' 
         OR oferta LIKE '%Especial%')
    AND departamento = '${params.departamento}'
GROUP BY 
    target
```

## Cantidad de matriculas de {inputs.selected_localidad_sankey.value} por ofertas en cada sector
#
*Seleccione la localidad para ver sus detalles*

<Dropdown
    name=selected_localidad_sankey
    data={localidades_filtered}
    value=localidad
/>

```sql tabla_localidad
SELECT 
    'Estatal' AS source, 
    CASE 
        WHEN oferta LIKE '%Común%' THEN 'Común'
        WHEN oferta LIKE '%Adultos%' THEN 'Adultos'
        WHEN oferta LIKE '%Especial%' THEN 'Especial'
    END AS target, 
    SUM(matricula) AS value 
FROM 
    ${departamentos}
WHERE 
    sector = 'Estatal' 
    AND (oferta LIKE '%Común%' 
         OR oferta LIKE '%Adultos%' 
         OR oferta LIKE '%Especial%')
    AND departamento = '${params.departamento}'
    AND localidad = '${inputs.selected_localidad_sankey.value}'
GROUP BY 
    target

UNION ALL

SELECT 
    'Privado' AS source, 
    CASE 
        WHEN oferta LIKE '%Común%' THEN 'Común'
        WHEN oferta LIKE '%Adultos%' THEN 'Adultos'
        WHEN oferta LIKE '%Especial%' THEN 'Especial'
    END AS target, 
    SUM(matricula) AS value 
FROM 
    ${departamentos}
WHERE 
    sector = 'Privado' 
    AND (oferta LIKE '%Común%' 
         OR oferta LIKE '%Adultos%' 
         OR oferta LIKE '%Especial%')
    AND departamento = '${params.departamento}'
    AND localidad = '${inputs.selected_localidad_sankey.value}'
GROUP BY 
    target
```

<SankeyDiagram 
    data={tabla_localidad} 
    sourceCol="source"
    targetCol="target"
    valueCol="value"
/>

<DataTable data={filtro_localidad_sector} search=true> 
     <Column id=oferta/>  
	<Column id=sector/> 
	<Column id=localidad/>
    <Column id=cantidad_matriculas contentType=colorscale scaleColor=green/>  
</DataTable>

```sql filtro_localidad_sector
SELECT
  sector,
  localidad,
  oferta_filtrada AS oferta,
  SUM(matricula) AS cantidad_matriculas
FROM 
(
  SELECT
    sector,
    localidad,
    CASE 
      WHEN oferta LIKE '%Común%' THEN 'Común'
      WHEN oferta LIKE '%Adultos%' THEN 'Adultos'
      WHEN oferta LIKE '%Especial%' THEN 'Especial'
    END AS oferta_filtrada,
    matricula
  FROM 
    ${departamentos}
  WHERE 
    departamento = '${params.departamento}'
    AND (oferta LIKE '%Común%' 
         OR oferta LIKE '%Adultos%' 
         OR oferta LIKE '%Especial%')
) AS subquery
GROUP BY 
  localidad, sector, oferta_filtrada;
```

<DataTable data={filtro_localidad_sector} groupBy="localidad">
    <Column id="localidad"/> 
    <Column id="sector" totalAgg="count"/> 
    <Column id="oferta" totalAgg="count"/> 
    <Column id="cantidad_matriculas" totalAgg="sum" fmt="number"/> 
</DataTable>
