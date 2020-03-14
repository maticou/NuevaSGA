CREATE OR REPLACE FUNCTION obtener_cursos_docente(
	_cedula docente.cedula%TYPE
	) RETURNS TABLE (
		nombre_curso curso.nombre%TYPE,
		id_instancia instancia_curso.id%TYPE,
		seccion instancia_curso.seccion%TYPE,
		anio instancia_curso.anio%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT curso.nombre AS nombre_curso,
	instancia_curso.id AS id_instancia,
	instancia_curso.seccion AS seccion,
	instancia_curso.anio AS anio
	FROM curso, instancia_curso
	WHERE instancia_curso.docente = _cedula
	AND instancia_curso.curso = curso.id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_alumnos_curso(
		_id_instancia instancia_curso.id%TYPE
	) RETURNS TABLE (
		matricula alumno.num_matricula%TYPE,
		nombre alumno.nombre_completo%TYPE,
		email alumno.email%TYPE,
		nota alumno_instancia_curso.nota_final%TYPE,
		situacion alumno_instancia_curso.situacion%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT alumno.num_matricula AS matricula,
	alumno.nombre_completo AS nombre,
	alumno.email AS email,
	alumno_instancia_curso.nota_final AS nota,
	alumno_instancia_curso.situacion AS situacion
	FROM alumno, alumno_instancia_curso
	WHERE alumno_instancia_curso.id = _id_instancia;
END;
$$ LANGUAGE plpgsql;