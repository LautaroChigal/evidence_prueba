select 
    substr(cueanexo::text, 1, 9) as cueanexo,
    cuise,
    nombre,
    localidad,
    departamento,
    sector,
    ambito,
    matricula,
    repitentes
from matSecundaria