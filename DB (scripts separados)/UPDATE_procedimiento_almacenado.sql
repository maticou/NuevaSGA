--*************************UPDATE***************

CREATE OR REPLACE PROCEDURE modificar_alumno(
	_num_matricula alumno.num_matricula%TYPE,
	_nombre_completo alumno.nombre_completo%TYPE,
	_email alumno.email%TYPE
) AS $$
BEGIN 
	IF email_valido(_email) = false THEN
		RAISE EXCEPTION 'EL correo no es valido';
	ELSE
		UPDATE alumno
		SET nombre_completo = UPPER(_nombre_completo),
			email = UPPER(_email)
		WHERE alumno.num_matricula = _num_matricula;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE modificar_contrasenia_alumno(
	_num_matricula alumno.num_matricula%TYPE,
	_contrasenia alumno.contrasenia%TYPE
) AS $$
BEGIN 
	UPDATE alumno
	SET contrasenia = _contrasenia
	WHERE alumno.num_matricula = _num_matricula;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE modificar_estado_alumno(
	_num_matricula alumno.num_matricula%TYPE,
	_estado alumno.estado%TYPE
) AS $$
BEGIN 
	UPDATE alumno
	SET estado = _estado
	WHERE alumno.num_matricula = _num_matricula;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE modificar_docente(
	_cedula docente.cedula%TYPE,
	_nombre_completo docente.nombre_completo%TYPE,
	_email docente.email%TYPE
) AS $$
BEGIN
	IF email_valido(_email) = false THEN
		RAISE EXCEPTION 'EL correo no es valido';
	ELSE
		UPDATE docente
		SET nombre_completo = UPPER(_nombre_completo),
			email = UPPER(_email)
		WHERE docente.cedula = _cedula;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE modificar_contrasenia_docente(
	_cedula docente.cedula%TYPE,
	_contrasenia docente.contrasenia%TYPE
) AS $$
BEGIN 
	UPDATE docente
	SET contrasenia = _contrasenia
	WHERE docente.cedula = _cedula;

	RAISE NOTICE 'Contraseña modificada';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE modificar_estado_docente(
	_cedula docente.cedula%TYPE,
	_estado docente.estado%TYPE
) AS $$
BEGIN 
	UPDATE docente
	SET estado = _estado
	WHERE docente.cedula = _cedula;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE modificar_curso(
	_id curso.id%TYPE,
	_nombre curso.nombre%TYPE
) AS $$
BEGIN 
	UPDATE curso
	SET nombre = UPPER(_nombre)
	WHERE curso.id = _id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE modificar_instancia(
	_id instancia_curso.id%TYPE,
	_periodo instancia_curso.periodo%TYPE,
	_seccion instancia_curso.seccion%TYPE,
	_anio instancia_curso.anio%TYPE,
	_curso instancia_curso.curso%TYPE,
	_docente instancia_curso.docente%TYPE
) AS $$
BEGIN
	IF ((SELECT COUNT(id) FROM instancia_curso WHERE periodo=UPPER(_periodo) AND seccion=UPPER(_seccion) AND ref_curso=_ref_curso AND anio=_anio) = 0) THEN
	    UPDATE instancia_curso
		SET periodo = UPPER(_periodo),
			seccion = UPPER(_seccion),
			ref_profesor = _ref_profesor,
			ref_curso = _ref_curso,
			anio = _anio
		WHERE id = _id;
	ELSE
		RAISE NOTICE 'No se puede modificar la instancia con estos datos porque ya existe una instancia así';
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE modificar_alumno_instancia_curso(
	_id alumno_instancia_curso.id%TYPE,	
	_instancia_curso alumno_instancia_curso.instancia_curso%TYPE,
	_alumno alumno_instancia_curso.alumno%TYPE,
	_nota_final alumno_instancia_curso.nota_final%TYPE,
	_situacion alumno_instancia_curso.situacion%TYPE
) AS $$
BEGIN
    UPDATE alumno_instancia_curso
	SET nota_final = _nota_final,
		instancia_curso = _instancia_curso
	WHERE id = _id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE modificar_evaluacion(
	_id evaluacion.id%TYPE,
	_fecha evaluacion.fecha%TYPE,
	_porcentaje evaluacion.porcentaje%TYPE,
	_exigible evaluacion.exigible%TYPE,
	_unidad evaluacion.unidad%TYPE,
	_tipo_evaluacion evaluacion.tipo_evaluacion%TYPE,
	_prorroga evaluacion.prorroga%TYPE,		
	_instancia_curso evaluacion.instancia_curso%TYPE
) AS $$ 
BEGIN
	IF (_porcentaje>0 AND _porcentaje<101) THEN
		UPDATE evaluacion
		SET fecha = _fecha,
			porcentaje = _porcentaje,
			exigible = _exigible,
			unidad = _unidad,
			tipo_evaluacion = _tipo_evaluacion,
			prorroga = _prorroga,			
			ref_instancia_curso = _ref_instancia_curso
		WHERE id = _id;
		RAISE NOTICE 'La evaluación fue modificada correctamente';
	ELSE
		RAISE NOTICE 'No se modificar la evaluación porque el porcentaje no está en el rango [1,100]';		
	END IF;	    
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE modificar_nota(
	_nota instancia_evaluacion.nota%TYPE,
	_id_instancia_evaluacion instancia_evaluacion.id%TYPE
) AS $$
BEGIN
	IF (_nota>9 AND _nota<71) THEN
		UPDATE instancia_evaluacion
		SET nota = _nota
		WHERE instancia_evaluacion.id = _id_instancia_evaluacion;
		RAISE NOTICE 'Se modificó la nota correctamente a %', _nota;
	ELSE
		RAISE NOTICE 'No se pudo modificar la nota porque no está dentro del rango permitido [10,70]';
	END IF;    
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE asignar_profesor_curso(
	_rut_profesor instancia_curso.docente%TYPE,
	_id_instancia instancia_curso.id%TYPE
) AS $$
BEGIN
	IF(profesor_habilitado(_rut_profesor) = 1) THEN
		
	ELSE
		RAISE NOTICE 'El profesor no esta habilitado para dictar cursos.';
	END IF;
