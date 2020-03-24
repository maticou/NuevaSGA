<?php
class Login_model extends CI_Model{

	function validar_usuario($usuario, $clave){
        $query = 'SELECT * FROM iniciar_sesion_docente(?,?)';
        $retorno = $this->db->query( $query, array('usuario'=>$usuario,'contrasenia'=>md5($clave)))->num_rows();
		if($retorno > 0){
			return true;
		}
		return false;
    }
    
    function obtener_tipo_usuario($email){
        $query = "SELECT * FROM obtener_datos_usuario(?)";
        $this->db->limit(1);
        $result = $this->db->query( $query, array('usuario'=>$email))->result();
        
        foreach ($result as $fila) {
			return $fila->tipo;
		}
    }

    function obtener_nombre_usuario($email){
        $query = "SELECT * FROM obtener_datos_usuario(?)";
        $this->db->limit(1);
        $result = $this->db->query( $query, array('usuario'=>$email))->result();
        
        foreach ($result as $fila) {
			return $fila->nombre;
		}
    }

    function obtener_cedula_usuario($email){
        $query = "SELECT * FROM obtener_datos_usuario(?)";
        $this->db->limit(1);
        $result = $this->db->query( $query, array('usuario'=>$email))->result();
        
        foreach ($result as $fila) {
            return $fila->cedula;
        }
    }
}
?>