<?php
class Director_model extends CI_Model{

    function cargarDatosCursos(){
        $query = $this->db->query('SELECT * FROM curso');
        return $query->result_array();
    }

    function cargarDatosInstanciasCurso($curso){
        $query = "SELECT * FROM obtener_instancias_curso(?)";
        $this->db->limit(1);
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

    function registrar_instancia_curso($curso, $periodo, $seccion, $anio, $docente){
        $insert_user_stored_proc = "CALL agregar_instancia_curso(?, ?, ?, ?, ?)";
        $data = array('periodo' => $periodo, 'seccion' => $seccion, 'anio' => $anio, 'curso' => $curso, 'docente' => $docente);
        $result = $this->db->query($insert_user_stored_proc, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }
	
}
?>