END;
$$ LANGUAGE plpgsql;

--  Funcion que obtiene el digito verificador de un rut
CREATE OR REPLACE FUNCTION digito_verificador(character varying)
  RETURNS character AS
$BODY$
DECLARE
    rut ALIAS FOR $1;
    rut_cero varchar(8);
    valor int;
BEGIN
    valor := 0;
    rut_cero := lpad(rut,8,'0');

    valor := valor + (substring(rut_cero,8,1)::int8)*2;
    valor := valor + (substring(rut_cero,7,1)::int8)*3;
    valor := valor + (substring(rut_cero,6,1)::int8)*4;
    valor := valor + (substring(rut_cero,5,1)::int8)*5;
    valor := valor + (substring(rut_cero,4,1)::int8)*6;
    valor := valor + (substring(rut_cero,3,1)::int8)*7;
    valor := valor + (substring(rut_cero,2,1)::int8)*2;
    valor := valor + (substring(rut_cero,1,1)::int8)*3;

    valor := valor % 11;

    IF valor =1 THEN
        RETURN 'K';
    END IF;
    IF valor =0 THEN
        RETURN '0';
    END IF;
    IF valor>1 AND valor<11 THEN
        RETURN (11-valor)::char;
    END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-- Funcion que valida si un rut es correcto o no
CREATE OR REPLACE FUNCTION valida_rut(character varying)
  RETURNS boolean AS
$BODY$
DECLARE
    rutfull ALIAS FOR $1;
    rutfull_cero varchar(9);
    rut varchar(8);
    dv char;
BEGIN
    IF rutfull IS NULL THEN
        RETURN TRUE;
    END IF;

    rutfull_cero := lpad(rutfull,9,'0');
    rut:= substr(rutfull_cero,0,9);
    dv := substr(rutfull_cero,9,1);

    IF digito_verificador(rut)=upper(dv) THEN
        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'rut invalido';
        RETURN FALSE;
    END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- Funcion que valida que un email sea valido
CREATE OR REPLACE FUNCTION email_valido(text) returns BOOLEAN AS 
'select $1 ~ ''^[^@\s]+@[^@\s]+(\.[^@\s]+)+$'' as result
' LANGUAGE sql;

