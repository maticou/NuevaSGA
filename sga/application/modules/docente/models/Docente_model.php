<?php
class Docente_model extends CI_Model{
    public function obtener_cursos_docente($cedula){
    	$query = "SELECT * FROM obtener_cursos_docente(?)";
        $result = $this->db->query( $query, array('usuario'=>$cedula))->result();

        return $result;
    }
}
?>