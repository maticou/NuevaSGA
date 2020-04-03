CREATE OR REPLACE PROCEDURE agregar_estado(
	_tipo tipo_estado.tipo%TYPE
) AS $$
BEGIN
	INSERT INTO tipo_estado(tipo) 
	VALUES (UPPER(_tipo));
	RAISE NOTICE 'El estado fue registrado correctamente';    
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE agregar_administrador(
	_cedula administrador.cedula%TYPE,
	_nombre_completo administrador.nombre_completo%TYPE,
	_email administrador.email%TYPE,
	_contrasenia administrador.contrasenia%TYPE
) AS $$
DECLARE 
    _rutAux character varying(12);      

BEGIN

    _rutAux :=  _cedula;
    _rutAux := replace(_rutAux::text, '.','');
    _rutAux := replace(_rutAux::text, '-','');    


    IF email_valido(_email) = false THEN
        RAISE EXCEPTION 'El email no es valido';
    END IF;

    IF valida_rut(_rutAux) AND email_valido(_email) THEN

        INSERT INTO administrador(cedula, nombre_completo, email, contrasenia) 
		VALUES (UPPER(_rutAux), UPPER(_nombre_completo), UPPER(_email), MD5(_contrasenia) );
		RAISE NOTICE 'El administrador fue registrado correctamente';    

    END IF;	
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_director(
	_cedula director.cedula%TYPE,
	_nombre_completo director.nombre_completo%TYPE,
	_email director.email%TYPE,
	_contrasenia director.contrasenia%TYPE
) AS $$
DECLARE 
    _rutAux character varying(12);      

BEGIN

    _rutAux :=  _cedula;
    _rutAux := replace(_rutAux::text, '.','');
    _rutAux := replace(_rutAux::text, '-','');    


    IF email_valido(_email) = false THEN
        RAISE EXCEPTION 'El email no es valido';
    END IF;

    IF valida_rut(_rutAux) AND email_valido(_email) THEN

        INSERT INTO director(cedula, nombre_completo, email, contrasenia) 
		VALUES (UPPER(_rutAux), UPPER(_nombre_completo), UPPER(_email), MD5(_contrasenia) );
		RAISE NOTICE 'El director fue registrado correctamente';    

    END IF;	
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_docente(
	_cedula docente.cedula%TYPE,
	_nombre_completo docente.nombre_completo%TYPE,
	_email docente.email%TYPE,
	_contrasenia docente.contrasenia%TYPE
) AS $$
DECLARE 
    _rutAux character varying(12);      

