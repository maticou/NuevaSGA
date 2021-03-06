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


CREATE OR REPLACE FUNCTION obtener_datos_curso(
	IN _id curso.id%TYPE
) RETURNS TABLE (
		id curso.id%TYPE,
		nombre curso.nombre%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT curso.id AS id,
	curso.nombre AS nombre
	FROM curso
	WHERE curso.id = _id;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION obtener_datos_docente(
	IN _cedula docente.cedula%TYPE
) RETURNS TABLE (
		cedula docente.cedula%TYPE,
		nombre docente.nombre_completo%TYPE,
		email docente.email%TYPE,
		contrasenia docente.contrasenia%TYPE,
		estado docente.estado%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT docente.cedula AS cedula,
	docente.nombre_completo AS nombre,
	docente.email AS email,
	docente.contrasenia AS contrasenia,
	docente.estado AS estado	
	FROM docente
	WHERE docente.cedula = _cedula;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION obtener_instancias_curso(
	_curso curso.id%TYPE
	) RETURNS TABLE (
		id instancia_curso.id%TYPE,
		nombre curso.nombre%TYPE,
		periodo tipo_periodo.tipo%TYPE,
		seccion instancia_curso.seccion%TYPE,
		anio instancia_curso.anio%TYPE,
		docente instancia_curso.docente%TYPE,
		porcentaje_restante instancia_curso.porcentaje_restante%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT instancia_curso.id AS id,
	curso.nombre AS nombre_curso,
	tipo_periodo.tipo AS periodo,
	instancia_curso.seccion AS seccion,
	instancia_curso.anio AS anio,
	instancia_curso.docente AS docente,
	instancia_curso.porcentaje_restante AS porcentaje_restante
	FROM curso, instancia_curso, tipo_periodo
	WHERE curso.id = _curso
	AND instancia_curso.curso = curso.id
	AND tipo_periodo.id=instancia_curso.periodo;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_datos_alumno_no_inscritos_en_instancia_curso(
	IN _instancia_curso instancia_curso.id%TYPE
) RETURNS TABLE (
		num_matricula alumno.num_matricula%TYPE,
		nombre alumno.nombre_completo%TYPE,
		estado alumno.estado%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT alumno.num_matricula AS num_matricula,
	alumno.nombre_completo AS nombre,
	alumno.estado AS estado	
	FROM alumno
	WHERE alumno.estado=1
	EXCEPT
	SELECT alumno.num_matricula AS num_matricula,
	alumno.nombre_completo AS nombre,
	alumno.estado AS estado	
	FROM alumno, alumno_instancia_curso
	WHERE alumno_instancia_curso.instancia_curso=_instancia_curso
	AND alumno.num_matricula = alumno_instancia_curso.alumno;
END;
$$ LANGUAGE 'plpgsql';



CREATE OR REPLACE FUNCTION obtener_datos_alumno_ayudante(
	IN _curso ayudante_instancia_curso.instancia_curso%TYPE
) RETURNS TABLE (
		num_matricula alumno.num_matricula%TYPE,
		nombre alumno.nombre_completo%TYPE,
		email alumno.email%TYPE,
		estado alumno.estado%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT alumno.num_matricula AS num_matricula,
	alumno.nombre_completo AS nombre,
	alumno.email AS email,
	alumno.estado AS estado	
	FROM alumno, ayudante_instancia_curso
	WHERE ayudante_instancia_curso.instancia_curso = _curso
	AND alumno.num_matricula=ayudante_instancia_curso.alumno;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION obtener_datos_docente_invitado(
	IN _curso docente_invitado_instancia_curso.instancia_curso%TYPE
) RETURNS TABLE (
		cedula docente.cedula%TYPE,
		nombre docente.nombre_completo%TYPE,
		email docente.email%TYPE,
		estado docente.estado%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT docente.cedula AS cedula,
	docente.nombre_completo AS nombre,
	docente.email AS email,
	docente.estado AS estado	
	FROM docente, docente_invitado_instancia_curso
	WHERE docente_invitado_instancia_curso.instancia_curso = _curso
	AND docente.cedula=docente_invitado_instancia_curso.docente;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION obtener_datos_alumno_ayudante_no_curso(
	IN _curso instancia_curso.id%TYPE
) RETURNS TABLE (
		num_matricula alumno.num_matricula%TYPE,
		nombre alumno.nombre_completo%TYPE,
		email alumno.email%TYPE,
		estado alumno.estado%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT alumno.num_matricula AS num_matricula,
	alumno.nombre_completo AS nombre,
	alumno.email AS email,
	alumno.estado AS estado	
	FROM alumno
	EXCEPT
	SELECT alumno.num_matricula AS num_matricula,
	alumno.nombre_completo AS nombre,
	alumno.email AS email,
	alumno.estado AS estado	
	FROM alumno, instancia_curso, alumno_instancia_curso
	WHERE instancia_curso.id = _curso
	AND alumno_instancia_curso.instancia_curso=instancia_curso.id
	AND alumno_instancia_curso.alumno=alumno.num_matricula;
END;
$$ LANGUAGE 'plpgsql';



CREATE OR REPLACE FUNCTION obtener_datos_docente_invitado_no_curso(
	IN _curso instancia_curso.id%TYPE
) RETURNS TABLE (
		cedula docente.cedula%TYPE,
		nombre docente.nombre_completo%TYPE,
		email docente.email%TYPE,
		estado docente.estado%TYPE
	) AS $$
BEGIN
	RETURN QUERY
	SELECT docente.cedula AS cedula,
	docente.nombre_completo AS nombre,
	docente.email AS email,
	docente.estado AS estado	
	FROM docente
	EXCEPT
	SELECT docente.cedula AS cedula,
	docente.nombre_completo AS nombre,
	docente.email AS email,
	docente.estado AS estado	
	FROM docente, docente_invitado_instancia_curso, instancia_curso
	WHERE instancia_curso.id = _curso
	AND docente.cedula=docente_invitado_instancia_curso.docente
	EXCEPT
	SELECT docente.cedula AS cedula,
	docente.nombre_completo AS nombre,
	docente.email AS email,
	docente.estado AS estado	
	FROM docente, instancia_curso
	WHERE docente.cedula=instancia_curso.docente
	AND instancia_curso.id=_curso;
END;
$$ LANGUAGE 'plpgsql';