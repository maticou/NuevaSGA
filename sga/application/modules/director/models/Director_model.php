<?php
class Director_model extends CI_Model{

    function cargarDatosCursos(){
        $query = $this->db->query('SELECT * FROM curso');
        return $query->result_array();
    }

    function cargarDatosInstanciasCurso($curso){
        $query = "SELECT * FROM obtener_instancias_curso(?)";
        $result = $this->db->query( $query, array('id'=>$curso))->result();

        return $result;
    }

    function obtener_docentes(){
        $this->db->select('*');
        $result = $this->db->get('docente')->result();

        return $result;
    }

    function obtener_periodos(){
        $this->db->select('*');
        $result = $this->db->get('tipo_periodo')->result();

        return $result;
    }

    function obtener_situacion(){
        $this->db->select('*');
        $result = $this->db->get('situacion_alumno_instancia_curso')->result();

        return $result;
    }
    

    function registrar_instancia_curso($curso, $periodo, $seccion, $anio, $docente){
        $insert_user_stored_proc = "CALL agregar_instancia_curso(?, ?, ?, ?, ?)";
        $data = array('periodo' => $periodo, 'seccion' => $seccion, 'anio' => $anio, 'curso' => $curso, 'docente' => $docente);
        $result = $this->db->query($insert_user_stored_proc, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }

    function cargar_alumnos_curso($id_instancia){
        $query = "SELECT * FROM obtener_alumnos_curso(?)";
        $result = $this->db->query( $query, array('id_instancia'=>$id_instancia))->result();

        return $result;
    }

    function cargar_alumnos_no_inscritos($id_instancia){
        $query = "SELECT * FROM obtener_alumnos_curso_no_inscritos(?)";
        $result = $this->db->query( $query, array('id_instancia'=>$id_instancia))->result();

        return $result;
    }

    function registrar_alumno_curso($curso, $matricula, $nota, $situacion){
        $insert_user_stored_proc = "CALL agregar_alumno_instancia_curso(?, ?, ?, ?)";
        $data = array('instancia_curso' => $curso, 'alumno' => $matricula, 'nota_final' => $nota, 'situacion' => $situacion);
        $result = $this->db->query($insert_user_stored_proc, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }

    function cargarPromedios(){
        $query = $this->db->query('SELECT * FROM promedio_de_notas_por_curso()');
        return $query->result_array();
    }

    function cargarDocentesAlDia(){
        $query = $this->db->query('SELECT * FROM docentes_con_notas_al_dia()');
        return $query->result_array();
    }

    function cargarDocentesAtrasados(){
        $query = $this->db->query('SELECT * FROM docentes_con_notas_atrasadas()');
        return $query->result_array();
    }

    function cargarCurosSituacionAlumnos(){
        $query = $this->db->query('SELECT * FROM cursos_con_situacion_alumnos()');
        return $query->result_array();
    }

    function cargarNotasDocenteSituacion(){
        $query = $this->db->query('SELECT * FROM promedio_de_notas_por_docente()');
        return $query->result_array();
    }
	
}
?>