BEGIN

    _rutAux :=  _cedula;
    _rutAux := replace(_rutAux::text, '.','');
    _rutAux := replace(_rutAux::text, '-','');    


    IF email_valido(_email) = false THEN
        RAISE EXCEPTION 'El email no es valido';
    END IF;

    IF valida_rut(_rutAux) AND email_valido(_email) THEN

        INSERT INTO docente(cedula, nombre_completo, email, contrasenia) 
		VALUES (UPPER(_rutAux), UPPER(_nombre_completo), UPPER(_email), MD5(_contrasenia) );
		RAISE NOTICE 'El docente fue registrado correctamente';    

    END IF;	
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_dia(
	_dia dia.dia%TYPE
) AS $$
BEGIN
	IF buscar_dia(_dia) = FALSE THEN

        INSERT INTO dia(dia) 
		VALUES (UPPER(_dia));
		RAISE NOTICE 'El dia fue registrado correctamente'; 

	ELSE
		RAISE NOTICE 'El dia ya existe'; 

    END IF;	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_horario_atencion(
	_dia horario_atencion.dia%TYPE,
	_hora_inicio horario_atencion.hora_inicio%TYPE,
	_hora_termino horario_atencion.hora_termino%TYPE,
	_docente horario_atencion.docente%TYPE
) AS $$
BEGIN
	INSERT INTO horario_atencion(dia,hora_inicio,hora_termino,docente) 
	VALUES (_dia, _hora_inicio, _hora_termino, _docente);
	RAISE NOTICE 'El horario de atencion fue registrado correctamente';       
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_alumno(
	_num_matricula alumno.num_matricula%TYPE,
	_nombre_completo alumno.nombre_completo%TYPE,
	_email alumno.email%TYPE,
	_contrasenia alumno.contrasenia%TYPE
) AS $$
BEGIN
	INSERT INTO alumno(num_matricula,nombre_completo,email,contrasenia) 
	VALUES (_num_matricula,UPPER(_nombre_completo), UPPER(_email), MD5(_contrasenia));
	RAISE NOTICE 'El alumno fue registrado correctamente';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_observacion(
	_alumno observacion.alumno%TYPE,
	_docente observacion.docente%TYPE,
	_observacion observacion.observacion%TYPE
) AS $$
BEGIN
	INSERT INTO observacion(alumno,docente,observacion) 
	VALUES (_alumno,UPPER(_docente), UPPER(_observacion));
	RAISE NOTICE 'La observacion fue registrada correctamente';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_curso(
	_nombre curso.nombre%TYPE	
) AS $$
BEGIN
	INSERT INTO curso(nombre) 
	VALUES (UPPER(_nombre));
	RAISE NOTICE 'El curso fue registrado correctamente';    	   
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE agregar_periodo(
	_tipo tipo_periodo.tipo%TYPE
) AS $$
BEGIN
	INSERT INTO tipo_periodo(tipo) 
	VALUES (UPPER(_tipo));
	RAISE NOTICE 'El periodo fue registrado correctamente';    
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE agregar_instancia_curso(
	_periodo instancia_curso.periodo%TYPE,
	_seccion instancia_curso.seccion%TYPE,
	_anio instancia_curso.anio%TYPE,
	_curso instancia_curso.curso%TYPE,
	_docente instancia_curso.docente%TYPE
) AS $$
DECLARE
	existe integer default 0;
