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
	AND instancia_evaluacion.alumno = _matricula
	AND unidad_aprendizaje.id = evaluacion.unidad
	AND tipo_evaluacion.id = evaluacion.tipo_evaluacion;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_promedio() 
RETURNS trigger AS $$
DECLARE
	promedio_actual alumno_instancia_curso.nota_final%TYPE;
	nota instancia_evaluacion.nota%TYPE;
	porcentaje evaluacion.porcentaje%TYPE;
	promedio_nuevo integer default 0;
	_id_curso alumno_instancia_curso.instancia_curso%TYPE;
BEGIN

	SELECT alumno_instancia_curso.instancia_curso
	FROM alumno_instancia_curso, evaluacion, instancia_evaluacion
	WHERE alumno_instancia_curso.alumno = OLD.alumno
	AND alumno_instancia_curso.instancia_curso = evaluacion.instancia_curso
	AND evaluacion.id = OLD.evaluacion
	INTO _id_curso;

	SELECT nota_final
	FROM alumno_instancia_curso
	WHERE alumno_instancia_curso.alumno = OLD.alumno
	AND alumno_instancia_curso.instancia_curso = _id_curso	
	INTO promedio_actual;
	
	SELECT evaluacion.porcentaje
	FROM instancia_evaluacion, evaluacion
	WHERE instancia_evaluacion.evaluacion=OLD.evaluacion INTO porcentaje;

	IF(promedio_actual = null) THEN
		promedio_actual:= 0;
	ELSE
	END IF;

	promedio_nuevo := ((NEW.nota * porcentaje) / 100) + promedio_actual;
	
    UPDATE alumno_instancia_curso 
	SET nota_final = promedio_nuevo 
    WHERE alumno = OLD.alumno
    AND instancia_curso = _id_curso;
     
    RAISE NOTICE 'Se actualizo una nota del alumno';
	RETURN OLD;
END ;
$$ LANGUAGE plpgsql;

CREATE TRIGGER modificacion_nota
AFTER UPDATE of nota
ON instancia_evaluacion
FOR EACH ROW EXECUTE FUNCTION actualizar_promedio();