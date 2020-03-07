CREATE OR REPLACE FUNCTION iniciar_sesion_docente(
	IN _usuario docente.cedula%TYPE,
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
	WHERE docente.cedula = _usuario
	AND docente.contrasenia = _contrasenia
	UNION
	SELECT administrador.cedula AS cedula,
	administrador.nombre_completo AS nombre,
	administrador.email AS email,
	'Admin'::VARCHAR(14) AS tipo
	FROM administrador
	WHERE administrador.cedula = _usuario
	AND administrador.contrasenia = _contrasenia;
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION obtener_datos_usuario(
	IN _usuario docente.cedula%TYPE
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
	WHERE docente.cedula = _usuario
	UNION
	SELECT administrador.cedula AS cedula,
	administrador.nombre_completo AS nombre,
	administrador.email AS email,
	'Admin'::VARCHAR(14) AS tipo
	FROM administrador
	WHERE administrador.cedula = _usuario;
END;
$$ LANGUAGE 'plpgsql';
