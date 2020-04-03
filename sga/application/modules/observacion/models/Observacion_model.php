<?php
class Observacion_model extends CI_Model{

    public function obtener_observaciones($matricula){
        $query = "SELECT * FROM obtener_observaciones_alumno(?)";
        $result = $this->db->query( $query, array('matricula'=>$matricula))->result();

        return $result;
    }

    public function registrar_observacion($matricula, $observacion){
        $cedula = $this->session->userdata("cedula");
        $query = "CALL agregar_observacion(?,?,?)";
        $data = array('alumno' => $matricula, 'docente'=>$cedula, 'observacion'=>$observacion);
        $result = $this->db->query($query, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }

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