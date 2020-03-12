<?php
class Admin_model extends CI_Model{

	function cargarDatosAlumnos(){
		$query = $this->db->query('SELECT * FROM alumno');
		return $query->result_array();
    }

    function cargarDatosCursos(){
		$query = $this->db->query('SELECT * FROM curso');
		return $query->result_array();
    }

    function cargarDatosDocentes(){
		$query = $this->db->query('SELECT * FROM docente');
		return $query->result_array();
    }

    function registrar_alumno($matricula, $nombre, $email, $contrasenia){
    	$insert_user_stored_proc = "CALL agregar_alumno(?, ?, ?, ?)";
        $data = array('num_matricula' => $matricula, 'nombre_completo' => $nombre, 'email' => $email, 'contrasenia' => $contrasenia);
        $result = $this->db->query($insert_user_stored_proc, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }

    function registrar_curso($nombre){
    	$insert_user_stored_proc = "CALL agregar_curso(?)";
        $data = array('nombre' => $nombre);
        $result = $this->db->query($insert_user_stored_proc, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }

    function registrar_docente($cedula, $nombre, $email, $contrasenia){
    	$insert_user_stored_proc = "CALL agregar_docente(?, ?, ?, ?)";
        $data = array('cedula' => $cedula, 'nombre_completo' => $nombre, 'email' => $email, 'contrasenia' => $contrasenia);
        $result = $this->db->query($insert_user_stored_proc, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }
}
?>