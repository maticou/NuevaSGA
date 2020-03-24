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