CREATE OR REPLACE FUNCTION nota_final_alumno_en_instancia_curso(
	_matricula alumno_instancia_curso.alumno%TYPE,
	_id_instancia alumno_instancia_curso.id%TYPE
) RETURNS INTEGER AS $$
DECLARE
	nota_final_alumno INTEGER default 0;
BEGIN
	SELECT alumno_instancia_curso.nota_final AS nota_final
	FROM alumno_instancia_curso
	WHERE alumno_instancia_curso.alumno=_matricula
	AND alumno_instancia_curso.instancia_curso=_id_instancia INTO nota_final_alumno;

	IF (nota_final_alumno > 9) THEN
		RAISE NOTICE 'La nota final del alumno es %', nota_final_alumno;
		RETURN nota_final_alumno;
	ELSE
		RAISE NOTICE 'El alumno no tiene notas';
		RETURN 0;
	END IF;	
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION estado_docente(
	_rut_profesor docente.cedula%TYPE
) RETURNS tipo_estado.tipo%TYPE AS $$
DECLARE
	estado_profesor tipo_estado.tipo%TYPE;
BEGIN
	SELECT tipo_estado.tipo AS tipo
	FROM docente, tipo_estado
	WHERE docente.cedula=_rut_profesor 
	AND tipo_estado.id=docente.estado INTO estado_profesor;

	RETURN estado_profesor;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION numero_alumnos_matriculados(
	_id_instancia alumno_instancia_curso.instancia_curso%TYPE
) RETURNS INTEGER AS $$
DECLARE
	num_alumnos INTEGER default 0;
BEGIN
	SELECT COUNT(alumno_instancia_curso.id)
	FROM alumno_instancia_curso, instancia_curso
	WHERE alumno_instancia_curso.instancia_curso = instancia_curso.id INTO num_alumnos;

	RETURN num_alumnos;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION notas_alumno_curso(
	_matricula alumno_instancia_curso.alumno%TYPE,
	_instancia_curso alumno_instancia_curso.instancia_curso%TYPE
) RETURNS TABLE (
 	   instancia_curso alumno_instancia_curso.instancia_curso%TYPE,
 	   matricula alumno_instancia_curso.alumno%TYPE,
	   nota alumno_instancia_curso.nota_final%TYPE) 
	   AS $$
BEGIN
	RETURN QUERY 
	SELECT alumno_instancia_curso.instancia_curso AS instancia_curso,
	alumno_instancia_curso.alumno AS matricula,
	alumno_instancia_curso.nota_final AS nota
	FROM alumno_instancia_curso
	WHERE alumno_instancia_curso.alumno=_matricula
	AND alumno_instancia_curso.instancia_curso=_instancia_curso;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_datos_alumno(
	IN _alumno alumno.num_matricula%TYPE
) RETURNS TABLE (
		num_matricula alumno.num_matricula%TYPE,
		nombre alumno.nombre_completo%TYPE,
		email alumno.email%TYPE,
		contrasenia alumno.contrasenia%TYPE,
		estado alumno.estado%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT alumno.num_matricula AS num_matricula,
	alumno.nombre_completo AS nombre,
	alumno.email AS email,
	alumno.contrasenia AS contrasenia,
	alumno.estado AS estado	
	FROM alumno
	WHERE alumno.num_matricula = _alumno;
END;
$$ LANGUAGE 'plpgsql';
