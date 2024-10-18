select cueanexo, nombre, departamento, localidad, sector,
    max(case when grado = '1er Año/Grado' then matricula end) as mat1ro,
    max(case when grado = '2do Año/Grado' then matricula end) as mat2do,
    max(case when grado = '3er Año/Grado' then matricula end) as mat3ro,
    max(case when grado = '4to Año/Grado' then matricula end) as mat4to,
    max(case when grado = '5to Año/Grado' then matricula end) as mat5to,
    max(case when grado = '6to Año/Grado' then matricula end) as mat6to,
from matCompleta where oferta = 'Común - Secundaria Completa req. 7 años '
group by cueanexo, nombre, departamento, localidad, sector