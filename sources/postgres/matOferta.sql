select ot.descripcion as oferta, st.descripcion as sector, sum(al.total) as matricula from ra2024.localizacion l 
inner join ra2024.establecimiento e on l.id_establecimiento = e.id_establecimiento
inner join ra2024.oferta_local ol on l.id_localizacion = ol.id_localizacion
inner join ra2024.plan_dictado pd on ol.id_oferta_local = pd.id_oferta_local
inner join ra2024.alumnos al on pd.id_plan_dictado = al.id_plan_dictado
inner join codigos.oferta_tipo ot on ol.c_oferta = ot.c_oferta
inner join codigos.sector_tipo st on e.c_sector = st.c_sector
where al.c_alumno = 1
group by ot.descripcion, st.descripcion
order by ot.descripcion, st.descripcion