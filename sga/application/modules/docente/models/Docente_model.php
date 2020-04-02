<?php
class Docente_model extends CI_Model{
    public function obtener_cursos_docente($cedula){
    	$query = "SELECT * FROM obtener_cursos_docente(?)";
        $result = $this->db->query( $query, array('usuario'=>$cedula))->result();

        return $result;
    }    

    function obtener_periodos(){
        $this->db->select('*');
        $result = $this->db->get('tipo_periodo')->result();

        return $result;
    }

    function obtener_cursos(){
        $this->db->select('*');
        $result = $this->db->get('curso')->result();

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