CREATE OR REPLACE FUNCTION obtener_cursos_alumno(
	_matricula alumno.num_matricula%TYPE
) RETURNS TABLE(
	id_instancia instancia_curso.id%TYPE,
	nombre_curso curso.nombre%TYPE,
	seccion instancia_curso.seccion%TYPE,
	periodo tipo_periodo.tipo%TYPE,
	anio instancia_curso.anio%TYPE,
	nota_final alumno_instancia_curso.nota_final%TYPE,
	situacion situacion_alumno_instancia_curso.situacion%TYPE
) AS $$
BEGIN
	RETURN QUERY
	SELECT instancia_curso.id AS id_instancia,
	curso.nombre AS nombre_curso,
	instancia_curso.seccion AS seccion,
	tipo_periodo.tipo AS periodo,
	instancia_curso.anio AS anio,
	alumno_instancia_curso.nota_final AS nota_final,
	situacion_alumno_instancia_curso.situacion AS situacion
	FROM instancia_curso, alumno_instancia_curso,
	situacion_alumno_instancia_curso, curso, tipo_periodo
	WHERE alumno_instancia_curso.alumno = _matricula
	AND alumno_instancia_curso.instancia_curso = instancia_curso.id
	AND instancia_curso.curso = curso.id
	AND alumno_instancia_curso.situacion = situacion_alumno_instancia_curso.id
	AND instancia_curso.periodo = tipo_periodo.id;
END;
$$ LANGUAGE plpgsql;