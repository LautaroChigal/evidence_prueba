select 
    substr(cueanexo::text, 1, 9) as cueanexo,
    cuise,
    nombre,
    departamento,
    municipio,
    localidad,
    sector,
    ambito,
    telefono,
    email,
    responsable
from primarias