BEGIN
	SELECT COUNT(instancia_curso.id)
	FROM instancia_curso
	WHERE instancia_curso.seccion=UPPER(_seccion)
	AND instancia_curso.periodo=_periodo
	AND instancia_curso.anio=_anio
	AND instancia_curso.curso=_curso INTO existe;

	IF (existe = 0) THEN
		INSERT INTO instancia_curso(periodo,seccion,anio,curso,docente) 
		VALUES (_periodo,UPPER(_seccion),_anio,_curso,UPPER(_docente));
		RAISE NOTICE 'La instancia curso fue registrada correctamente';		
	ELSE
		RAISE NOTICE 'La instancia del curso ya existe';
	END IF;	    	   
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE agregar_ayudante_instancia_curso(
	_instancia_curso ayudante_instancia_curso.instancia_curso%TYPE,
	_alumno ayudante_instancia_curso.alumno%TYPE
) AS $$
BEGIN
	INSERT INTO ayudante_instancia_curso(instancia_curso,alumno) 
	VALUES (_instancia_curso,_alumno);
	RAISE NOTICE 'El ayudante fue registrado correctamente a la instancia curso';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_docente_invitado_instancia_curso(
	_instancia_curso docente_invitado_instancia_curso.instancia_curso%TYPE,
	_docente docente_invitado_instancia_curso.docente%TYPE
) AS $$
BEGIN
	INSERT INTO docente_invitado_instancia_curso(instancia_curso,docente) 
	VALUES (_instancia_curso,UPPER(_docente));
	RAISE NOTICE 'El docente fue registrado correctamente a la instancia curso';    	   
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE agregar_situacion_alumno_instancia_curso(
	_situacion situacion_alumno_instancia_curso.situacion%TYPE
) AS $$
BEGIN
	INSERT INTO situacion_alumno_instancia_curso(situacion) 
	VALUES (UPPER(_situacion));
	RAISE NOTICE 'La situacion fue registrada correctamente';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_alumno_instancia_curso(
	_instancia_curso alumno_instancia_curso.instancia_curso%TYPE,
	_alumno alumno_instancia_curso.alumno%TYPE,
	_nota_final alumno_instancia_curso.nota_final%TYPE,
	_situacion alumno_instancia_curso.situacion%TYPE
) AS $$
BEGIN
	INSERT INTO alumno_instancia_curso(instancia_curso,alumno,nota_final,situacion) 
	VALUES (_instancia_curso,_alumno,_nota_final,_situacion);
	RAISE NOTICE 'El alumno fue registrado correctamente en la instancia del curso';    	   
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE agregar_archivo(
	_nombre archivo.nombre%TYPE,
	_instancia_curso archivo.instancia_curso%TYPE,
	_docente archivo.docente%TYPE,
	_url archivo.url%TYPE
) AS $$
BEGIN
	INSERT INTO archivo(nombre,instancia_curso,docente,url) 
	VALUES (UPPER(_nombre),_instancia_curso,UPPER(_docente),UPPER(_url));
	RAISE NOTICE 'El archivo fue registrado correctamente';    	   
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE agregar_historial_reporte_alumno(
	_fecha historial_reporte_alumno.fecha%TYPE,
	_alumno historial_reporte_alumno.alumno%TYPE,
	_docente historial_reporte_alumno.docente%TYPE,
	_url historial_reporte_alumno.url%TYPE
) AS $$
BEGIN
	INSERT INTO historial_reporte_alumno(fecha,alumno,docente,url) 
	VALUES (_fecha,_alumno,UPPER(_docente),UPPER(_url));
	RAISE NOTICE 'El reporte alumno fue registrado correctamente';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_historial_reporte_curso(
	_fecha historial_reporte_curso.fecha%TYPE,
	_instancia_curso historial_reporte_curso.instancia_curso%TYPE,
	_docente historial_reporte_curso.docente%TYPE,
	_url historial_reporte_curso.url%TYPE
) AS $$
BEGIN
	INSERT INTO historial_reporte_curso(fecha,instancia_curso,docente,url) 
	VALUES (_fecha,_instancia_curso,UPPER(_docente),UPPER(_url));
	RAISE NOTICE 'El reporte curso fue registrado correctamente';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_tipo_evaluacion(
	_tipo tipo_evaluacion.tipo%TYPE
) AS $$
BEGIN
	INSERT INTO tipo_evaluacion(tipo) 
	VALUES (UPPER(_tipo));
	RAISE NOTICE 'El tipo de evaluacion fue registrado correctamente';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_unidad_aprendizaje(
	_nombre unidad_aprendizaje.nombre%TYPE
) AS $$
BEGIN
	INSERT INTO unidad_aprendizaje(nombre) 
	VALUES (UPPER(_nombre));
	RAISE NOTICE 'La unidad fue registrada correctamente';    	   
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE agregar_evaluacion(
	_fecha evaluacion.fecha%TYPE,
	_porcentaje evaluacion.porcentaje%TYPE,
	_exigible evaluacion.exigible%TYPE,
	_unidad evaluacion.unidad%TYPE,
	_tipo_evaluacion evaluacion.tipo_evaluacion%TYPE,
	_prorroga evaluacion.prorroga%TYPE,
	_instancia_curso evaluacion.instancia_curso%TYPE
) AS $$
BEGIN
	INSERT INTO evaluacion(fecha,porcentaje,exigible,unidad,tipo_evaluacion,prorroga,instancia_curso) 
	VALUES (_fecha,_porcentaje,_exigible,_unidad,_tipo_evaluacion,UPPER(_prorroga),_instancia_curso);
	RAISE NOTICE 'La evaluacion fue registrada correctamente';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE agregar_instancia_evaluacion(
	_alumno instancia_evaluacion.alumno%TYPE,
	_evaluacion instancia_evaluacion.evaluacion%TYPE,
	_nota instancia_evaluacion.nota%TYPE
) AS $$
BEGIN
	INSERT INTO instancia_evaluacion(alumno,evaluacion,nota) 
	VALUES (_alumno,_evaluacion,_nota);
	RAISE NOTICE 'La instancia de evaluacion fue registrada correctamente';    	   
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION buscar_dia(character varying)
  RETURNS boolean AS
$BODY$
DECLARE
    _dia ALIAS FOR $1;
    existe integer default 0;
BEGIN
	SELECT COUNT(id)
	FROM dia
	WHERE dia.dia=UPPER(_dia) INTO existe;

	IF (existe = 1) THEN
		RETURN 	TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



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
