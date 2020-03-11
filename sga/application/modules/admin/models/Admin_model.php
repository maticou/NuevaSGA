<?php
class Admin_model extends CI_Model{

	function cargarDatos(){
		$query = $this->db->query('SELECT * FROM docente');
		return $query->result_array();
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