<?php
class Lista_alumnos_model extends CI_Model{
    public function cargar_alumnos_curso($id_instancia){
    	$query = "SELECT * FROM obtener_alumnos_curso(?)";
        $result = $this->db->query( $query, array('id_instancia'=>$id_instancia))->result();

        return $result;
    }

    public function cerrar_semestre($id_instancia){
        $query = "CALL cerrar_semestre(?)";
        $data = array('id_instancia' => $id_instancia);
        $result = $this->db->query($query, $data);
    }
}
?>