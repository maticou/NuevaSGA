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
    tipo character varying(20) UNIQUE NOT NULL -- PRUEBA|PROYECTO|LABORATORIO|TAREA|TRABAJOS|INFORME
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


