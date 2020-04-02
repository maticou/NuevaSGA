<?php
class Historial_alumno_model extends CI_Model{
    public function obtener_cursos_alumno($matricula){
        $query = "SELECT * FROM obtener_cursos_alumno(?)";
        $result = $this->db->query( $query, array('matricula'=>$matricula))->result();

        return $result;
    }

    public function obtener_evaluaciones_alumno($matricula, $id_instancia){
        $query = "SELECT * FROM obtener_evaluaciones_alumno(?,?)";
        $result = $this->db->query( $query, array('matricula'=>$matricula, 'id_instancia'=>$id_instancia))->result();

        return $result;
    }
}
?>