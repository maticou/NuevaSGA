CREATE OR REPLACE FUNCTION promedio_de_notas_por_curso(
	) RETURNS TABLE (
		nombre curso.nombre%TYPE,
		seccion instancia_curso.seccion%TYPE,
		anio instancia_curso.anio%TYPE,
		periodo tipo_periodo.tipo%TYPE,
		promedio_nota_final DECIMAL(10,0)
	) AS $$
BEGIN
	RETURN QUERY
	SELECT curso.nombre AS nombre,
	instancia_curso.seccion AS seccion,
	instancia_curso.anio AS anio,
	tipo_periodo.tipo AS periodo,
	CAST(AVG(alumno_instancia_curso.nota_final) AS DECIMAL(10,0)) AS promedio_nota_final
	FROM alumno, curso, instancia_curso, alumno_instancia_curso, tipo_periodo
	WHERE alumno.num_matricula=alumno_instancia_curso.alumno
	AND alumno_instancia_curso.instancia_curso=instancia_curso.id
	AND instancia_curso.curso=curso.id
	AND tipo_periodo.id=instancia_curso.periodo
	GROUP BY instancia_curso.id, curso.nombre, alumno_instancia_curso.nota_final, tipo_periodo.tipo
	ORDER BY nombre ASC, seccion ASC, anio ASC;
END;
$$ LANGUAGE plpgsql;