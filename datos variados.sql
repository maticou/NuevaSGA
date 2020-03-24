call agregar_estado('activo');
call agregar_estado('inactivo');

call agregar_administrador('19016777-1','matías sebastián parra soto','mparra13@alumnos.utalca.cl','123');

call agregar_alumno(2013407015,'manuel nicolás gonzález guerrero','mgonzalez13@alumnos.utalca.cl','123');
call agregar_alumno(2013407010,'katherine roxana astudillo ibarra','kastudillo13@alumnos.utalca.cl','123');
call agregar_alumno(2013407025,'claudio nicolás montecinos pereira','cmontecinos13@alumnos.utalca.cl','123');
call agregar_alumno(2013407033,'marcela camila aguirre castro','maguirre13@alumnos.utalca.cl','123');
call agregar_alumno(2013407002,'jorge marcelo ibarra astudillo','jibarra13@alumnos.utalca.cl','123');

call agregar_situacion_alumno_instancia_curso('aprobado');
call agregar_situacion_alumno_instancia_curso('reprobado');
call agregar_situacion_alumno_instancia_curso('cursando');

call agregar_docente('11888533-3','José nicolás castro ibarra','jcastro@utalca.cl','123');
call agregar_docente('9506990-8','macarena camila ibarra pinto','mibarra@utalca.cl','123');

call agregar_curso('física');
call agregar_curso('gestión de base de datos');

call agregar_director('9834134K','ruth garrido','rgarrido@utalca.cl','123');

call agregar_periodo('otroño-invierno');
call agregar_periodo('primavera-verano');

call agregar_instancia_curso(1,'a',2020,1,'118885333');
call agregar_instancia_curso(1,'b',2020,1,'118885333');

call agregar_alumno_instancia_curso(1,2013407015,0,3);