CREATE OR REPLACE FUNCTION obtener_evaluaciones_curso(
	_id_instancia instancia_curso.id%TYPE
) RETURNS TABLE(
	id_evaluacion evaluacion.id%TYPE,
	fecha evaluacion.fecha%TYPE,
	porcentaje evaluacion.porcentaje%TYPE,
	exigible evaluacion.exigible%TYPE,
	unidad_evaluacion unidad_aprendizaje.nombre%TYPE,
	tipo_evaluacion tipo_evaluacion.tipo%TYPE,
	prorroga evaluacion.prorroga%TYPE
) AS $$
BEGIN 
	RETURN QUERY

	SELECT evaluacion.id AS id_evaluacion,
	evaluacion.fecha AS fecha,
	evaluacion.porcentaje AS porcentaje,
	evaluacion.exigible AS exigible,
	unidad_aprendizaje.nombre AS unidad_evaluacion,
	tipo_evaluacion.tipo AS tipo_evaluacion,
	evaluacion.prorroga AS prorroga
	FROM evaluacion, tipo_evaluacion, unidad_aprendizaje
	WHERE evaluacion.instancia_curso = _id_instancia
	AND evaluacion.unidad = unidad_aprendizaje.id
	AND evaluacion.tipo_evaluacion = tipo_evaluacion.id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_evaluaciones_alumno(
	_matricula alumno.num_matricula%TYPE,
	_id_instancia instancia_curso.id%TYPE
) RETURNS TABLE(
	id_evaluacion evaluacion.id%TYPE,
	fecha evaluacion.fecha%TYPE,
	porcentaje evaluacion.porcentaje%TYPE,
	exigible evaluacion.exigible%TYPE,
	unidad_evaluacion unidad_aprendizaje.nombre%TYPE,
	tipo_evaluacion tipo_evaluacion.tipo%TYPE,
	nota instancia_evaluacion.nota%TYPE
) AS $$
BEGIN
	RETURN QUERY	
	SELECT instancia_evaluacion.id AS id_evaluacion,
	evaluacion.fecha AS fecha,
	evaluacion.porcentaje AS porcentaje,
	evaluacion.exigible AS exigible,
	unidad_aprendizaje.nombre AS unidad_evaluacion,
	tipo_evaluacion.tipo AS tipo_evaluacion,
	instancia_evaluacion.nota AS nota
	FROM evaluacion, instancia_evaluacion,
		tipo_evaluacion, unidad_aprendizaje
	WHERE evaluacion.instancia_curso = _id_instancia
	AND evaluacion.id = instancia_evaluacion.evaluacion
	AND instancia_evaluacion.alumno = _matricula;
END;
$$ LANGUAGE plpgsql;