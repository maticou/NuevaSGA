CREATE TABLE tipo_estado(
    id SERIAL PRIMARY KEY, 
    tipo character varying(20) UNIQUE NOT NULL -- Bloqueado|Activo
);

CREATE TABLE administrador(
    cedula character varying(9) NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    email character varying(50) UNIQUE NOT NULL,
    contrasenia character varying(50) NOT NULL,
    estado integer DEFAULT 1 NOT NULL,
    
    CONSTRAINT cedula_admin_pkey PRIMARY KEY (cedula),

    CONSTRAINT estado FOREIGN KEY (estado)
    REFERENCES tipo_estado(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE director(
    cedula character varying(9) NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    email character varying(50) UNIQUE NOT NULL,
    contrasenia character varying(50) NOT NULL,
    estado integer DEFAULT 1 NOT NULL,
    
    CONSTRAINT cedula_director_pkey PRIMARY KEY (cedula),

    CONSTRAINT estado FOREIGN KEY (estado)
    REFERENCES tipo_estado(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE docente(
    cedula character varying(9) NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    email character varying(50) UNIQUE NOT NULL,
    contrasenia character varying(50) NOT NULL,
    estado integer DEFAULT 1 NOT NULL,
    
    CONSTRAINT cedula_profesor_pkey PRIMARY KEY (cedula),

    CONSTRAINT estado FOREIGN KEY (estado)
    REFERENCES tipo_estado(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE dia(
    id SERIAL PRIMARY KEY, 
    dia character varying(20) UNIQUE NOT NULL -- Lunes|Martes|Miercoles|Jueves|Viernes
);

CREATE TABLE horario_atencion(
    id SERIAL PRIMARY KEY, 
    dia integer NOT NULL,
    hora_inicio time NOT NULL,
    hora_termino time NOT NULL,
    docente character varying(9) NOT NULL, 

    CONSTRAINT dia FOREIGN KEY (dia)
    REFERENCES dia(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT docente FOREIGN KEY (docente)
    REFERENCES docente(cedula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE alumno(
    num_matricula integer NOT NULL,
    nombre_completo character varying(100) NOT NULL,
    email character varying(50) UNIQUE NOT NULL ,
    contrasenia character varying(50) NOT NULL,
    estado integer DEFAULT 1 NOT NULL,

    CONSTRAINT num_matricula_pkey PRIMARY KEY (num_matricula),

    CONSTRAINT estado FOREIGN KEY (estado)
    REFERENCES tipo_estado(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE observacion(
    id SERIAL PRIMARY KEY,
    alumno integer NOT NULL,
    docente character varying(9) NOT NULL,  -- Realizada por
    observacion character varying(500) NOT NULL,

    CONSTRAINT alumno FOREIGN KEY (alumno)
    REFERENCES alumno(num_matricula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT docente FOREIGN KEY (docente)
    REFERENCES docente(cedula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE curso(   
    id SERIAL PRIMARY KEY,
    nombre character varying(50) UNIQUE NOT NULL
);

CREATE TABLE tipo_periodo(
    id SERIAL PRIMARY KEY, 
    tipo character varying(20) UNIQUE NOT NULL -- Otoño-Invierno|Primavera-Verano
);

CREATE TABLE instancia_curso(
    id SERIAL PRIMARY KEY,
    periodo integer NOT NULL,
    seccion character varying(1) NOT NULL,
    anio integer NOT NULL,
    curso integer NOT NULL,
    docente character varying(9) NOT NULL,
    porcentaje_restante integer DEFAULT 100 NOT NULL,

    CONSTRAINT curso FOREIGN KEY (curso)
    REFERENCES curso(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT docente FOREIGN KEY (docente)
    REFERENCES docente(cedula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT periodo FOREIGN KEY (periodo)
    REFERENCES tipo_periodo(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE ayudante_instancia_curso(
    id SERIAL PRIMARY KEY,
    instancia_curso integer NOT NULL,
    alumno integer NOT NULL,
   
    CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso)
    REFERENCES instancia_curso(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT alumno FOREIGN KEY (alumno)
    REFERENCES alumno(num_matricula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE docente_invitado_instancia_curso(
    id SERIAL PRIMARY KEY,
    instancia_curso integer NOT NULL,
    docente character varying(9) NOT NULL,
   
    CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso)
    REFERENCES instancia_curso(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT docente FOREIGN KEY (docente)
    REFERENCES docente(cedula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE situacion_alumno_instancia_curso(
    id SERIAL PRIMARY KEY, 
    situacion character varying(20) UNIQUE NOT NULL -- APROBADO|REPROBADO|CURSANDO|
);

CREATE TABLE alumno_instancia_curso(
    id SERIAL PRIMARY KEY,
    instancia_curso integer NOT NULL,
    alumno integer NOT NULL,
    nota_final integer DEFAULT 0 NOT NULL ,
    situacion integer DEFAULT 1 NOT NULL,
   
    CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso)
    REFERENCES instancia_curso(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT alumno FOREIGN KEY (alumno)
    REFERENCES alumno(num_matricula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT situacion FOREIGN KEY (situacion)
    REFERENCES situacion_alumno_instancia_curso(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE archivo(
    id SERIAL PRIMARY KEY,
    nombre character varying(20) NOT NULL,
    instancia_curso integer NOT NULL,
    docente character varying(9) NOT NULL, -- Subida por
    url character varying(100) NOT NULL,

    CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso)
    REFERENCES instancia_curso(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT docente FOREIGN KEY (docente)
    REFERENCES docente(cedula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


CREATE TABLE historial_reporte_alumno(
    id SERIAL PRIMARY KEY,
    fecha date NOT NULL,
    alumno integer NOT NULL,
    docente character varying(9) NOT NULL, -- Solicitado por
    url character varying(100) NOT NULL,

    CONSTRAINT alumno FOREIGN KEY (alumno)
    REFERENCES alumno(num_matricula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT docente FOREIGN KEY (docente)
    REFERENCES docente(cedula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE historial_reporte_curso(
    id SERIAL PRIMARY KEY,
    fecha date NOT NULL,
    instancia_curso integer NOT NULL,
    docente character varying(9) NOT NULL,  -- Solicitado por
    url character varying(100) NOT NULL,

    CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso)
    REFERENCES instancia_curso(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT docente FOREIGN KEY (docente)
    REFERENCES docente(cedula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE tipo_evaluacion(
    id SERIAL PRIMARY KEY, 
    tipo character varying(20) UNIQUE NOT NULL -- PRUEBA|PROYECTO|LABORATORIO|TAREA|TRABAJO|INFORME|ENTREGABLE
);

CREATE TABLE unidad_aprendizaje(
    id SERIAL PRIMARY KEY, 
    nombre character varying(20) UNIQUE NOT NULL -- UNIDAD_1|UNIDAD_2|UNIDAD_3|UNIDAD_4|UNIDAD_5
);

CREATE TABLE evaluacion(
    id SERIAL PRIMARY KEY, 
    fecha date NULL,
    porcentaje integer NOT NULL,
    exigible boolean NOT NULL,
    unidad integer NOT NULL,
    tipo_evaluacion integer NOT NULL,
    prorroga character varying(50) DEFAULT ' ' NULL, 
    instancia_curso integer NOT NULL,

    CONSTRAINT unidad FOREIGN KEY (unidad)
    REFERENCES unidad_aprendizaje(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT tipo_evaluacion FOREIGN KEY (tipo_evaluacion)
    REFERENCES tipo_evaluacion(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT instancia_curso FOREIGN KEY (instancia_curso)
    REFERENCES instancia_curso(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE instancia_evaluacion(
    id SERIAL PRIMARY KEY,
    alumno integer NOT NULL,
    evaluacion integer NOT NULL,
    nota integer NULL DEFAULT 0,

    CONSTRAINT alumno FOREIGN KEY (alumno)
    REFERENCES alumno(num_matricula) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT evaluacion FOREIGN KEY (evaluacion)
    REFERENCES evaluacion(id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE log
(
    id_log bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    operacion varchar(15) NOT NULL,
    stamp timestamp NOT NULL,
    user_id text NOT NULL,
    nombre_tabla varchar(50) NOT NULL,
    datos_nuevos text NULL,
    datos_viejos text NULL,
    PRIMARY KEY (id_log)
);










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
        RETURN  TRUE;
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








CREATE OR REPLACE PROCEDURE calcular_nota_final(id_alumno alumno.num_matricula%TYPE,
id_instancia_curso instancia_curso.id%TYPE)
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
                    SET nota_final=39, situacion=2
                    WHERE alumno_instancia_curso.alumno=id_alumno 
                    AND alumno_instancia_curso.instancia_curso=id_instancia_curso;
                    RAISE NOTICE 'Alumno reprobado porque una evaluación exigible tiene nota menor a 40, se le modifica el promedio a nota 39';
                ELSE
                    UPDATE alumno_instancia_curso
                    SET nota_final=promedio_final, situacion=1
                    WHERE alumno_instancia_curso.alumno=id_alumno 
                    AND alumno_instancia_curso.instancia_curso=id_instancia_curso;
                    RAISE NOTICE 'Alumno aprobado con nota %', promedio_final;
                END IF;
            ELSE
                UPDATE alumno_instancia_curso
                SET nota_final=promedio_final, situacion=2
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


CREATE OR REPLACE FUNCTION verificar_instancia_evaluacion(
    IN _id_instancia integer,
    IN _id_alumno integer
) RETURNS INTEGER AS $$
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
$$ LANGUAGE plpgsql;








    
    
    







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






CREATE OR REPLACE FUNCTION cursor_agregar_evaluacion_por_alumno()
RETURNS TRIGGER AS $$
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
            CALL agregar_instancia_evaluacion(reg.num_matricula, NEW.id, 0);
            FETCH cursor_alumnos INTO reg;
        END LOOP;
    ELSE
            RAISE NOTICE 'No puede crear esta evaluación con porcentaje %, ya que al curso le queda % %% restante', NEW.porcentaje, valor.porcentaje_restante;
    END IF;
    RETURN NEW;
END;$$
LANGUAGE 'plpgsql';

CREATE TRIGGER agregar_evaluacion_por_alumno
AFTER INSERT ON evaluacion
FOR EACH ROW EXECUTE FUNCTION cursor_agregar_evaluacion_por_alumno();


CREATE OR REPLACE FUNCTION cursor_actualizar_evaluacion_por_alumno()
RETURNS TRIGGER AS $$
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
END;$$
LANGUAGE 'plpgsql';


CREATE TRIGGER actualizar_evaluacion_por_alumno
AFTER UPDATE ON evaluacion
FOR EACH ROW EXECUTE FUNCTION cursor_actualizar_evaluacion_por_alumno();






CREATE OR REPLACE FUNCTION cursor_verificar_porcentaje(
    IN _id_instancia integer)
RETURNS integer AS $$
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
END;$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION cursor_verificar_situacion(
    IN _alumno integer,
    IN _instancia_curso integer)
RETURNS integer AS $$
DECLARE
    cursor_promedio CURSOR FOR SELECT nota, exigible
                                FROM instancia_evaluacion, evaluacion
                                WHERE alumno=_alumno
                                AND evaluacion.instancia_curso=_instancia_curso
                                AND instancia_evaluacion.evaluacion=evaluacion.id;
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
END;$$
LANGUAGE 'plpgsql';





CREATE OR REPLACE FUNCTION obtener_cursos_docente(
    _cedula docente.cedula%TYPE
    ) RETURNS TABLE (
        nombre_curso curso.nombre%TYPE,
        id_instancia instancia_curso.id%TYPE,
        seccion instancia_curso.seccion%TYPE,
        anio instancia_curso.anio%TYPE
    ) AS $$
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
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_alumnos_curso(
        _id_instancia instancia_curso.id%TYPE
    ) RETURNS TABLE (
        matricula alumno.num_matricula%TYPE,
        nombre alumno.nombre_completo%TYPE,
        email alumno.email%TYPE,
        nota alumno_instancia_curso.nota_final%TYPE,
        situacion situacion_alumno_instancia_curso.situacion%TYPE
    ) AS $$
BEGIN
    RETURN QUERY
    SELECT alumno.num_matricula AS matricula,
    alumno.nombre_completo AS nombre,
    alumno.email AS email,
    alumno_instancia_curso.nota_final AS nota,
    situacion_alumno_instancia_curso.situacion AS situacion
    FROM alumno, alumno_instancia_curso, situacion_alumno_instancia_curso
    WHERE alumno_instancia_curso.instancia_curso = _id_instancia
    AND alumno_instancia_curso.alumno = alumno.num_matricula
    AND situacion_alumno_instancia_curso.id = alumno_instancia_curso.situacion;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION obtener_alumnos_curso_no_inscritos(
        _id_instancia instancia_curso.id%TYPE
    ) RETURNS TABLE (
        matricula alumno.num_matricula%TYPE,
        nombre alumno.nombre_completo%TYPE
    ) AS $$
BEGIN
    RETURN QUERY
    SELECT alumno.num_matricula AS matricula,
    alumno.nombre_completo AS nombre
    FROM alumno
    EXCEPT
    SELECT alumno.num_matricula AS matricula,
    alumno.nombre_completo AS nombre
    FROM alumno, alumno_instancia_curso, situacion_alumno_instancia_curso
    WHERE alumno_instancia_curso.instancia_curso = _id_instancia
    AND alumno_instancia_curso.alumno = alumno.num_matricula
    AND situacion_alumno_instancia_curso.id = alumno_instancia_curso.situacion;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE cerrar_semestre(
    _id_instancia instancia_curso.id%TYPE
) AS $$
DECLARE
    cursor_alumnos CURSOR FOR SELECT alumno.num_matricula AS matricula
        FROM alumno, alumno_instancia_curso, situacion_alumno_instancia_curso
        WHERE alumno_instancia_curso.instancia_curso = _id_instancia
        AND alumno_instancia_curso.alumno = alumno.num_matricula
        AND situacion_alumno_instancia_curso.id = alumno_instancia_curso.situacion;

    matricula RECORD;
BEGIN
    OPEN cursor_alumnos;
    FETCH cursor_alumnos INTO matricula;

    WHILE (FOUND) LOOP
        CALL calcular_nota_final(matricula.matricula, _id_instancia);
        FETCH cursor_alumnos INTO matricula;
    END LOOP;
END;
$$ LANGUAGE plpgsql;





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





CREATE OR REPLACE FUNCTION obtener_cursos_alumno(
    _matricula alumno.num_matricula%TYPE
) RETURNS TABLE(
    id_instancia instancia_curso.id%TYPE,
    nombre_curso curso.nombre%TYPE,
    seccion instancia_curso.seccion%TYPE,
    periodo tipo_periodo.tipo%TYPE,
    anio instancia_curso.anio%TYPE,
    nota_final alumno_instancia_curso.nota_final%TYPE,
    situacion situacion_alumno_instancia_curso.situacion%TYPE
) AS $$
BEGIN
    RETURN QUERY
    SELECT instancia_curso.id AS id_instancia,
    curso.nombre AS nombre_curso,
    instancia_curso.seccion AS seccion,
    tipo_periodo.tipo AS periodo,
    instancia_curso.anio AS anio,
    alumno_instancia_curso.nota_final AS nota_final,
    situacion_alumno_instancia_curso.situacion AS situacion
    FROM instancia_curso, alumno_instancia_curso,
    situacion_alumno_instancia_curso, curso, tipo_periodo
    WHERE alumno_instancia_curso.alumno = _matricula
    AND alumno_instancia_curso.instancia_curso = instancia_curso.id
    AND instancia_curso.curso = curso.id
    AND alumno_instancia_curso.situacion = situacion_alumno_instancia_curso.id
    AND instancia_curso.periodo = tipo_periodo.id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_observaciones_alumno(
    _matricula alumno.num_matricula%TYPE
) RETURNS TABLE(
    nombre_profesor docente.nombre_completo%TYPE,
    observacion observacion.observacion%TYPE
)AS $$
BEGIN
    RETURN QUERY    
    SELECT docente.nombre_completo, observacion.observacion 
    FROM observacion, docente
    WHERE observacion.alumno=_matricula
    AND docente.cedula = observacion.docente;
END;
$$ LANGUAGE plpgsql;






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







CREATE OR REPLACE FUNCTION promedio_de_notas_por_curso(
    ) RETURNS TABLE (
        nombre curso.nombre%TYPE,
        seccion instancia_curso.seccion%TYPE,
        anio instancia_curso.anio%TYPE,
        periodo tipo_periodo.tipo%TYPE,
        promedio_nota_final DECIMAL(10,0)
    ) AS $$
BEGIN
    RETURN QUERY
    SELECT curso.nombre AS nombre,
    instancia_curso.seccion AS seccion,
    instancia_curso.anio AS anio,
    tipo_periodo.tipo AS periodo,
    CAST(AVG(alumno_instancia_curso.nota_final) AS DECIMAL(10,0)) AS promedio_nota_final
    FROM alumno, curso, instancia_curso, alumno_instancia_curso, tipo_periodo
    WHERE alumno.num_matricula=alumno_instancia_curso.alumno
    AND alumno_instancia_curso.instancia_curso=instancia_curso.id
    AND instancia_curso.curso=curso.id
    AND tipo_periodo.id=instancia_curso.periodo
    GROUP BY instancia_curso.id, curso.nombre, alumno_instancia_curso.nota_final, tipo_periodo.tipo
    ORDER BY nombre ASC, seccion ASC, anio ASC;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION docentes_con_notas_atrasadas(
    ) RETURNS TABLE (
        docente docente.cedula%TYPE,
        nombre docente.nombre_completo%TYPE,
        curso curso.nombre%TYPE
    ) AS $$
BEGIN
    RETURN QUERY
    SELECT docente.cedula AS docente,
    docente.nombre_completo AS nombre,
    curso.nombre AS curso
    FROM evaluacion, instancia_curso, instancia_evaluacion, docente, curso, tipo_evaluacion
    WHERE evaluacion.fecha <now()::date
    AND instancia_evaluacion.evaluacion = evaluacion.id
    AND instancia_curso.id = evaluacion.instancia_curso
    AND instancia_curso.docente = docente.cedula
    AND instancia_evaluacion.nota <10
    GROUP BY docente.nombre_completo, curso.nombre, docente.cedula
    ORDER BY nombre ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION docentes_con_notas_al_dia(
    ) RETURNS TABLE (
        docente docente.cedula%TYPE,
        nombre docente.nombre_completo%TYPE,
        curso curso.nombre%TYPE
    ) AS $$
BEGIN
    RETURN QUERY
    SELECT docente.cedula AS docente,
    docente.nombre_completo AS nombre,
    curso.nombre AS curso
    FROM evaluacion, instancia_curso, instancia_evaluacion, docente, curso, tipo_evaluacion
    WHERE evaluacion.fecha <now()::date
    AND instancia_evaluacion.evaluacion = evaluacion.id
    AND instancia_curso.id = evaluacion.instancia_curso
    AND instancia_curso.docente = docente.cedula
    AND instancia_evaluacion.nota >9
    GROUP BY docente.nombre_completo, curso.nombre, docente.cedula
    ORDER BY nombre ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION cursos_con_situacion_alumnos(
    ) RETURNS TABLE (
        curso curso.nombre%TYPE,
        periodo tipo_periodo.tipo%TYPE,
        anio instancia_curso.anio%TYPE,
        seccion instancia_curso.seccion%TYPE,
        alumno alumno_instancia_curso.alumno%TYPE,
        nombre_alumno alumno.nombre_completo%TYPE,
        situacion situacion_alumno_instancia_curso.situacion%TYPE
    ) AS $$
BEGIN
    RETURN QUERY
    SELECT curso.nombre AS curso,
    tipo_periodo.tipo AS periodo,
    instancia_curso.anio AS anio,
    instancia_curso.seccion AS seccion,
    alumno_instancia_curso.alumno AS alumno,
    alumno.nombre_completo AS nombre_alumno,
    situacion_alumno_instancia_curso.situacion AS situacion
    FROM alumno_instancia_curso, alumno, curso, instancia_curso, situacion_alumno_instancia_curso, tipo_periodo
    WHERE curso.id = instancia_curso.curso
    AND alumno_instancia_curso.instancia_curso = instancia_curso.id
    AND situacion_alumno_instancia_curso.id = alumno_instancia_curso.situacion
    AND tipo_periodo.id = instancia_curso.periodo
    AND alumno_instancia_curso.alumno = alumno.num_matricula
    ORDER BY curso ASC, anio ASC, seccion ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION promedio_de_notas_por_docente(
    ) RETURNS TABLE (
        cedula docente.cedula%TYPE,
        docente docente.nombre_completo%TYPE,
        curso curso.nombre%TYPE,
        seccion instancia_curso.seccion%TYPE,
        anio instancia_curso.anio%TYPE,
        periodo tipo_periodo.tipo%TYPE,
        alumno alumno.num_matricula%TYPE,
        promedio_nota_final DECIMAL(10,0),
        situacion situacion_alumno_instancia_curso.situacion%TYPE
    ) AS $$
BEGIN
    RETURN QUERY
    SELECT docente.cedula AS cedula,
    docente.nombre_completo AS docente,
    curso.nombre AS curso,
    instancia_curso.seccion AS seccion,
    instancia_curso.anio AS anio,
    tipo_periodo.tipo AS periodo,
    alumno.num_matricula AS alumno,
    CAST(AVG(instancia_evaluacion.nota) AS DECIMAL(10,0)) AS promedio_nota_final,
    situacion_alumno_instancia_curso.situacion AS situacion
    FROM alumno, curso, instancia_curso, alumno_instancia_curso, tipo_periodo, docente, situacion_alumno_instancia_curso, instancia_evaluacion, evaluacion
    WHERE alumno.num_matricula=alumno_instancia_curso.alumno
    AND alumno_instancia_curso.instancia_curso=instancia_curso.id
    AND instancia_curso.curso=curso.id
    AND tipo_periodo.id=instancia_curso.periodo
    AND docente.cedula=instancia_curso.docente
    AND situacion_alumno_instancia_curso.id=alumno_instancia_curso.situacion
    AND instancia_evaluacion.alumno=alumno.num_matricula
    AND instancia_evaluacion.evaluacion=evaluacion.id
    AND evaluacion.instancia_curso=instancia_curso.id
    GROUP BY docente.cedula, docente.nombre_completo, instancia_curso.id, alumno.num_matricula, curso.nombre, alumno_instancia_curso.nota_final, tipo_periodo.tipo, situacion_alumno_instancia_curso.situacion
    ORDER BY promedio_nota_final ASC, docente ASC, seccion ASC;
END;
$$ LANGUAGE plpgsql;










CREATE OR REPLACE FUNCTION proceso_agregar_log() 
RETURNS TRIGGER AS $log$
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
$log$ LANGUAGE plpgsql;




CREATE TRIGGER agregar_log_tipo_estado
AFTER INSERT OR UPDATE OR DELETE ON tipo_estado
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_administrador
AFTER INSERT OR UPDATE OR DELETE ON administrador
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_director
AFTER INSERT OR UPDATE OR DELETE ON director
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_docente
AFTER INSERT OR UPDATE OR DELETE ON docente
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_dia
AFTER INSERT OR UPDATE OR DELETE ON dia
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_horario_atencion
AFTER INSERT OR UPDATE OR DELETE ON horario_atencion
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_alumno
AFTER INSERT OR UPDATE OR DELETE ON alumno
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_observacion
AFTER INSERT OR UPDATE OR DELETE ON observacion
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_curso
AFTER INSERT OR UPDATE OR DELETE ON curso
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_instancia_curso
AFTER INSERT OR UPDATE OR DELETE ON instancia_curso
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_ayudante_instancia_curso
AFTER INSERT OR UPDATE OR DELETE ON ayudante_instancia_curso
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_docente_invitado_instancia_curso
AFTER INSERT OR UPDATE OR DELETE ON docente_invitado_instancia_curso
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_situacion_alumno_instancia_curso
AFTER INSERT OR UPDATE OR DELETE ON situacion_alumno_instancia_curso
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_alumno_instancia_curso
AFTER INSERT OR UPDATE OR DELETE ON alumno_instancia_curso
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_archivo
AFTER INSERT OR UPDATE OR DELETE ON archivo
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_historial_reporte_alumno
AFTER INSERT OR UPDATE OR DELETE ON historial_reporte_alumno
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_historial_reporte_curso
AFTER INSERT OR UPDATE OR DELETE ON historial_reporte_curso
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_tipo_evaluacion
AFTER INSERT OR UPDATE OR DELETE ON tipo_evaluacion
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_unidad_aprendizaje
AFTER INSERT OR UPDATE OR DELETE ON unidad_aprendizaje
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_evaluacion
AFTER INSERT OR UPDATE OR DELETE ON evaluacion
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();

CREATE TRIGGER agregar_log_instancia_evaluacion
AFTER INSERT OR UPDATE OR DELETE ON instancia_evaluacion
FOR EACH ROW EXECUTE FUNCTION proceso_agregar_log();







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

    IF ((SELECT cursor_verificar_porcentaje(_id_curso)) = 1) THEN
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