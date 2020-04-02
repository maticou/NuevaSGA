<?php
class Lista_alumnos_model extends CI_Model{
    public function cargar_alumnos_curso($id_instancia){
    	$query = "SELECT * FROM obtener_alumnos_curso(?)";
        $result = $this->db->query( $query, array('id_instancia'=>$id_instancia))->result();

        return $result;
    }

    function cargarDatosInstanciasCurso($curso){
        $query = "SELECT * FROM obtener_datos_alumno_no_inscritos_en_instancia_curso(?)";
        $result = $this->db->query( $query, array('id'=>$curso))->result();

        return $result;
    }

    function obtener_situacion(){
        $this->db->select('*');
        $result = $this->db->get('situacion_alumno_instancia_curso')->result();

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
    
    public function cerrar_semestre($id_instancia){
        $query = "CALL cerrar_semestre(?)";
        $data = array('id_instancia' => $id_instancia);
        $result = $this->db->query($query, $data);

    }
}
?>