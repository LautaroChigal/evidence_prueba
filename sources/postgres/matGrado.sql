select 
	e.cue||l.anexo as cueanexo, 
	l.nombre, st.descripcion as sector, 
	ot.descripcion as oferta,
	gt.descripcion as grado,
	s.nombre as seccion, 
	tt.descripcion as turno,
	tst.descripcion as tipo,
	al.total as matricula 
from ra2024.establecimiento e 
	inner join ra2024.localizacion l on e.id_establecimiento = l.id_establecimiento
	inner join ra2024.oferta_local ol on l.id_localizacion = ol.id_localizacion
	inner join ra2024.plan_dictado pd on ol.id_oferta_local = pd.id_oferta_local
	inner join ra2024.alumnos al on pd.id_plan_dictado = al.id_plan_dictado
	inner join ra2024.seccion s on al.id_seccion = s.id_seccion
	inner join codigos.sector_tipo st on e.c_sector = st.c_sector
	inner join codigos.turno_tipo tt on s.c_turno = tt.c_turno
	inner join codigos.grado_oferta_tipo got on al.c_grado_oferta = got.c_grado_oferta
	inner join codigos.grado_tipo gt on got.c_grado = gt.c_grado
	inner join codigos.oferta_tipo ot on got.c_oferta = ot.c_oferta
	inner join codigos.tipo_seccion_tipo tst on s.c_tipo_seccion = tst.c_tipo_seccion
where ol.c_oferta in (100, 101, 105, 111) and al.c_alumno = 1
order by cueanexo, grado, seccion