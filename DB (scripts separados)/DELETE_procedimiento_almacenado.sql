--*************************DELETE***************

CREATE OR REPLACE PROCEDURE deshabilitar_alumno(
	_matricula_id alumno.num_matricula%TYPE
) AS $$
BEGIN 
	UPDATE alumno SET estado=2 WHERE alumno.num_matricula=_matricula_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE deshabilitar_profesor(
	_rut docente.cedula%TYPE
) AS $$
BEGIN 
	UPDATE docente SET estado=1 WHERE docente.cedula=_rut;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE eliminar_instancia_curso(
	_id_instancia instancia_curso.id%TYPE
) AS $$
DECLARE
	num_alumnos INTEGER default 0;
BEGIN
	SELECT numero_alumnos_matriculados(_id_instancia) INTO num_alumnos;

	IF(num_alumnos = 0) THEN 
		DELETE FROM instancia_curso WHERE instancia_curso.id = _id_instancia;
	ELSE
		RAISE NOTICE 'La instancia tiene alumnos, por lo que no se puede eliminar';
	END IF;
END;
$$ LANGUAGE plpgsql;