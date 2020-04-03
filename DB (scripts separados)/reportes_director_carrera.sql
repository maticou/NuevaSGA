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


CREATE OR REPLACE FUNCTION docentes_con_notas_atrasadas(
	) RETURNS TABLE (
		docente docente.cedula%TYPE,
		nombre docente.nombre_completo%TYPE,
		curso curso.nombre%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT docente.cedula AS docente,
	docente.nombre_completo AS nombre,
	curso.nombre AS curso
	FROM evaluacion, instancia_curso, instancia_evaluacion, docente, curso, tipo_evaluacion
	WHERE evaluacion.fecha <now()::date
	AND instancia_evaluacion.evaluacion = evaluacion.id
	AND instancia_curso.id = evaluacion.instancia_curso
	AND instancia_curso.docente = docente.cedula
	AND instancia_evaluacion.nota <10
	GROUP BY docente.nombre_completo, curso.nombre, docente.cedula
	ORDER BY nombre ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION docentes_con_notas_al_dia(
	) RETURNS TABLE (
		docente docente.cedula%TYPE,
		nombre docente.nombre_completo%TYPE,
		curso curso.nombre%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT docente.cedula AS docente,
	docente.nombre_completo AS nombre,
	curso.nombre AS curso
	FROM evaluacion, instancia_curso, instancia_evaluacion, docente, curso, tipo_evaluacion
	WHERE evaluacion.fecha <now()::date
	AND instancia_evaluacion.evaluacion = evaluacion.id
	AND instancia_curso.id = evaluacion.instancia_curso
	AND instancia_curso.docente = docente.cedula
	AND instancia_evaluacion.nota >9
	GROUP BY docente.nombre_completo, curso.nombre, docente.cedula
	ORDER BY nombre ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION cursos_con_situacion_alumnos(
	) RETURNS TABLE (
		curso curso.nombre%TYPE,
		periodo tipo_periodo.tipo%TYPE,
		anio instancia_curso.anio%TYPE,
		seccion instancia_curso.seccion%TYPE,
		alumno alumno_instancia_curso.alumno%TYPE,
		nombre_alumno alumno.nombre_completo%TYPE,
		situacion situacion_alumno_instancia_curso.situacion%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT curso.nombre AS curso,
	tipo_periodo.tipo AS periodo,
	instancia_curso.anio AS anio,
	instancia_curso.seccion AS seccion,
	alumno_instancia_curso.alumno AS alumno,
	alumno.nombre_completo AS nombre_alumno,
	situacion_alumno_instancia_curso.situacion AS situacion
	FROM alumno_instancia_curso, alumno, curso, instancia_curso, situacion_alumno_instancia_curso, tipo_periodo
	WHERE curso.id = instancia_curso.curso
	AND alumno_instancia_curso.instancia_curso = instancia_curso.id
	AND situacion_alumno_instancia_curso.id = alumno_instancia_curso.situacion
	AND tipo_periodo.id = instancia_curso.periodo
	AND alumno_instancia_curso.alumno = alumno.num_matricula
	ORDER BY curso ASC, anio ASC, seccion ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION promedio_de_notas_por_docente(
	) RETURNS TABLE (
		cedula docente.cedula%TYPE,
		docente docente.nombre_completo%TYPE,
		curso curso.nombre%TYPE,
		seccion instancia_curso.seccion%TYPE,
		anio instancia_curso.anio%TYPE,
		periodo tipo_periodo.tipo%TYPE,
		alumno alumno.num_matricula%TYPE,
		promedio_nota_final DECIMAL(10,0),
		situacion situacion_alumno_instancia_curso.situacion%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT docente.cedula AS cedula,
	docente.nombre_completo AS docente,
	curso.nombre AS curso,
	instancia_curso.seccion AS seccion,
	instancia_curso.anio AS anio,
	tipo_periodo.tipo AS periodo,
	alumno.num_matricula AS alumno,
	CAST(AVG(instancia_evaluacion.nota) AS DECIMAL(10,0)) AS promedio_nota_final,
	situacion_alumno_instancia_curso.situacion AS situacion
	FROM alumno, curso, instancia_curso, alumno_instancia_curso, tipo_periodo, docente, situacion_alumno_instancia_curso, instancia_evaluacion, evaluacion
	WHERE alumno.num_matricula=alumno_instancia_curso.alumno
	AND alumno_instancia_curso.instancia_curso=instancia_curso.id
	AND instancia_curso.curso=curso.id
	AND tipo_periodo.id=instancia_curso.periodo
	AND docente.cedula=instancia_curso.docente
	AND situacion_alumno_instancia_curso.id=alumno_instancia_curso.situacion
	AND instancia_evaluacion.alumno=alumno.num_matricula
	AND instancia_evaluacion.evaluacion=evaluacion.id
	AND evaluacion.instancia_curso=instancia_curso.id
	GROUP BY docente.cedula, docente.nombre_completo, instancia_curso.id, alumno.num_matricula, curso.nombre, alumno_instancia_curso.nota_final, tipo_periodo.tipo, situacion_alumno_instancia_curso.situacion
	ORDER BY promedio_nota_final ASC, docente ASC, seccion ASC;
END;
$$ LANGUAGE plpgsql;