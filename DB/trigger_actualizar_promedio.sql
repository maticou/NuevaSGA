CREATE OR REPLACE FUNCTION actualizar_promedio() 
RETURNS trigger AS $$
DECLARE
	promedio_actual alumno_instancia_curso.nota_final%TYPE;
	nota instancia_evaluacion.nota%TYPE;
	porcentaje evaluacion.porcentaje%TYPE;
	promedio_nuevo integer default 0;
	_id_curso alumno_instancia_curso.instancia_curso%TYPE;
BEGIN
	SELECT instancia_curso
	FROM alumno_instancia_curso
	WHERE alumno_instancia_curso.alumno = OLD.alumno
	AND alumno_instancia_curso.instancia_curso = OLD.instancia_curso 
	INTO _id_curso;

	IF ((SELECT cursor_verificar_porcentaje_completo(_id_curso)) = 1) THEN
		SELECT nota_final
		FROM alumno_instancia_curso
		WHERE alumno_instancia_curso.alumno = OLD.alumno
		AND alumno_instancia_curso.instancia_curso = OLD.instancia_curso 
		INTO promedio_actual;

		SELECT instancia_evaluacion.nota
		FROM instancia_evaluacion, evaluacion
		WHERE instancia_evaluacion.evaluacion=evaluacion.id INTO nota;

		SELECT evaluacion.porcentaje
		FROM instancia_evaluacion, evaluacion
		WHERE instancia_evaluacion.evaluacion=evaluacion.id INTO porcentaje;

		IF(promedio_actual = null) THEN
			promedio_actual:= 0;
		ELSE
		END IF;

		promedio_nuevo := ((nota * porcentaje) / 100) + promedio_actual;
		
	    UPDATE alumno_instancia_curso 
		SET nota_final = promedio_nuevo 
	    WHERE alumno = OLD.alumno
	    AND instancia_curso = OLD.instancia_curso;
	     
	    RAISE NOTICE 'Se actualizo una nota del alumno';
	END IF;
    RETURN OLD;
END ;
$$ LANGUAGE plpgsql;

CREATE TRIGGER modificacion_nota
AFTER UPDATE of nota_final
ON alumno_instancia_curso
FOR EACH ROW EXECUTE FUNCTION actualizar_promedio();