CREATE OR REPLACE FUNCTION iniciar_sesion_docente(
	IN _usuario docente.email%TYPE,
	IN _contrasenia docente.contrasenia%TYPE
) RETURNS TABLE (
		cedula docente.cedula%TYPE,
		nombre docente.nombre_completo%TYPE,
		email docente.email%TYPE,
		tipo VARCHAR(14)
	) AS $$
BEGIN
	RETURN QUERY
	SELECT docente.cedula AS cedula,
	docente.nombre_completo AS nombre,
	docente.email AS email,
	'Docente'::VARCHAR(14) AS tipo
	FROM docente
	WHERE docente.email = UPPER(_usuario)
	AND docente.contrasenia = _contrasenia
	UNION
	SELECT administrador.cedula AS cedula,
	administrador.nombre_completo AS nombre,
	administrador.email AS email,
	'Admin'::VARCHAR(14) AS tipo
	FROM administrador
	WHERE administrador.email = UPPER(_usuario)
	AND administrador.contrasenia = _contrasenia
	UNION
	SELECT director.cedula AS cedula,
	director.nombre_completo AS nombre,
	director.email AS email,
	'Director'::VARCHAR(14) AS tipo
	FROM director
	WHERE director.email = UPPER(_usuario)
	AND director.contrasenia = _contrasenia;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION obtener_datos_usuario(
	IN _usuario docente.email%TYPE
) RETURNS TABLE (
		cedula docente.cedula%TYPE,
		nombre docente.nombre_completo%TYPE,
		email docente.email%TYPE,
		tipo VARCHAR(14)
	) AS $$
BEGIN
	RETURN QUERY
	SELECT docente.cedula AS cedula,
	docente.nombre_completo AS nombre,
	docente.email AS email,
	'Docente'::VARCHAR(14) AS tipo
	FROM docente
	WHERE docente.email = UPPER(_usuario)
	UNION
	SELECT administrador.cedula AS cedula,
	administrador.nombre_completo AS nombre,
	administrador.email AS email,
	'Admin'::VARCHAR(14) AS tipo
	FROM administrador
	WHERE administrador.email = UPPER(_usuario)
	UNION
	SELECT director.cedula AS cedula,
	director.nombre_completo AS nombre,
	director.email AS email,
	'Director'::VARCHAR(14) AS tipo
	FROM director
	WHERE director.email = UPPER(_usuario);
END;
$$ LANGUAGE 'plpgsql';
