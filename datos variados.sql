
CALL agregar_estado('activo');
CALL agregar_estado('inactivo');

CALL agregar_administrador('19016777-1','matías sebastián parra soto','mparra13@alumnos.utalca.cl','123');

CALL agregar_alumno(2013407015,'manuel nicolás gonzález guerrero','mgonzalez13@alumnos.utalca.cl','123');
CALL agregar_alumno(2013407010,'katherine roxana astudillo ibarra','kastudillo13@alumnos.utalca.cl','123');
CALL agregar_alumno(2013407025,'claudio nicolás montecinos pereira','cmontecinos13@alumnos.utalca.cl','123');
CALL agregar_alumno(2013407033,'marcela camila aguirre castro','maguirre13@alumnos.utalca.cl','123');
CALL agregar_alumno(2013407002,'jorge marcelo ibarra astudillo','jibarra13@alumnos.utalca.cl','123');

CALL agregar_situacion_alumno_instancia_curso('aprobado');
CALL agregar_situacion_alumno_instancia_curso('reprobado');
CALL agregar_situacion_alumno_instancia_curso('cursando');

CALL agregar_docente('11888533-3','José nicolás castro ibarra','jcastro@utalca.cl','123');
CALL agregar_docente('9506990-8','macarena camila ibarra pinto','mibarra@utalca.cl','123');

CALL agregar_curso('física');
CALL agregar_curso('gestión de base de datos');

CALL agregar_director('9834134K','ruth maria beatriz garrido orrego','rgarrido@utalca.cl','123');

CALL agregar_periodo('otoño-invierno');
CALL agregar_periodo('primavera-verano');

CALL agregar_instancia_curso(1,'a',2020,1,'118885333');
CALL agregar_instancia_curso(1,'b',2020,1,'118885333');

CALL agregar_alumno_instancia_curso(1,2013407015,0,3);

CALL agregar_unidad_aprendizaje('unidad 1');
CALL agregar_unidad_aprendizaje('unidad 2');
CALL agregar_unidad_aprendizaje('unidad 3');
CALL agregar_unidad_aprendizaje('unidad 4');
CALL agregar_unidad_aprendizaje('unidad 5');


CALL agregar_dia('lunes');
CALL agregar_dia('martes');
CALL agregar_dia('miércoles');
CALL agregar_dia('jueves');
CALL agregar_dia('viernes');
CALL agregar_dia('sábado');
CALL agregar_dia('domingo');

CALL agregar_tipo_evaluacion('prueba');
CALL agregar_tipo_evaluacion('proyecto');
CALL agregar_tipo_evaluacion('laboratorio');
CALL agregar_tipo_evaluacion('tarea');
CALL agregar_tipo_evaluacion('trabajo');
CALL agregar_tipo_evaluacion('informe');
CALL agregar_tipo_evaluacion('entregable');

CALL agregar_evaluacion('2020-03-25',25,TRUE,1,1,'',2);
CALL agregar_evaluacion('2020-05-15',25,TRUE,2,1,'',2);
CALL agregar_evaluacion('2020-06-15',50,TRUE,3,1,'',2);
CALL agregar_evaluacion('2020-04-02',15,FALSE,1,3,'',4);
CALL agregar_evaluacion('2020-04-01',35,TRUE,1,1,'',4);
CALL agregar_evaluacion('2020-05-22',35,TRUE,1,2,'',4);
CALL agregar_evaluacion('2020-05-16',15,FALSE,1,5,'',4);
CALL agregar_evaluacion('2020-05-11',100,TRUE,1,2,'',5);
CALL agregar_evaluacion('2020-03-22',20,TRUE,1,1,'',6);