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

    public function obtener_ayudantes($curso){
        $query = "SELECT * FROM obtener_datos_alumno_ayudante(?)";
        $result = $this->db->query( $query, array('usuario'=>$curso))->result();

        return $result;
    } 


    public function obtener_docentes_invitado($curso){
        $query = "SELECT * FROM obtener_datos_docente_invitado(?)";
        $result = $this->db->query( $query, array('usuario'=>$curso))->result();

        return $result;
    } 

    public function obtener_alumnos_ayudantes($curso){
        $query = "SELECT * FROM obtener_datos_alumno_ayudante_no_curso(?)";
        $result = $this->db->query( $query, array('usuario'=>$curso))->result();

        return $result;
    }


    public function obtener_docentes_ayudantes($curso){
        $query = "SELECT * FROM obtener_datos_docente_invitado_no_curso(?)";
        $result = $this->db->query( $query, array('usuario'=>$curso))->result();

        return $result;
    }

    public function registrar_ayudante_invitado($curso, $alumno){
        $insert_user_stored_proc = "CALL agregar_ayudante_instancia_curso(?, ?)";
        $data = array('instancia_curso' => $curso, 'alumno' => $alumno);
        $result = $this->db->query($insert_user_stored_proc, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }

    public function registrar_docente_invitador($curso, $docente){
        $insert_user_stored_proc = "CALL agregar_docente_invitado_instancia_curso(?, ?)";
        $data = array('instancia_curso' => $curso, 'docente' => $docente);
        $result = $this->db->query($insert_user_stored_proc, $data);
        if ($result !== NULL) {
            return TRUE;
        }
        return FALSE;
    }
}
?>