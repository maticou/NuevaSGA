--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

-- Started on 2020-03-13 23:36:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 287 (class 1255 OID 43017)
-- Name: actualizar_promedio(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_promedio() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.actualizar_promedio() OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 42965)
-- Name: agregar_administrador(character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_administrador(_cedula character varying, _nombre_completo character varying, _email character varying, _contrasenia character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER PROCEDURE public.agregar_administrador(_cedula character varying, _nombre_completo character varying, _email character varying, _contrasenia character varying) OWNER TO postgres;

--
-- TOC entry 265 (class 1255 OID 42969)
-- Name: agregar_alumno(integer, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_alumno(_num_matricula integer, _nombre_completo character varying, _email character varying, _contrasenia character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO alumno(num_matricula,nombre_completo,email,contrasenia) 
	VALUES (_num_matricula,UPPER(_nombre_completo), UPPER(_email), MD5(_contrasenia));
	RAISE NOTICE 'El alumno fue registrado correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_alumno(_num_matricula integer, _nombre_completo character varying, _email character varying, _contrasenia character varying) OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 42976)
-- Name: agregar_alumno_instancia_curso(integer, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_alumno_instancia_curso(_instancia_curso integer, _alumno integer, _nota_final integer, _situacion integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO alumno_instancia_curso(instancia_curso,alumno,nota_final,situacion) 
	VALUES (_instancia_curso,_alumno,_nota_final,_situacion);
	RAISE NOTICE 'El alumno fue registrado correctamente en la instancia del curso';    	   
END;
$$;


ALTER PROCEDURE public.agregar_alumno_instancia_curso(_instancia_curso integer, _alumno integer, _nota_final integer, _situacion integer) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 42977)
-- Name: agregar_archivo(character varying, integer, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_archivo(_nombre character varying, _instancia_curso integer, _docente character varying, _url character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO archivo(nombre,instancia_curso,docente,url) 
	VALUES (UPPER(_nombre),_instancia_curso,UPPER(_docente),UPPER(_url));
	RAISE NOTICE 'El archivo fue registrado correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_archivo(_nombre character varying, _instancia_curso integer, _docente character varying, _url character varying) OWNER TO postgres;

--
-- TOC entry 269 (class 1255 OID 42973)
-- Name: agregar_ayudante_instancia_curso(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_ayudante_instancia_curso(_instancia_curso integer, _alumno integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO ayudante_instancia_curso(instancia_curso,alumno) 
	VALUES (_instancia_curso,_alumno);
	RAISE NOTICE 'El ayudante fue registrado correctamente a la instancia curso';    	   
END;
$$;


ALTER PROCEDURE public.agregar_ayudante_instancia_curso(_instancia_curso integer, _alumno integer) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 42971)
-- Name: agregar_curso(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_curso(_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO curso(nombre) 
	VALUES (UPPER(_nombre));
	RAISE NOTICE 'El curso fue registrado correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_curso(_nombre character varying) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 42967)
-- Name: agregar_dia(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_dia(_dia character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF buscar_dia(_dia) = FALSE THEN

        INSERT INTO dia(dia) 
		VALUES (UPPER(_dia));
		RAISE NOTICE 'El dia fue registrado correctamente'; 

	ELSE
		RAISE NOTICE 'El dia ya existe'; 

    END IF;	   
END;
$$;


ALTER PROCEDURE public.agregar_dia(_dia character varying) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 42966)
-- Name: agregar_docente(character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_docente(_cedula character varying, _nombre_completo character varying, _email character varying, _contrasenia character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER PROCEDURE public.agregar_docente(_cedula character varying, _nombre_completo character varying, _email character varying, _contrasenia character varying) OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 42974)
-- Name: agregar_docente_invitado_instancia_curso(integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_docente_invitado_instancia_curso(_instancia_curso integer, _docente character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO docente_invitado_instancia_curso(instancia_curso,docente) 
	VALUES (_instancia_curso,UPPER(_docente));
	RAISE NOTICE 'El docente fue registrado correctamente a la instancia curso';    	   
END;
$$;


ALTER PROCEDURE public.agregar_docente_invitado_instancia_curso(_instancia_curso integer, _docente character varying) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 42964)
-- Name: agregar_estado(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_estado(_tipo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO tipo_estado(tipo) 
	VALUES (UPPER(_tipo));
	RAISE NOTICE 'El estado fue registrado correctamente';    
END;
$$;


ALTER PROCEDURE public.agregar_estado(_tipo character varying) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 42982)
-- Name: agregar_evaluacion(date, integer, boolean, integer, integer, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_evaluacion(_fecha date, _porcentaje integer, _exigible boolean, _unidad integer, _tipo_evaluacion integer, _prorroga character varying, _instancia_curso integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO evaluacion(fecha,porcentaje,exigible,unidad,tipo_evaluacion,prorroga,instancia_curso) 
	VALUES (_fecha,_porcentaje,_exigible,_unidad,_tipo_evaluacion,UPPER(_prorroga),_instancia_curso);
	RAISE NOTICE 'La evaluacion fue registrada correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_evaluacion(_fecha date, _porcentaje integer, _exigible boolean, _unidad integer, _tipo_evaluacion integer, _prorroga character varying, _instancia_curso integer) OWNER TO postgres;

--
-- TOC entry 274 (class 1255 OID 42978)
-- Name: agregar_historial_reporte_alumno(date, integer, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_historial_reporte_alumno(_fecha date, _alumno integer, _docente character varying, _url character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO historial_reporte_alumno(fecha,alumno,docente,url) 
	VALUES (_fecha,_alumno,UPPER(_docente),UPPER(_url));
	RAISE NOTICE 'El reporte alumno fue registrado correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_historial_reporte_alumno(_fecha date, _alumno integer, _docente character varying, _url character varying) OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 42979)
-- Name: agregar_historial_reporte_curso(date, integer, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_historial_reporte_curso(_fecha date, _instancia_curso integer, _docente character varying, _url character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO historial_reporte_curso(fecha,instancia_curso,docente,url) 
	VALUES (_fecha,_instancia_curso,UPPER(_docente),UPPER(_url));
	RAISE NOTICE 'El reporte curso fue registrado correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_historial_reporte_curso(_fecha date, _instancia_curso integer, _docente character varying, _url character varying) OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 42968)
-- Name: agregar_horario_atencion(integer, time without time zone, time without time zone, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_horario_atencion(_dia integer, _hora_inicio time without time zone, _hora_termino time without time zone, _docente character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO horario_atencion(dia,hora_inicio,hora_termino,docente) 
	VALUES (_dia, _hora_inicio, _hora_termino, _docente);
	RAISE NOTICE 'El horario de atencion fue registrado correctamente';       
END;
$$;


ALTER PROCEDURE public.agregar_horario_atencion(_dia integer, _hora_inicio time without time zone, _hora_termino time without time zone, _docente character varying) OWNER TO postgres;

--
-- TOC entry 268 (class 1255 OID 42972)
-- Name: agregar_instancia_curso(integer, character varying, integer, integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_instancia_curso(_periodo integer, _seccion character varying, _anio integer, _curso integer, _docente character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO instancia_curso(periodo,seccion,anio,curso,docente) 
	VALUES (_periodo,UPPER(_seccion),_anio,_curso,UPPER(_docente));
	RAISE NOTICE 'La instancia curso fue registrada correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_instancia_curso(_periodo integer, _seccion character varying, _anio integer, _curso integer, _docente character varying) OWNER TO postgres;

--
-- TOC entry 278 (class 1255 OID 42983)
-- Name: agregar_instancia_evaluacion(integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_instancia_evaluacion(_alumno integer, _evaluacion integer, _nota integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO instancia_evaluacion(alumno,evaluacion,nota) 
	VALUES (_alumno,_evaluacion,_nota);
	RAISE NOTICE 'La instancia de evaluacion fue registrada correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_instancia_evaluacion(_alumno integer, _evaluacion integer, _nota integer) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 42970)
-- Name: agregar_observacion(integer, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_observacion(_alumno integer, _docente character varying, _observacion character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO observacion(alumno,docente,observacion) 
	VALUES (_alumno,UPPER(_docente), UPPER(_observacion));
	RAISE NOTICE 'La observacion fue registrada correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_observacion(_alumno integer, _docente character varying, _observacion character varying) OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 42975)
-- Name: agregar_situacion_alumno_instancia_curso(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_situacion_alumno_instancia_curso(_situacion character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO situacion_alumno_instancia_curso(situacion) 
	VALUES (UPPER(_situacion));
	RAISE NOTICE 'La situacion fue registrada correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_situacion_alumno_instancia_curso(_situacion character varying) OWNER TO postgres;

--
-- TOC entry 276 (class 1255 OID 42980)
-- Name: agregar_tipo_evaluacion(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_tipo_evaluacion(_tipo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO tipo_evaluacion(tipo) 
	VALUES (UPPER(_tipo));
	RAISE NOTICE 'El tipo de evaluacion fue registrado correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_tipo_evaluacion(_tipo character varying) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 42981)
-- Name: agregar_unidad_aprendizaje(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregar_unidad_aprendizaje(_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO unidad_aprendizaje(nombre) 
	VALUES (UPPER(_nombre));
	RAISE NOTICE 'La unidad fue registrada correctamente';    	   
END;
$$;


ALTER PROCEDURE public.agregar_unidad_aprendizaje(_nombre character varying) OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 43030)
-- Name: asignar_profesor_curso(character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.asignar_profesor_curso(_rut_profesor character varying, _id_instancia integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF(profesor_habilitado(_rut_profesor) = 1) THEN
		
	ELSE
		RAISE NOTICE 'El profesor no esta habilitado para dictar cursos.';
	END IF;
END;
$$;


ALTER PROCEDURE public.asignar_profesor_curso(_rut_profesor character varying, _id_instancia integer) OWNER TO postgres;

--
-- TOC entry 279 (class 1255 OID 42984)
-- Name: buscar_dia(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.buscar_dia(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION public.buscar_dia(character varying) OWNER TO postgres;

--
-- TOC entry 280 (class 1255 OID 42988)
-- Name: calcular_nota_final(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.calcular_nota_final(id_alumno integer, id_instancia_curso integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
	promedio_final INTEGER default 0;
	id_curso INTEGER default 0;
	valor_verificar_situacion INTEGER default 0;
BEGIN
	IF ((SELECT cursor_verificar_porcentaje(id_instancia_curso)) = 1) THEN	
		IF (SELECT verificar_instancia_evaluacion(id_instancia_curso, id_alumno)) THEN						
			SELECT SUM(T2.nota) AS Promedio_final
			FROM (SELECT ((T1.evaluacion * T1.porcentaje)/100) AS nota
				FROM (
					SELECT num_matricula AS matricula_alumno, 
					alumno.nombre_completo AS alumno, curso.nombre AS curso, 
					seccion, nota AS evaluacion, porcentaje
					FROM alumno, instancia_curso, evaluacion, curso, instancia_evaluacion
					WHERE alumno.num_matricula=id_alumno			
					AND instancia_curso.id=id_instancia_curso			
					AND alumno.num_matricula=instancia_evaluacion.alumno
					AND instancia_evaluacion.evaluacion=evaluacion.id
					AND evaluacion.instancia_curso=instancia_curso.id
					AND instancia_curso.curso=curso.id) AS T1) AS T2 INTO promedio_final;				

			IF (promedio_final > 39) THEN
				SELECT cursor_verificar_situacion(
					id_alumno,id_instancia_curso) INTO valor_verificar_situacion;
				IF (valor_verificar_situacion = 1) THEN
					UPDATE alumno_instancia_curso
					SET nota_final=39, situacion=3
					WHERE alumno_instancia_curso.alumno=id_alumno 
					AND alumno_instancia_curso.instancia_curso=id_instancia_curso;
					RAISE NOTICE 'Alumno reprobado porque una evaluación exigible tiene nota menor a 40, se le modifica el promedio a nota 39';
				ELSE
					UPDATE matricula
					SET nota_final=promedio_final, situacion=2
					WHERE alumno_instancia_curso.alumno=id_alumno 
					AND alumno_instancia_curso.instancia_curso=id_instancia_curso;
					RAISE NOTICE 'Alumno aprobado con nota %', promedio_final;
				END IF;
			ELSE
				UPDATE matricula
				SET nota_final=promedio_final, situacion='REPROBADO'
				WHERE alumno_instancia_curso.alumno=id_alumno 
				AND alumno_instancia_curso.instancia_curso=id_instancia_curso;
				RAISE NOTICE 'Alumno reprobado con promedio %', promedio_final;
			END IF;			
		ELSE
			RAISE NOTICE 'No hay evaluaciones en el curso';		
		END IF;	
	END IF;	
END;
$$;


ALTER PROCEDURE public.calcular_nota_final(id_alumno integer, id_instancia_curso integer) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 42955)
-- Name: cursor_actualizar_evaluacion_por_alumno(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cursor_actualizar_evaluacion_por_alumno() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	cursor_porcentaje_a CURSOR FOR SELECT porcentaje_restante
								FROM instancia_curso
								WHERE instancia_curso.id = NEW.instancia_curso;
	reg RECORD;
	valor RECORD;
	cursor_alumnos CURSOR FOR SELECT *
								FROM alumno, alumno_instancia_curso
								WHERE alumno.num_matricula=alumno_instancia_curso.alumno
								AND instancia_curso=NEW.instancia_curso;
BEGIN 	
	OPEN cursor_porcentaje_a;	
	FETCH cursor_porcentaje_a INTO valor;
	OPEN cursor_alumnos;	
	FETCH cursor_alumnos INTO reg;
	IF (OLD.porcentaje < NEW.porcentaje) THEN	
		IF ((valor.porcentaje_restante-NEW.porcentaje) < 0) THEN
			RAISE NOTICE 'No se puede modificar evaluación con tan alto porcentaje';
		ELSE
			UPDATE instancia_curso 
			SET porcentaje_restante=(valor.porcentaje_restante-NEW.porcentaje) 
			WHERE instancia_curso.id = NEW.instancia_curso;	
			RAISE NOTICE 'Evaluación modificada correctamente';			
		END IF;			
	ELSE
		IF ((valor.porcentaje_restante+(OLD.porcentaje-NEW.porcentaje)) < 101) THEN
			UPDATE instancia_curso 
			SET porcentaje_restante=(valor.porcentaje_restante+(OLD.porcentaje-NEW.porcentaje))
			WHERE instancia_curso.id = NEW.ref_instancia_curso;	
			RAISE NOTICE 'Evaluación modificada correctamente';
		ELSE
			RAISE NOTICE 'No se puede modificar evaluación con tan alto porcentaje';
		END IF;
	END IF;
	RETURN NEW;
END;$$;


ALTER FUNCTION public.cursor_actualizar_evaluacion_por_alumno() OWNER TO postgres;

--
-- TOC entry 258 (class 1255 OID 42953)
-- Name: cursor_agregar_evaluacion_por_alumno(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cursor_agregar_evaluacion_por_alumno() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	cursor_porcentaje_a CURSOR FOR SELECT porcentaje_restante
								FROM instancia_curso
								WHERE instancia_curso.id = NEW.instancia_curso;
	reg RECORD;
	valor RECORD;
	cursor_alumnos CURSOR FOR SELECT *
								FROM alumno, alumno_instancia_curso
								WHERE alumno.num_matricula=alumno_instancia_curso.alumno
								AND instancia_curso=NEW.instancia_curso;
BEGIN 
	OPEN cursor_porcentaje_a;	
	FETCH cursor_porcentaje_a INTO valor;
	IF (valor.porcentaje_restante >= NEW.porcentaje) THEN
		OPEN cursor_alumnos;	
		FETCH cursor_alumnos INTO reg;
		UPDATE instancia_curso 
		SET porcentaje_restante=(porcentaje_restante-NEW.porcentaje) 
		WHERE instancia_curso.id = reg.instancia_curso;
		WHILE (FOUND) LOOP
			CALL crear_instancia_evaluacion(reg.num_matricula, NEW.id, NEW.instancia_curso);
			FETCH cursor_alumnos INTO reg;
		END LOOP;
	ELSE
			RAISE NOTICE 'No puede crear esta evaluación con porcentaje %, ya que al curso le queda % %% restante', NEW.porcentaje, valor.porcentaje_restante;
	END IF;
	RETURN NEW;
END;$$;


ALTER FUNCTION public.cursor_agregar_evaluacion_por_alumno() OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 42957)
-- Name: cursor_verificar_porcentaje(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cursor_verificar_porcentaje(_id_instancia integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	cursor_porcentaje CURSOR FOR SELECT porcentaje_restante
								FROM instancia_curso
								WHERE instancia_curso.id = _id_instancia;
	valor RECORD;
BEGIN 
	OPEN cursor_porcentaje;	
	FETCH cursor_porcentaje INTO valor;
	IF (valor.porcentaje_restante = 0) THEN
		RAISE NOTICE 'Se le permite calcular el promedio final';
		RETURN 1;
	ELSE
		RAISE NOTICE 'No puede calcular la nota final porque al curso le faltan evaluaciones. Recuerde que el curso tiene % %% restante', valor.porcentaje_restante;
		RETURN 0;
	END IF;	
END;$$;


ALTER FUNCTION public.cursor_verificar_porcentaje(_id_instancia integer) OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 42958)
-- Name: cursor_verificar_situacion(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cursor_verificar_situacion(_alumno integer, _instancia_curso integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	cursor_promedio CURSOR FOR SELECT nota, exigible
								FROM instancia_evaluacion, evaluacion
								WHERE alumno=_alumno
								AND instancia_evaluacion.instancia_curso=_instancia_curso
								AND evaluacion=evaluacion.id;
	valor RECORD;
BEGIN 
	OPEN cursor_promedio;	
	FETCH cursor_promedio INTO valor;
	WHILE (FOUND) LOOP
		IF (valor.exigible = TRUE) THEN
			IF (valor.nota < 40) THEN
				RAISE NOTICE 'Alumno reprueba por nota inferior a 40 en evaluación exigible';
				RETURN 1;
			ELSE
				RETURN 2;
			END IF;
		ELSE
			RAISE NOTICE 'No puede calcular la nota final porque al curso le faltan evaluaciones. Recuerde que el curso tiene % %% restante', valor.porcentaje_restante;
			RETURN 0;
		END IF;	
		FETCH cursor_promedio INTO valor;
	END LOOP;	
END;$$;


ALTER FUNCTION public.cursor_verificar_situacion(_alumno integer, _instancia_curso integer) OWNER TO postgres;

--
-- TOC entry 242 (class 1255 OID 42959)
-- Name: deshabilitar_alumno(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.deshabilitar_alumno(_matricula_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
	UPDATE alumno SET estado=2 WHERE alumno.num_matricula=_matricula_id;
END;
$$;


ALTER PROCEDURE public.deshabilitar_alumno(_matricula_id integer) OWNER TO postgres;

--
-- TOC entry 243 (class 1255 OID 42960)
-- Name: deshabilitar_profesor(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.deshabilitar_profesor(_rut character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
	UPDATE docente SET estado=1 WHERE docente.cedula=_rut;
END;
$$;


ALTER PROCEDURE public.deshabilitar_profesor(_rut character varying) OWNER TO postgres;

--
-- TOC entry 298 (class 1255 OID 42985)
-- Name: digito_verificador(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.digito_verificador(character varying) RETURNS character
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION public.digito_verificador(character varying) OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 42961)
-- Name: eliminar_instancia_curso(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.eliminar_instancia_curso(_id_instancia integer)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER PROCEDURE public.eliminar_instancia_curso(_id_instancia integer) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 42987)
-- Name: email_valido(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.email_valido(text) RETURNS boolean
    LANGUAGE sql
    AS $_$select $1 ~ '^[^@\s]+@[^@\s]+(\.[^@\s]+)+$' as result
$_$;


ALTER FUNCTION public.email_valido(text) OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 42993)
-- Name: estado_docente(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.estado_docente(_rut_profesor character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
	estado_profesor tipo_estado.tipo%TYPE;
BEGIN
	SELECT tipo_estado.tipo AS tipo
	FROM docente, tipo_estado
	WHERE docente.cedula=_rut_profesor 
	AND tipo_estado.id=docente.estado INTO estado_profesor;

	RETURN estado_profesor;
END;
$$;


ALTER FUNCTION public.estado_docente(_rut_profesor character varying) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 42962)
-- Name: iniciar_sesion_docente(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.iniciar_sesion_docente(_usuario character varying, _contrasenia character varying) RETURNS TABLE(cedula character varying, nombre character varying, email character varying, tipo character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.iniciar_sesion_docente(_usuario character varying, _contrasenia character varying) OWNER TO postgres;

--
-- TOC entry 288 (class 1255 OID 43019)
-- Name: modificar_alumno(integer, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_alumno(_num_matricula integer, _nombre_completo character varying, _email character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER PROCEDURE public.modificar_alumno(_num_matricula integer, _nombre_completo character varying, _email character varying) OWNER TO postgres;

--
-- TOC entry 296 (class 1255 OID 43027)
-- Name: modificar_alumno_instancia_curso(integer, integer, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_alumno_instancia_curso(_id integer, _instancia_curso integer, _alumno integer, _nota_final integer, _situacion integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE alumno_instancia_curso
	SET nota_final = _nota_final,
		instancia_curso = _instancia_curso
	WHERE id = _id;
END;
$$;


ALTER PROCEDURE public.modificar_alumno_instancia_curso(_id integer, _instancia_curso integer, _alumno integer, _nota_final integer, _situacion integer) OWNER TO postgres;

--
-- TOC entry 289 (class 1255 OID 43020)
-- Name: modificar_contrasenia_alumno(integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_contrasenia_alumno(_num_matricula integer, _contrasenia character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
	UPDATE alumno
	SET contrasenia = _contrasenia
	WHERE alumno.num_matricula = _num_matricula;
END;
$$;


ALTER PROCEDURE public.modificar_contrasenia_alumno(_num_matricula integer, _contrasenia character varying) OWNER TO postgres;

--
-- TOC entry 292 (class 1255 OID 43023)
-- Name: modificar_contrasenia_docente(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_contrasenia_docente(_cedula character varying, _contrasenia character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
	UPDATE docente
	SET contrasenia = _contrasenia
	WHERE docente.cedula = _cedula;

	RAISE NOTICE 'Contraseña modificada';
END;
$$;


ALTER PROCEDURE public.modificar_contrasenia_docente(_cedula character varying, _contrasenia character varying) OWNER TO postgres;

--
-- TOC entry 294 (class 1255 OID 43025)
-- Name: modificar_curso(integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_curso(_id integer, _nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN 
	UPDATE curso
	SET nombre = UPPER(_nombre)
	WHERE curso.id = _id;
END;
$$;


ALTER PROCEDURE public.modificar_curso(_id integer, _nombre character varying) OWNER TO postgres;

--
-- TOC entry 291 (class 1255 OID 43022)
-- Name: modificar_docente(character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_docente(_cedula character varying, _nombre_completo character varying, _email character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER PROCEDURE public.modificar_docente(_cedula character varying, _nombre_completo character varying, _email character varying) OWNER TO postgres;

--
-- TOC entry 290 (class 1255 OID 43021)
-- Name: modificar_estado_alumno(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_estado_alumno(_num_matricula integer, _estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
	UPDATE alumno
	SET estado = _estado
	WHERE alumno.num_matricula = _num_matricula;
END;
$$;


ALTER PROCEDURE public.modificar_estado_alumno(_num_matricula integer, _estado integer) OWNER TO postgres;

--
-- TOC entry 293 (class 1255 OID 43024)
-- Name: modificar_estado_docente(character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_estado_docente(_cedula character varying, _estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN 
	UPDATE docente
	SET estado = _estado
	WHERE docente.cedula = _cedula;
END;
$$;


ALTER PROCEDURE public.modificar_estado_docente(_cedula character varying, _estado integer) OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 43028)
-- Name: modificar_evaluacion(integer, date, integer, boolean, integer, integer, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_evaluacion(_id integer, _fecha date, _porcentaje integer, _exigible boolean, _unidad integer, _tipo_evaluacion integer, _prorroga character varying, _instancia_curso integer)
    LANGUAGE plpgsql
    AS $$ 
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
$$;


ALTER PROCEDURE public.modificar_evaluacion(_id integer, _fecha date, _porcentaje integer, _exigible boolean, _unidad integer, _tipo_evaluacion integer, _prorroga character varying, _instancia_curso integer) OWNER TO postgres;

--
-- TOC entry 295 (class 1255 OID 43026)
-- Name: modificar_instancia(integer, integer, character varying, integer, integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_instancia(_id integer, _periodo integer, _seccion character varying, _anio integer, _curso integer, _docente character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER PROCEDURE public.modificar_instancia(_id integer, _periodo integer, _seccion character varying, _anio integer, _curso integer, _docente character varying) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 43029)
-- Name: modificar_nota(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.modificar_nota(_nota integer, _id_instancia_evaluacion integer)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER PROCEDURE public.modificar_nota(_nota integer, _id_instancia_evaluacion integer) OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 42992)
-- Name: nota_final_alumno_en_instancia_curso(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.nota_final_alumno_en_instancia_curso(_matricula integer, _id_instancia integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.nota_final_alumno_en_instancia_curso(_matricula integer, _id_instancia integer) OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 42995)
-- Name: notas_alumno_curso(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.notas_alumno_curso(_matricula integer, _instancia_curso integer) RETURNS TABLE(instancia_curso integer, matricula integer, nota integer)
    LANGUAGE plpgsql
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
$$;


ALTER FUNCTION public.notas_alumno_curso(_matricula integer, _instancia_curso integer) OWNER TO postgres;

--
-- TOC entry 240 (class 1255 OID 42994)
-- Name: numero_alumnos_matriculados(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numero_alumnos_matriculados(_id_instancia integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	num_alumnos INTEGER default 0;
BEGIN
	SELECT COUNT(alumno_instancia_curso.id)
	FROM alumno_instancia_curso, instancia_curso
	WHERE alumno_instancia_curso.instancia_curso = instancia_curso.id INTO num_alumnos;

	RETURN num_alumnos;
END;
$$;


ALTER FUNCTION public.numero_alumnos_matriculados(_id_instancia integer) OWNER TO postgres;

--
-- TOC entry 301 (class 1255 OID 43099)
-- Name: obtener_alumnos_curso(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_alumnos_curso(_id_instancia integer) RETURNS TABLE(matricula integer, nombre character varying, email character varying, nota integer, situacion integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
	SELECT alumno.num_matricula AS matricula,
	alumno.nombre_completo AS nombre,
	alumno.email AS email,
	alumno_instancia_curso.nota_final AS nota,
	alumno_instancia_curso.situacion AS situacion
	FROM alumno, alumno_instancia_curso
	WHERE alumno_instancia_curso.id = _id_instancia;
END;
$$;


ALTER FUNCTION public.obtener_alumnos_curso(_id_instancia integer) OWNER TO postgres;

--
-- TOC entry 300 (class 1255 OID 43098)
-- Name: obtener_cursos_docente(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_cursos_docente(_cedula character varying) RETURNS TABLE(nombre_curso character varying, id_instancia integer, seccion character varying, anio integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
	SELECT curso.nombre AS nombre_curso,
	instancia_curso.id AS id_instancia,
	instancia_curso.seccion AS seccion,
	instancia_curso.anio AS anio
	FROM curso, instancia_curso
	WHERE instancia_curso.docente = _cedula
	AND instancia_curso.curso = curso.id;
END;
$$;


ALTER FUNCTION public.obtener_cursos_docente(_cedula character varying) OWNER TO postgres;

--
-- TOC entry 302 (class 1255 OID 43101)
-- Name: obtener_datos_alumno(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_datos_alumno(_alumno integer) RETURNS TABLE(num_matricula integer, nombre character varying, email character varying, contrasenia character varying, estado integer)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.obtener_datos_alumno(_alumno integer) OWNER TO postgres;

--
-- TOC entry 303 (class 1255 OID 43102)
-- Name: obtener_datos_curso(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_datos_curso(_id integer) RETURNS TABLE(id integer, nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
	SELECT curso.id AS id,
	curso.nombre AS nombre
	FROM curso
	WHERE curso.id = _id;
END;
$$;


ALTER FUNCTION public.obtener_datos_curso(_id integer) OWNER TO postgres;

--
-- TOC entry 304 (class 1255 OID 43103)
-- Name: obtener_datos_docente(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_datos_docente(_cedula character varying) RETURNS TABLE(cedula character varying, nombre character varying, email character varying, contrasenia character varying, estado integer)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.obtener_datos_docente(_cedula character varying) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 42963)
-- Name: obtener_datos_usuario(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_datos_usuario(_usuario character varying) RETURNS TABLE(cedula character varying, nombre character varying, email character varying, tipo character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.obtener_datos_usuario(_usuario character varying) OWNER TO postgres;

--
-- TOC entry 306 (class 1255 OID 43105)
-- Name: obtener_evaluaciones_alumno(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_evaluaciones_alumno(_matricula integer, _id_instancia integer) RETURNS TABLE(id_evaluacion integer, fecha date, porcentaje integer, exigible boolean, unidad_evaluacion character varying, tipo_evaluacion character varying, nota integer)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.obtener_evaluaciones_alumno(_matricula integer, _id_instancia integer) OWNER TO postgres;

--
-- TOC entry 305 (class 1255 OID 43104)
-- Name: obtener_evaluaciones_curso(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_evaluaciones_curso(_id_instancia integer) RETURNS TABLE(id_evaluacion integer, fecha date, porcentaje integer, exigible boolean, unidad_evaluacion character varying, tipo_evaluacion character varying, prorroga character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.obtener_evaluaciones_curso(_id_instancia integer) OWNER TO postgres;

--
-- TOC entry 286 (class 1255 OID 42996)
-- Name: proceso_agregar_log(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.proceso_agregar_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
	IF (TG_OP = 'DELETE') THEN
		INSERT INTO log(operacion, stamp, user_id, nombre_tabla, datos_nuevos, datos_viejos) 
		VALUES ('DELETE', now(), user, TG_TABLE_NAME, NULL, ROW(OLD.*) );
	ELSEIF (TG_OP = 'UPDATE') THEN
		INSERT INTO log(operacion, stamp, user_id, nombre_tabla, datos_nuevos, datos_viejos) 
		VALUES ('UPDATE', now(), user, TG_TABLE_NAME, ROW(NEW.*), ROW(OLD.*));
	ELSEIF (TG_OP = 'INSERT') THEN
		INSERT INTO log(operacion, stamp, user_id, nombre_tabla, datos_nuevos, datos_viejos) 
		VALUES ('INSERT', now(), user, TG_TABLE_NAME, ROW(NEW.*), NULL);
	END IF;
	RETURN NULL;
END;
$$;


ALTER FUNCTION public.proceso_agregar_log() OWNER TO postgres;

--
-- TOC entry 299 (class 1255 OID 42986)
-- Name: valida_rut(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.valida_rut(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
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
$_$;


ALTER FUNCTION public.valida_rut(character varying) OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 42989)
-- Name: verificar_instancia_evaluacion(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.verificar_instancia_evaluacion(_id_instancia integer, _id_alumno integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	cantidad_evaluaciones INTEGER default 0;
	_rec record;
BEGIN
    SELECT COUNT(evaluacion.id)
	FROM evaluacion, instancia_curso, instancia_evaluacion
	WHERE instancia_curso.id=evaluacion.instancia_curso
	AND instancia_evaluacion.alumno=_id_alumno
	AND instancia_curso.id=_id_instancia INTO cantidad_evaluaciones;
	
	SELECT instancia_curso.id AS codigo, 
	instancia_curso.seccion AS seccion,
	curso.nombre AS curso
	FROM curso, instancia_curso
	WHERE instancia_curso.curso=curso.id
	AND instancia_curso.id=_id_instancia INTO _rec;
	
	IF (cantidad_evaluaciones = 0) THEN
		RAISE NOTICE 'No hay evaluaciones en el curso % sección % con código %', _rec.curso, _rec.seccion, _rec.codigo;		
		RETURN 0;
	ELSE
		RAISE NOTICE 'Hay % evaluaciones en el curso % sección % con código %', cantidad_evaluaciones, _rec.curso, _rec.seccion, _rec.codigo;
		RETURN 1;
	END IF;
END;
$$;


ALTER FUNCTION public.verificar_instancia_evaluacion(_id_instancia integer, _id_alumno integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 42638)
-- Name: administrador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrador (
    cedula character varying(9) NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    email character varying(50) NOT NULL,
    contrasenia character varying(50) NOT NULL,
    estado integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.administrador OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 42692)
-- Name: alumno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumno (
    num_matricula integer NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    email character varying(50) NOT NULL,
    contrasenia character varying(50) NOT NULL,
    estado integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.alumno OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 42803)
-- Name: alumno_instancia_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumno_instancia_curso (
    id integer NOT NULL,
    instancia_curso integer NOT NULL,
    alumno integer NOT NULL,
    nota_final integer DEFAULT 0 NOT NULL,
    situacion integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.alumno_instancia_curso OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 42801)
-- Name: alumno_instancia_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alumno_instancia_curso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alumno_instancia_curso_id_seq OWNER TO postgres;

--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 217
-- Name: alumno_instancia_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alumno_instancia_curso_id_seq OWNED BY public.alumno_instancia_curso.id;


--
-- TOC entry 220 (class 1259 OID 42828)
-- Name: archivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.archivo (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL,
    instancia_curso integer NOT NULL,
    docente character varying(9) NOT NULL,
    url character varying(100) NOT NULL
);


ALTER TABLE public.archivo OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 42826)
-- Name: archivo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.archivo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.archivo_id_seq OWNER TO postgres;

--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 219
-- Name: archivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.archivo_id_seq OWNED BY public.archivo.id;


--
-- TOC entry 212 (class 1259 OID 42757)
-- Name: ayudante_instancia_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayudante_instancia_curso (
    id integer NOT NULL,
    instancia_curso integer NOT NULL,
    alumno integer NOT NULL
);


ALTER TABLE public.ayudante_instancia_curso OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 42755)
-- Name: ayudante_instancia_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayudante_instancia_curso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayudante_instancia_curso_id_seq OWNER TO postgres;

--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 211
-- Name: ayudante_instancia_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayudante_instancia_curso_id_seq OWNED BY public.ayudante_instancia_curso.id;


--
-- TOC entry 208 (class 1259 OID 42728)
-- Name: curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curso (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.curso OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 42726)
-- Name: curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.curso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.curso_id_seq OWNER TO postgres;

--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 207
-- Name: curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.curso_id_seq OWNED BY public.curso.id;


--
-- TOC entry 201 (class 1259 OID 42666)
-- Name: dia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dia (
    id integer NOT NULL,
    dia character varying(20) NOT NULL
);


ALTER TABLE public.dia OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 42664)
-- Name: dia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dia_id_seq OWNER TO postgres;

--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 200
-- Name: dia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dia_id_seq OWNED BY public.dia.id;


--
-- TOC entry 199 (class 1259 OID 42651)
-- Name: docente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.docente (
    cedula character varying(9) NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    email character varying(50) NOT NULL,
    contrasenia character varying(50) NOT NULL,
    estado integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.docente OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 42775)
-- Name: docente_invitado_instancia_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.docente_invitado_instancia_curso (
    id integer NOT NULL,
    instancia_curso integer NOT NULL,
    docente character varying(9) NOT NULL
);


ALTER TABLE public.docente_invitado_instancia_curso OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 42773)
-- Name: docente_invitado_instancia_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.docente_invitado_instancia_curso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.docente_invitado_instancia_curso_id_seq OWNER TO postgres;

--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 213
-- Name: docente_invitado_instancia_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.docente_invitado_instancia_curso_id_seq OWNED BY public.docente_invitado_instancia_curso.id;


--
-- TOC entry 230 (class 1259 OID 42902)
-- Name: evaluacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluacion (
    id integer NOT NULL,
    fecha date,
    porcentaje integer NOT NULL,
    exigible boolean NOT NULL,
    unidad integer NOT NULL,
    tipo_evaluacion integer NOT NULL,
    prorroga character varying(50) DEFAULT ' '::character varying,
    instancia_curso integer NOT NULL
);


ALTER TABLE public.evaluacion OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 42900)
-- Name: evaluacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evaluacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evaluacion_id_seq OWNER TO postgres;

--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 229
-- Name: evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evaluacion_id_seq OWNED BY public.evaluacion.id;


--
-- TOC entry 222 (class 1259 OID 42846)
-- Name: historial_reporte_alumno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_reporte_alumno (
    id integer NOT NULL,
    fecha date NOT NULL,
    alumno integer NOT NULL,
    docente character varying(9) NOT NULL,
    url character varying(100) NOT NULL
);


ALTER TABLE public.historial_reporte_alumno OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 42844)
-- Name: historial_reporte_alumno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_reporte_alumno_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historial_reporte_alumno_id_seq OWNER TO postgres;

--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 221
-- Name: historial_reporte_alumno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_reporte_alumno_id_seq OWNED BY public.historial_reporte_alumno.id;


--
-- TOC entry 224 (class 1259 OID 42864)
-- Name: historial_reporte_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_reporte_curso (
    id integer NOT NULL,
    fecha date NOT NULL,
    instancia_curso integer NOT NULL,
    docente character varying(9) NOT NULL,
    url character varying(100) NOT NULL
);


ALTER TABLE public.historial_reporte_curso OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 42862)
-- Name: historial_reporte_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_reporte_curso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historial_reporte_curso_id_seq OWNER TO postgres;

--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 223
-- Name: historial_reporte_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_reporte_curso_id_seq OWNED BY public.historial_reporte_curso.id;


--
-- TOC entry 203 (class 1259 OID 42676)
-- Name: horario_atencion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.horario_atencion (
    id integer NOT NULL,
    dia integer NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_termino time without time zone NOT NULL,
    docente character varying(9) NOT NULL
);


ALTER TABLE public.horario_atencion OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 42674)
-- Name: horario_atencion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.horario_atencion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.horario_atencion_id_seq OWNER TO postgres;

--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 202
-- Name: horario_atencion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.horario_atencion_id_seq OWNED BY public.horario_atencion.id;


--
-- TOC entry 210 (class 1259 OID 42738)
-- Name: instancia_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instancia_curso (
    id integer NOT NULL,
    periodo integer NOT NULL,
    seccion character varying(1) NOT NULL,
    anio integer NOT NULL,
    curso integer NOT NULL,
    docente character varying(9) NOT NULL,
    porcentaje_restante integer DEFAULT 100 NOT NULL
);


ALTER TABLE public.instancia_curso OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 42736)
-- Name: instancia_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instancia_curso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instancia_curso_id_seq OWNER TO postgres;

--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 209
-- Name: instancia_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instancia_curso_id_seq OWNED BY public.instancia_curso.id;


--
-- TOC entry 232 (class 1259 OID 42926)
-- Name: instancia_evaluacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instancia_evaluacion (
    id integer NOT NULL,
    alumno integer NOT NULL,
    evaluacion integer NOT NULL,
    nota integer DEFAULT 0
);


ALTER TABLE public.instancia_evaluacion OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 42924)
-- Name: instancia_evaluacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instancia_evaluacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instancia_evaluacion_id_seq OWNER TO postgres;

--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 231
-- Name: instancia_evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instancia_evaluacion_id_seq OWNED BY public.instancia_evaluacion.id;


--
-- TOC entry 234 (class 1259 OID 42945)
-- Name: log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log (
    id_log bigint NOT NULL,
    operacion character varying(15) NOT NULL,
    stamp timestamp without time zone NOT NULL,
    user_id text NOT NULL,
    nombre_tabla character varying(50) NOT NULL,
    datos_nuevos text,
    datos_viejos text
);


ALTER TABLE public.log OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 42943)
-- Name: log_id_log_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.log ALTER COLUMN id_log ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.log_id_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 206 (class 1259 OID 42707)
-- Name: observacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.observacion (
    id integer NOT NULL,
    alumno integer NOT NULL,
    docente character varying(9) NOT NULL,
    observacion character varying(500) NOT NULL
);


ALTER TABLE public.observacion OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 42705)
-- Name: observacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.observacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.observacion_id_seq OWNER TO postgres;

--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 205
-- Name: observacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.observacion_id_seq OWNED BY public.observacion.id;


--
-- TOC entry 216 (class 1259 OID 42793)
-- Name: situacion_alumno_instancia_curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.situacion_alumno_instancia_curso (
    id integer NOT NULL,
    situacion character varying(20) NOT NULL
);


ALTER TABLE public.situacion_alumno_instancia_curso OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 42791)
-- Name: situacion_alumno_instancia_curso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.situacion_alumno_instancia_curso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.situacion_alumno_instancia_curso_id_seq OWNER TO postgres;

--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 215
-- Name: situacion_alumno_instancia_curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.situacion_alumno_instancia_curso_id_seq OWNED BY public.situacion_alumno_instancia_curso.id;


--
-- TOC entry 197 (class 1259 OID 42630)
-- Name: tipo_estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_estado (
    id integer NOT NULL,
    tipo character varying(20) NOT NULL
);


ALTER TABLE public.tipo_estado OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 42628)
-- Name: tipo_estado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_estado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_estado_id_seq OWNER TO postgres;

--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 196
-- Name: tipo_estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_estado_id_seq OWNED BY public.tipo_estado.id;


--
-- TOC entry 226 (class 1259 OID 42882)
-- Name: tipo_evaluacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_evaluacion (
    id integer NOT NULL,
    tipo character varying(20) NOT NULL
);


ALTER TABLE public.tipo_evaluacion OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 42880)
-- Name: tipo_evaluacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_evaluacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_evaluacion_id_seq OWNER TO postgres;

--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 225
-- Name: tipo_evaluacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_evaluacion_id_seq OWNED BY public.tipo_evaluacion.id;


--
-- TOC entry 228 (class 1259 OID 42892)
-- Name: unidad_aprendizaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unidad_aprendizaje (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.unidad_aprendizaje OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 42890)
-- Name: unidad_aprendizaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unidad_aprendizaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unidad_aprendizaje_id_seq OWNER TO postgres;

--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 227
-- Name: unidad_aprendizaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unidad_aprendizaje_id_seq OWNED BY public.unidad_aprendizaje.id;


--
-- TOC entry 2874 (class 2604 OID 42806)
-- Name: alumno_instancia_curso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno_instancia_curso ALTER COLUMN id SET DEFAULT nextval('public.alumno_instancia_curso_id_seq'::regclass);


--
-- TOC entry 2877 (class 2604 OID 42831)
-- Name: archivo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archivo ALTER COLUMN id SET DEFAULT nextval('public.archivo_id_seq'::regclass);


--
-- TOC entry 2871 (class 2604 OID 42760)
-- Name: ayudante_instancia_curso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayudante_instancia_curso ALTER COLUMN id SET DEFAULT nextval('public.ayudante_instancia_curso_id_seq'::regclass);


--
-- TOC entry 2868 (class 2604 OID 42731)
-- Name: curso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curso ALTER COLUMN id SET DEFAULT nextval('public.curso_id_seq'::regclass);


--
-- TOC entry 2864 (class 2604 OID 42669)
-- Name: dia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dia ALTER COLUMN id SET DEFAULT nextval('public.dia_id_seq'::regclass);


--
-- TOC entry 2872 (class 2604 OID 42778)
-- Name: docente_invitado_instancia_curso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docente_invitado_instancia_curso ALTER COLUMN id SET DEFAULT nextval('public.docente_invitado_instancia_curso_id_seq'::regclass);


--
-- TOC entry 2882 (class 2604 OID 42905)
-- Name: evaluacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluacion ALTER COLUMN id SET DEFAULT nextval('public.evaluacion_id_seq'::regclass);


--
-- TOC entry 2878 (class 2604 OID 42849)
-- Name: historial_reporte_alumno id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reporte_alumno ALTER COLUMN id SET DEFAULT nextval('public.historial_reporte_alumno_id_seq'::regclass);


--
-- TOC entry 2879 (class 2604 OID 42867)
-- Name: historial_reporte_curso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reporte_curso ALTER COLUMN id SET DEFAULT nextval('public.historial_reporte_curso_id_seq'::regclass);


--
-- TOC entry 2865 (class 2604 OID 42679)
-- Name: horario_atencion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_atencion ALTER COLUMN id SET DEFAULT nextval('public.horario_atencion_id_seq'::regclass);


--
-- TOC entry 2869 (class 2604 OID 42741)
-- Name: instancia_curso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_curso ALTER COLUMN id SET DEFAULT nextval('public.instancia_curso_id_seq'::regclass);


--
-- TOC entry 2884 (class 2604 OID 42929)
-- Name: instancia_evaluacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_evaluacion ALTER COLUMN id SET DEFAULT nextval('public.instancia_evaluacion_id_seq'::regclass);


--
-- TOC entry 2867 (class 2604 OID 42710)
-- Name: observacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observacion ALTER COLUMN id SET DEFAULT nextval('public.observacion_id_seq'::regclass);


--
-- TOC entry 2873 (class 2604 OID 42796)
-- Name: situacion_alumno_instancia_curso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.situacion_alumno_instancia_curso ALTER COLUMN id SET DEFAULT nextval('public.situacion_alumno_instancia_curso_id_seq'::regclass);


--
-- TOC entry 2861 (class 2604 OID 42633)
-- Name: tipo_estado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_estado ALTER COLUMN id SET DEFAULT nextval('public.tipo_estado_id_seq'::regclass);


--
-- TOC entry 2880 (class 2604 OID 42885)
-- Name: tipo_evaluacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_evaluacion ALTER COLUMN id SET DEFAULT nextval('public.tipo_evaluacion_id_seq'::regclass);


--
-- TOC entry 2881 (class 2604 OID 42895)
-- Name: unidad_aprendizaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidad_aprendizaje ALTER COLUMN id SET DEFAULT nextval('public.unidad_aprendizaje_id_seq'::regclass);


--
-- TOC entry 3119 (class 0 OID 42638)
-- Dependencies: 198
-- Data for Name: administrador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administrador (cedula, nombre_completo, email, contrasenia, estado) FROM stdin;
190167771	MATÍAS PARRA	MPARRA13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
\.


--
-- TOC entry 3125 (class 0 OID 42692)
-- Dependencies: 204
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alumno (num_matricula, nombre_completo, email, contrasenia, estado) FROM stdin;
2013407015	MANUEL NICOLÁS GONZÁLEZ GUERRERO	MGONZALEZ13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
2013407001	PEDRO ARAVENA	PARAVENA13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
2013407002	MARCELA CABALLO	MCABALLO13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
2013407003	JOAQUÍAN DURÁN	JDURAN13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
2013407004	PEDRO PARRA	PPARRA13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
2013407006	CATHERINA SOTO	CSOTO13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
2013407010	FELIPE DONOSO	FDONOSO13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
2013407011	ALEJANDRA LÓPEZ	ALOPEZ13@ALUMNOS.UTALCA.CL	202cb962ac59075b964b07152d234b70	1
\.


--
-- TOC entry 3139 (class 0 OID 42803)
-- Dependencies: 218
-- Data for Name: alumno_instancia_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alumno_instancia_curso (id, instancia_curso, alumno, nota_final, situacion) FROM stdin;
2	4	2013407015	10	1
3	4	2013407010	10	1
4	4	2013407001	10	1
5	10	2013407001	10	1
6	10	2013407010	10	1
7	10	2013407004	10	1
8	6	2013407004	10	1
9	6	2013407010	10	1
10	6	2013407001	10	1
\.


--
-- TOC entry 3141 (class 0 OID 42828)
-- Dependencies: 220
-- Data for Name: archivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.archivo (id, nombre, instancia_curso, docente, url) FROM stdin;
\.


--
-- TOC entry 3133 (class 0 OID 42757)
-- Dependencies: 212
-- Data for Name: ayudante_instancia_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ayudante_instancia_curso (id, instancia_curso, alumno) FROM stdin;
\.


--
-- TOC entry 3129 (class 0 OID 42728)
-- Dependencies: 208
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.curso (id, nombre) FROM stdin;
14	Sistemas distribuidos
15	Diseño de Bases de Datos
16	Calculo 1
17	Programacion Avanzada
18	Seguridad informatica
13	SOLUCIÓN ALGORÍTMICA DE PROBLEMAS
19	GESTIÓN DE BASE DE DATOS
\.


--
-- TOC entry 3122 (class 0 OID 42666)
-- Dependencies: 201
-- Data for Name: dia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dia (id, dia) FROM stdin;
\.


--
-- TOC entry 3120 (class 0 OID 42651)
-- Dependencies: 199
-- Data for Name: docente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.docente (cedula, nombre_completo, email, contrasenia, estado) FROM stdin;
118885333	CAMILA ROJAS	CROJAS@UTALCA.CL	202cb962ac59075b964b07152d234b70	1
95069908	IGOR CASTRO	ICASTRO@UTALCA.CL	202cb962ac59075b964b07152d234b70	1
249874426	PEDRO PABLO ROJAS	PROJAS@UTALCA.CL	202cb962ac59075b964b07152d234b70	1
75558589	MARCELO CARREÑO	MCARRENO@UTALCA.CL	202cb962ac59075b964b07152d234b70	1
150425867	MARCELA CAMILA PINTO ROJAS	MPINTO@UTALCA.CL	202cb962ac59075b964b07152d234b70	1
75601263	MANUEL ROBERTO MONTECINOS SOTO	MMONTECINOS@UTALCA.CL	202cb962ac59075b964b07152d234b70	1
\.


--
-- TOC entry 3135 (class 0 OID 42775)
-- Dependencies: 214
-- Data for Name: docente_invitado_instancia_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.docente_invitado_instancia_curso (id, instancia_curso, docente) FROM stdin;
\.


--
-- TOC entry 3151 (class 0 OID 42902)
-- Dependencies: 230
-- Data for Name: evaluacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluacion (id, fecha, porcentaje, exigible, unidad, tipo_evaluacion, prorroga, instancia_curso) FROM stdin;
3	2020-03-03	10	t	1	1		5
\.


--
-- TOC entry 3143 (class 0 OID 42846)
-- Dependencies: 222
-- Data for Name: historial_reporte_alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_reporte_alumno (id, fecha, alumno, docente, url) FROM stdin;
\.


--
-- TOC entry 3145 (class 0 OID 42864)
-- Dependencies: 224
-- Data for Name: historial_reporte_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_reporte_curso (id, fecha, instancia_curso, docente, url) FROM stdin;
\.


--
-- TOC entry 3124 (class 0 OID 42676)
-- Dependencies: 203
-- Data for Name: horario_atencion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.horario_atencion (id, dia, hora_inicio, hora_termino, docente) FROM stdin;
\.


--
-- TOC entry 3131 (class 0 OID 42738)
-- Dependencies: 210
-- Data for Name: instancia_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instancia_curso (id, periodo, seccion, anio, curso, docente, porcentaje_restante) FROM stdin;
4	1	A	2020	13	118885333	100
5	1	A	2020	14	118885333	100
6	1	A	2020	15	118885333	100
7	1	A	2020	16	118885333	100
8	1	A	2020	17	118885333	100
9	1	A	2020	18	118885333	100
10	1	A	2020	19	75601263	100
\.


--
-- TOC entry 3153 (class 0 OID 42926)
-- Dependencies: 232
-- Data for Name: instancia_evaluacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instancia_evaluacion (id, alumno, evaluacion, nota) FROM stdin;
\.


--
-- TOC entry 3155 (class 0 OID 42945)
-- Dependencies: 234
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log (id_log, operacion, stamp, user_id, nombre_tabla, datos_nuevos, datos_viejos) FROM stdin;
1	INSERT	2020-03-12 13:54:45.535078	postgres	tipo_estado	(1,ACTIVO)	\N
2	INSERT	2020-03-12 13:54:50.644585	postgres	administrador	(190167771,"MATÍAS PARRA",MPARRA13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
3	INSERT	2020-03-12 13:56:08.033185	postgres	alumno	(2013407015,"MANUEL GONZÁLEZ",MGONZALEZ13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
4	INSERT	2020-03-12 14:15:28.593469	postgres	docente	(118885333,MAL,MAL@UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
17	INSERT	2020-03-12 14:18:54.708776	postgres	curso	(13,"Solucion Algoritmica")	\N
18	INSERT	2020-03-12 14:18:54.708776	postgres	curso	(14,"Sistemas distribuidos")	\N
19	INSERT	2020-03-12 14:18:54.708776	postgres	curso	(15,"Diseño de Bases de Datos")	\N
20	INSERT	2020-03-12 14:18:54.708776	postgres	curso	(16,"Calculo 1")	\N
21	INSERT	2020-03-12 14:18:54.708776	postgres	curso	(17,"Programacion Avanzada")	\N
22	INSERT	2020-03-12 14:18:54.708776	postgres	curso	(18,"Seguridad informatica")	\N
23	INSERT	2020-03-12 14:19:42.525872	postgres	instancia_curso	(4,1,A,2020,13,118885333,100)	\N
24	INSERT	2020-03-12 14:19:42.525872	postgres	instancia_curso	(5,1,A,2020,14,118885333,100)	\N
25	INSERT	2020-03-12 14:19:42.525872	postgres	instancia_curso	(6,1,A,2020,15,118885333,100)	\N
26	INSERT	2020-03-12 14:19:42.525872	postgres	instancia_curso	(7,1,A,2020,16,118885333,100)	\N
27	INSERT	2020-03-12 14:19:42.525872	postgres	instancia_curso	(8,1,A,2020,17,118885333,100)	\N
28	INSERT	2020-03-12 14:19:42.525872	postgres	instancia_curso	(9,1,A,2020,18,118885333,100)	\N
29	UPDATE	2020-03-13 18:28:49.893269	postgres	alumno	(2013407015,"MANUEL NICOLÁS GONZÁLEZ GUERRERO",MGONZALEZ13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	(2013407015,"MANUEL GONZÁLEZ",MGONZALEZ13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)
30	UPDATE	2020-03-13 18:31:11.1735	postgres	alumno	(2013407015,"MANUEL GONZÁLEZ GUERRERO",MGONZALEZ13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	(2013407015,"MANUEL NICOLÁS GONZÁLEZ GUERRERO",MGONZALEZ13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)
31	UPDATE	2020-03-13 18:34:19.91648	postgres	alumno	(2013407015,"MANUEL NICOLÁS GONZÁLEZ GUERRERO",MGONZALEZ13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	(2013407015,"MANUEL GONZÁLEZ GUERRERO",MGONZALEZ13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)
32	UPDATE	2020-03-13 20:06:16.21482	postgres	curso	(13,"SOLUCIÓN ALGORÍTMICA DE PROBLEMAS")	(13,"Solucion Algoritmica")
33	UPDATE	2020-03-13 20:26:53.981041	postgres	docente	(118885333,"CAMILA ROJAS",CROJAS@UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	(118885333,MAL,MAL@UTALCA.CL,202cb962ac59075b964b07152d234b70,1)
34	INSERT	2020-03-13 20:35:27.766686	postgres	alumno	(2013407001,"PEDRO ARAVENA",PARAVENA13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
35	INSERT	2020-03-13 20:40:52.212007	postgres	curso	(19,"GESTIÓN DE BASE DE DATOS")	\N
36	INSERT	2020-03-13 20:46:03.610464	postgres	docente	(95069908,"IGOR CASTRO",ICASTRO@UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
37	INSERT	2020-03-13 22:25:41.047158	postgres	alumno	(2013407002,"MARCELA CABALLO",MCABALLO13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
38	INSERT	2020-03-13 22:26:17.674763	postgres	alumno	(2013407003,"JOAQUÍAN DURÁN",JDURAN13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
39	INSERT	2020-03-13 22:26:56.600116	postgres	alumno	(2013407004,"PEDRO PARRA",PPARRA13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
40	INSERT	2020-03-13 22:27:40.885213	postgres	alumno	(2013407006,"CATHERINA SOTO",CSOTO13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
41	INSERT	2020-03-13 22:28:21.304046	postgres	alumno	(2013407010,"FELIPE DONOSO",FDONOSO13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
42	INSERT	2020-03-13 22:29:09.539123	postgres	alumno	(2013407011,"ALEJANDRA LÓPEZ",ALOPEZ13@ALUMNOS.UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
43	INSERT	2020-03-13 22:30:09.896297	postgres	docente	(249874426,"PEDRO PABLO ROJAS",PROJAS@UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
44	INSERT	2020-03-13 22:30:54.18844	postgres	docente	(75558589,"MARCELO CARREÑO",MCARRENO@UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
45	INSERT	2020-03-13 22:31:46.576288	postgres	docente	(150425867,"MARCELA CAMILA PINTO ROJAS",MPINTO@UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
46	INSERT	2020-03-13 22:33:00.029478	postgres	docente	(75601263,"MANUEL ROBERTO MONTECINOS SOTO",MMONTECINOS@UTALCA.CL,202cb962ac59075b964b07152d234b70,1)	\N
47	INSERT	2020-03-13 22:36:13.031467	postgres	unidad_aprendizaje	(1,"UNIDAD 1")	\N
48	INSERT	2020-03-13 22:36:18.102732	postgres	unidad_aprendizaje	(2,"UNIDAD 2")	\N
49	INSERT	2020-03-13 22:36:22.17747	postgres	unidad_aprendizaje	(3,"UNIDAD 3")	\N
50	INSERT	2020-03-13 22:36:26.510959	postgres	unidad_aprendizaje	(4,"UNIDAD 4")	\N
51	INSERT	2020-03-13 22:36:30.348017	postgres	unidad_aprendizaje	(5,"UNIDAD 5")	\N
52	INSERT	2020-03-13 22:36:54.533147	postgres	unidad_aprendizaje	(6,"UNIDAD 6")	\N
53	INSERT	2020-03-13 22:36:58.67486	postgres	unidad_aprendizaje	(7,"UNIDAD 7")	\N
54	INSERT	2020-03-13 22:37:50.405869	postgres	tipo_evaluacion	(1,PRUEBA)	\N
55	INSERT	2020-03-13 22:38:01.335642	postgres	tipo_evaluacion	(2,PROYECTO)	\N
56	INSERT	2020-03-13 22:38:10.034659	postgres	tipo_evaluacion	(3,LABORATORIO)	\N
57	INSERT	2020-03-13 22:38:19.653227	postgres	tipo_evaluacion	(4,TAREA)	\N
58	INSERT	2020-03-13 22:38:28.440148	postgres	tipo_evaluacion	(5,ENTREGABLE)	\N
59	INSERT	2020-03-13 22:38:34.457449	postgres	tipo_evaluacion	(6,INFORME)	\N
60	INSERT	2020-03-13 22:45:24.900443	postgres	instancia_curso	(10,1,A,2020,19,75601263,100)	\N
61	INSERT	2020-03-13 22:53:39.753863	postgres	situacion_alumno_instancia_curso	(1,CURSANDO)	\N
62	INSERT	2020-03-13 22:53:43.798607	postgres	alumno_instancia_curso	(2,4,2013407015,10,1)	\N
63	INSERT	2020-03-13 22:53:53.780678	postgres	situacion_alumno_instancia_curso	(2,APROVADO)	\N
64	INSERT	2020-03-13 22:54:36.339134	postgres	situacion_alumno_instancia_curso	(3,REPROBADO)	\N
65	UPDATE	2020-03-13 22:56:17.18194	postgres	situacion_alumno_instancia_curso	(1,APROBADO)	(1,CURSANDO)
66	UPDATE	2020-03-13 22:57:01.470949	postgres	situacion_alumno_instancia_curso	(1,CURSANDO)	(1,APROBADO)
67	UPDATE	2020-03-13 22:57:09.49481	postgres	situacion_alumno_instancia_curso	(2,APROBADO)	(2,APROVADO)
68	INSERT	2020-03-13 22:58:52.880166	postgres	alumno_instancia_curso	(3,4,2013407010,10,1)	\N
69	INSERT	2020-03-13 22:59:02.432458	postgres	alumno_instancia_curso	(4,4,2013407001,10,1)	\N
70	INSERT	2020-03-13 22:59:25.740859	postgres	alumno_instancia_curso	(5,10,2013407001,10,1)	\N
71	INSERT	2020-03-13 22:59:32.561082	postgres	alumno_instancia_curso	(6,10,2013407010,10,1)	\N
72	INSERT	2020-03-13 22:59:38.885929	postgres	alumno_instancia_curso	(7,10,2013407004,10,1)	\N
73	INSERT	2020-03-13 22:59:51.433218	postgres	alumno_instancia_curso	(8,6,2013407004,10,1)	\N
74	INSERT	2020-03-13 22:59:57.492742	postgres	alumno_instancia_curso	(9,6,2013407010,10,1)	\N
75	INSERT	2020-03-13 23:00:02.155661	postgres	alumno_instancia_curso	(10,6,2013407001,10,1)	\N
78	INSERT	2020-03-13 23:22:51.646866	postgres	evaluacion	(3,2020-03-03,10,t,1,1,"",5)	\N
\.


--
-- TOC entry 3127 (class 0 OID 42707)
-- Dependencies: 206
-- Data for Name: observacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.observacion (id, alumno, docente, observacion) FROM stdin;
\.


--
-- TOC entry 3137 (class 0 OID 42793)
-- Dependencies: 216
-- Data for Name: situacion_alumno_instancia_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.situacion_alumno_instancia_curso (id, situacion) FROM stdin;
3	REPROBADO
1	CURSANDO
2	APROBADO
\.


--
-- TOC entry 3118 (class 0 OID 42630)
-- Dependencies: 197
-- Data for Name: tipo_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_estado (id, tipo) FROM stdin;
1	ACTIVO
\.


--
-- TOC entry 3147 (class 0 OID 42882)
-- Dependencies: 226
-- Data for Name: tipo_evaluacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_evaluacion (id, tipo) FROM stdin;
1	PRUEBA
2	PROYECTO
3	LABORATORIO
4	TAREA
5	ENTREGABLE
6	INFORME
\.


--
-- TOC entry 3149 (class 0 OID 42892)
-- Dependencies: 228
-- Data for Name: unidad_aprendizaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unidad_aprendizaje (id, nombre) FROM stdin;
1	UNIDAD 1
2	UNIDAD 2
3	UNIDAD 3
4	UNIDAD 4
5	UNIDAD 5
6	UNIDAD 6
7	UNIDAD 7
\.


--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 217
-- Name: alumno_instancia_curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alumno_instancia_curso_id_seq', 10, true);


--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 219
-- Name: archivo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.archivo_id_seq', 1, false);


--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 211
-- Name: ayudante_instancia_curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ayudante_instancia_curso_id_seq', 1, false);


--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 207
-- Name: curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.curso_id_seq', 19, true);


--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 200
-- Name: dia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dia_id_seq', 1, false);


--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 213
-- Name: docente_invitado_instancia_curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.docente_invitado_instancia_curso_id_seq', 1, false);


--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 229
-- Name: evaluacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evaluacion_id_seq', 6, true);


--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 221
-- Name: historial_reporte_alumno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_reporte_alumno_id_seq', 1, false);


--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 223
-- Name: historial_reporte_curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_reporte_curso_id_seq', 1, false);


--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 202
-- Name: horario_atencion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horario_atencion_id_seq', 1, false);


--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 209
-- Name: instancia_curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instancia_curso_id_seq', 10, true);


--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 231
-- Name: instancia_evaluacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instancia_evaluacion_id_seq', 1, false);


--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 233
-- Name: log_id_log_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_id_log_seq', 81, true);


--
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 205
-- Name: observacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.observacion_id_seq', 1, false);


--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 215
-- Name: situacion_alumno_instancia_curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.situacion_alumno_instancia_curso_id_seq', 3, true);


--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 196
-- Name: tipo_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_estado_id_seq', 1, true);


--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 225
-- Name: tipo_evaluacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_evaluacion_id_seq', 6, true);


--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 227
-- Name: unidad_aprendizaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unidad_aprendizaje_id_seq', 7, true);


--
-- TOC entry 2891 (class 2606 OID 42645)
-- Name: administrador administrador_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrador
    ADD CONSTRAINT administrador_email_key UNIQUE (email);


--
-- TOC entry 2905 (class 2606 OID 42699)
-- Name: alumno alumno_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT alumno_email_key UNIQUE (email);


--
-- TOC entry 2925 (class 2606 OID 42810)
-- Name: alumno_instancia_curso alumno_instancia_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno_instancia_curso
    ADD CONSTRAINT alumno_instancia_curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2927 (class 2606 OID 42833)
-- Name: archivo archivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archivo
    ADD CONSTRAINT archivo_pkey PRIMARY KEY (id);


--
-- TOC entry 2917 (class 2606 OID 42762)
-- Name: ayudante_instancia_curso ayudante_instancia_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayudante_instancia_curso
    ADD CONSTRAINT ayudante_instancia_curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2893 (class 2606 OID 42643)
-- Name: administrador cedula_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrador
    ADD CONSTRAINT cedula_admin_pkey PRIMARY KEY (cedula);


--
-- TOC entry 2895 (class 2606 OID 42656)
-- Name: docente cedula_profesor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docente
    ADD CONSTRAINT cedula_profesor_pkey PRIMARY KEY (cedula);


--
-- TOC entry 2911 (class 2606 OID 42735)
-- Name: curso curso_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_nombre_key UNIQUE (nombre);


--
-- TOC entry 2913 (class 2606 OID 42733)
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2899 (class 2606 OID 42673)
-- Name: dia dia_dia_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dia
    ADD CONSTRAINT dia_dia_key UNIQUE (dia);


--
-- TOC entry 2901 (class 2606 OID 42671)
-- Name: dia dia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dia
    ADD CONSTRAINT dia_pkey PRIMARY KEY (id);


--
-- TOC entry 2897 (class 2606 OID 42658)
-- Name: docente docente_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docente
    ADD CONSTRAINT docente_email_key UNIQUE (email);


--
-- TOC entry 2919 (class 2606 OID 42780)
-- Name: docente_invitado_instancia_curso docente_invitado_instancia_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docente_invitado_instancia_curso
    ADD CONSTRAINT docente_invitado_instancia_curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2941 (class 2606 OID 42908)
-- Name: evaluacion evaluacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluacion
    ADD CONSTRAINT evaluacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2929 (class 2606 OID 42851)
-- Name: historial_reporte_alumno historial_reporte_alumno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reporte_alumno
    ADD CONSTRAINT historial_reporte_alumno_pkey PRIMARY KEY (id);


--
-- TOC entry 2931 (class 2606 OID 42869)
-- Name: historial_reporte_curso historial_reporte_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reporte_curso
    ADD CONSTRAINT historial_reporte_curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2903 (class 2606 OID 42681)
-- Name: horario_atencion horario_atencion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_atencion
    ADD CONSTRAINT horario_atencion_pkey PRIMARY KEY (id);


--
-- TOC entry 2915 (class 2606 OID 42744)
-- Name: instancia_curso instancia_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_curso
    ADD CONSTRAINT instancia_curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2943 (class 2606 OID 42932)
-- Name: instancia_evaluacion instancia_evaluacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_evaluacion
    ADD CONSTRAINT instancia_evaluacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2945 (class 2606 OID 42952)
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id_log);


--
-- TOC entry 2907 (class 2606 OID 42697)
-- Name: alumno num_matricula_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT num_matricula_pkey PRIMARY KEY (num_matricula);


--
-- TOC entry 2909 (class 2606 OID 42715)
-- Name: observacion observacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observacion
    ADD CONSTRAINT observacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2921 (class 2606 OID 42798)
-- Name: situacion_alumno_instancia_curso situacion_alumno_instancia_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.situacion_alumno_instancia_curso
    ADD CONSTRAINT situacion_alumno_instancia_curso_pkey PRIMARY KEY (id);


--
-- TOC entry 2923 (class 2606 OID 42800)
-- Name: situacion_alumno_instancia_curso situacion_alumno_instancia_curso_situacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.situacion_alumno_instancia_curso
    ADD CONSTRAINT situacion_alumno_instancia_curso_situacion_key UNIQUE (situacion);


--
-- TOC entry 2887 (class 2606 OID 42635)
-- Name: tipo_estado tipo_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_estado
    ADD CONSTRAINT tipo_estado_pkey PRIMARY KEY (id);


--
-- TOC entry 2889 (class 2606 OID 42637)
-- Name: tipo_estado tipo_estado_tipo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_estado
    ADD CONSTRAINT tipo_estado_tipo_key UNIQUE (tipo);


--
-- TOC entry 2933 (class 2606 OID 42887)
-- Name: tipo_evaluacion tipo_evaluacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_evaluacion
    ADD CONSTRAINT tipo_evaluacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2935 (class 2606 OID 42889)
-- Name: tipo_evaluacion tipo_evaluacion_tipo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_evaluacion
    ADD CONSTRAINT tipo_evaluacion_tipo_key UNIQUE (tipo);


--
-- TOC entry 2937 (class 2606 OID 42899)
-- Name: unidad_aprendizaje unidad_aprendizaje_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidad_aprendizaje
    ADD CONSTRAINT unidad_aprendizaje_nombre_key UNIQUE (nombre);


--
-- TOC entry 2939 (class 2606 OID 42897)
-- Name: unidad_aprendizaje unidad_aprendizaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidad_aprendizaje
    ADD CONSTRAINT unidad_aprendizaje_pkey PRIMARY KEY (id);


--
-- TOC entry 2993 (class 2620 OID 42956)
-- Name: evaluacion actualizar_evaluacion_por_alumno; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER actualizar_evaluacion_por_alumno AFTER UPDATE ON public.evaluacion FOR EACH ROW EXECUTE PROCEDURE public.cursor_actualizar_evaluacion_por_alumno();


--
-- TOC entry 2992 (class 2620 OID 42954)
-- Name: evaluacion agregar_evaluacion_por_alumno; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_evaluacion_por_alumno AFTER INSERT ON public.evaluacion FOR EACH ROW EXECUTE PROCEDURE public.cursor_agregar_evaluacion_por_alumno();


--
-- TOC entry 2974 (class 2620 OID 42998)
-- Name: administrador agregar_log_administrador; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_administrador AFTER INSERT OR DELETE OR UPDATE ON public.administrador FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2978 (class 2620 OID 43002)
-- Name: alumno agregar_log_alumno; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_alumno AFTER INSERT OR DELETE OR UPDATE ON public.alumno FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2985 (class 2620 OID 43009)
-- Name: alumno_instancia_curso agregar_log_alumno_instancia_curso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_alumno_instancia_curso AFTER INSERT OR DELETE OR UPDATE ON public.alumno_instancia_curso FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2987 (class 2620 OID 43010)
-- Name: archivo agregar_log_archivo; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_archivo AFTER INSERT OR DELETE OR UPDATE ON public.archivo FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2982 (class 2620 OID 43006)
-- Name: ayudante_instancia_curso agregar_log_ayudante_instancia_curso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_ayudante_instancia_curso AFTER INSERT OR DELETE OR UPDATE ON public.ayudante_instancia_curso FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2980 (class 2620 OID 43004)
-- Name: curso agregar_log_curso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_curso AFTER INSERT OR DELETE OR UPDATE ON public.curso FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2976 (class 2620 OID 43000)
-- Name: dia agregar_log_dia; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_dia AFTER INSERT OR DELETE OR UPDATE ON public.dia FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2975 (class 2620 OID 42999)
-- Name: docente agregar_log_docente; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_docente AFTER INSERT OR DELETE OR UPDATE ON public.docente FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2983 (class 2620 OID 43007)
-- Name: docente_invitado_instancia_curso agregar_log_docente_invitado_instancia_curso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_docente_invitado_instancia_curso AFTER INSERT OR DELETE OR UPDATE ON public.docente_invitado_instancia_curso FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2994 (class 2620 OID 43015)
-- Name: evaluacion agregar_log_evaluacion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_evaluacion AFTER INSERT OR DELETE OR UPDATE ON public.evaluacion FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2988 (class 2620 OID 43011)
-- Name: historial_reporte_alumno agregar_log_historial_reporte_alumno; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_historial_reporte_alumno AFTER INSERT OR DELETE OR UPDATE ON public.historial_reporte_alumno FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2989 (class 2620 OID 43012)
-- Name: historial_reporte_curso agregar_log_historial_reporte_curso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_historial_reporte_curso AFTER INSERT OR DELETE OR UPDATE ON public.historial_reporte_curso FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2977 (class 2620 OID 43001)
-- Name: horario_atencion agregar_log_horario_atencion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_horario_atencion AFTER INSERT OR DELETE OR UPDATE ON public.horario_atencion FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2981 (class 2620 OID 43005)
-- Name: instancia_curso agregar_log_instancia_curso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_instancia_curso AFTER INSERT OR DELETE OR UPDATE ON public.instancia_curso FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2995 (class 2620 OID 43016)
-- Name: instancia_evaluacion agregar_log_instancia_evaluacion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_instancia_evaluacion AFTER INSERT OR DELETE OR UPDATE ON public.instancia_evaluacion FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2979 (class 2620 OID 43003)
-- Name: observacion agregar_log_observacion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_observacion AFTER INSERT OR DELETE OR UPDATE ON public.observacion FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2984 (class 2620 OID 43008)
-- Name: situacion_alumno_instancia_curso agregar_log_situacion_alumno_instancia_curso; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_situacion_alumno_instancia_curso AFTER INSERT OR DELETE OR UPDATE ON public.situacion_alumno_instancia_curso FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2973 (class 2620 OID 42997)
-- Name: tipo_estado agregar_log_tipo_estado; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_tipo_estado AFTER INSERT OR DELETE OR UPDATE ON public.tipo_estado FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2990 (class 2620 OID 43013)
-- Name: tipo_evaluacion agregar_log_tipo_evaluacion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_tipo_evaluacion AFTER INSERT OR DELETE OR UPDATE ON public.tipo_evaluacion FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2991 (class 2620 OID 43014)
-- Name: unidad_aprendizaje agregar_log_unidad_aprendizaje; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER agregar_log_unidad_aprendizaje AFTER INSERT OR DELETE OR UPDATE ON public.unidad_aprendizaje FOR EACH ROW EXECUTE PROCEDURE public.proceso_agregar_log();


--
-- TOC entry 2986 (class 2620 OID 43018)
-- Name: alumno_instancia_curso modificacion_nota; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER modificacion_nota AFTER UPDATE OF nota_final ON public.alumno_instancia_curso FOR EACH ROW EXECUTE PROCEDURE public.actualizar_promedio();


--
-- TOC entry 2951 (class 2606 OID 42716)
-- Name: observacion alumno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observacion
    ADD CONSTRAINT alumno FOREIGN KEY (alumno) REFERENCES public.alumno(num_matricula);


--
-- TOC entry 2956 (class 2606 OID 42768)
-- Name: ayudante_instancia_curso alumno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayudante_instancia_curso
    ADD CONSTRAINT alumno FOREIGN KEY (alumno) REFERENCES public.alumno(num_matricula);


--
-- TOC entry 2960 (class 2606 OID 42816)
-- Name: alumno_instancia_curso alumno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno_instancia_curso
    ADD CONSTRAINT alumno FOREIGN KEY (alumno) REFERENCES public.alumno(num_matricula);


--
-- TOC entry 2964 (class 2606 OID 42852)
-- Name: historial_reporte_alumno alumno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reporte_alumno
    ADD CONSTRAINT alumno FOREIGN KEY (alumno) REFERENCES public.alumno(num_matricula);


--
-- TOC entry 2971 (class 2606 OID 42933)
-- Name: instancia_evaluacion alumno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_evaluacion
    ADD CONSTRAINT alumno FOREIGN KEY (alumno) REFERENCES public.alumno(num_matricula);


--
-- TOC entry 2953 (class 2606 OID 42745)
-- Name: instancia_curso curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_curso
    ADD CONSTRAINT curso FOREIGN KEY (curso) REFERENCES public.curso(id);


--
-- TOC entry 2948 (class 2606 OID 42682)
-- Name: horario_atencion dia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_atencion
    ADD CONSTRAINT dia FOREIGN KEY (dia) REFERENCES public.dia(id);


--
-- TOC entry 2949 (class 2606 OID 42687)
-- Name: horario_atencion docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horario_atencion
    ADD CONSTRAINT docente FOREIGN KEY (docente) REFERENCES public.docente(cedula);


--
-- TOC entry 2952 (class 2606 OID 42721)
-- Name: observacion docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observacion
    ADD CONSTRAINT docente FOREIGN KEY (docente) REFERENCES public.docente(cedula);


--
-- TOC entry 2954 (class 2606 OID 42750)
-- Name: instancia_curso docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_curso
    ADD CONSTRAINT docente FOREIGN KEY (docente) REFERENCES public.docente(cedula);


--
-- TOC entry 2958 (class 2606 OID 42786)
-- Name: docente_invitado_instancia_curso docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docente_invitado_instancia_curso
    ADD CONSTRAINT docente FOREIGN KEY (docente) REFERENCES public.docente(cedula);


--
-- TOC entry 2963 (class 2606 OID 42839)
-- Name: archivo docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archivo
    ADD CONSTRAINT docente FOREIGN KEY (docente) REFERENCES public.docente(cedula);


--
-- TOC entry 2965 (class 2606 OID 42857)
-- Name: historial_reporte_alumno docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reporte_alumno
    ADD CONSTRAINT docente FOREIGN KEY (docente) REFERENCES public.docente(cedula);


--
-- TOC entry 2967 (class 2606 OID 42875)
-- Name: historial_reporte_curso docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reporte_curso
    ADD CONSTRAINT docente FOREIGN KEY (docente) REFERENCES public.docente(cedula);


--
-- TOC entry 2946 (class 2606 OID 42646)
-- Name: administrador estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrador
    ADD CONSTRAINT estado FOREIGN KEY (estado) REFERENCES public.tipo_estado(id);


--
-- TOC entry 2947 (class 2606 OID 42659)
-- Name: docente estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docente
    ADD CONSTRAINT estado FOREIGN KEY (estado) REFERENCES public.tipo_estado(id);


--
-- TOC entry 2950 (class 2606 OID 42700)
-- Name: alumno estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno
    ADD CONSTRAINT estado FOREIGN KEY (estado) REFERENCES public.tipo_estado(id);


--
-- TOC entry 2972 (class 2606 OID 42938)
-- Name: instancia_evaluacion evaluacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instancia_evaluacion
    ADD CONSTRAINT evaluacion FOREIGN KEY (evaluacion) REFERENCES public.evaluacion(id);


--
-- TOC entry 2955 (class 2606 OID 42763)
-- Name: ayudante_instancia_curso instancia_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayudante_instancia_curso
    ADD CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso) REFERENCES public.instancia_curso(id);


--
-- TOC entry 2957 (class 2606 OID 42781)
-- Name: docente_invitado_instancia_curso instancia_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.docente_invitado_instancia_curso
    ADD CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso) REFERENCES public.instancia_curso(id);


--
-- TOC entry 2959 (class 2606 OID 42811)
-- Name: alumno_instancia_curso instancia_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno_instancia_curso
    ADD CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso) REFERENCES public.instancia_curso(id);


--
-- TOC entry 2962 (class 2606 OID 42834)
-- Name: archivo instancia_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.archivo
    ADD CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso) REFERENCES public.instancia_curso(id);


--
-- TOC entry 2966 (class 2606 OID 42870)
-- Name: historial_reporte_curso instancia_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_reporte_curso
    ADD CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso) REFERENCES public.instancia_curso(id);


--
-- TOC entry 2970 (class 2606 OID 42919)
-- Name: evaluacion instancia_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluacion
    ADD CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso) REFERENCES public.instancia_curso(id);


--
-- TOC entry 2961 (class 2606 OID 42821)
-- Name: alumno_instancia_curso situacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumno_instancia_curso
    ADD CONSTRAINT situacion FOREIGN KEY (situacion) REFERENCES public.situacion_alumno_instancia_curso(id);


--
-- TOC entry 2969 (class 2606 OID 42914)
-- Name: evaluacion tipo_evaluacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluacion
    ADD CONSTRAINT tipo_evaluacion FOREIGN KEY (tipo_evaluacion) REFERENCES public.tipo_evaluacion(id);


--
-- TOC entry 2968 (class 2606 OID 42909)
-- Name: evaluacion unidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluacion
    ADD CONSTRAINT unidad FOREIGN KEY (unidad) REFERENCES public.unidad_aprendizaje(id);


-- Completed on 2020-03-13 23:36:25

--
-- PostgreSQL database dump complete
--

