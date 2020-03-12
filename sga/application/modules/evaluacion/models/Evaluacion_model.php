<?php
class Evaluacion_model extends CI_Model{
    public function obtener_evaluaciones_alumno($matricula, $id_instancia){
    	$query = "SELECT * FROM obtener_alumnos_curso(?)";
        $result = $this->db->query( $query, array('id_instancia'=>$id_instancia))->result();

        return $result;
    }
}
?>