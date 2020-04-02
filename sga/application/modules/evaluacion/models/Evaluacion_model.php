<?php
class Evaluacion_model extends CI_Model{
    public function obtener_evaluaciones_curso($id_instancia){
        $query = "SELECT * FROM obtener_evaluaciones_curso(?)";
        $result = $this->db->query( $query, array('id_instancia'=>$id_instancia))->result();

        return $result;
    }

    public function registrar_evaluacion($id_instancia,$fecha,$porcentaje,$unidad,$tipo,$prorroga,$exigible){

        $query = "CALL agregar_evaluacion(?,?,?,?,?,?,?)";
        $result = $this->db->query( $query, array(
            'fecha'=>$fecha,
            'porcentaje'=>intval($porcentaje),
            'exigible'=>$exigible,
            'unidad'=>intval($unidad),
            'tipo_evaluacion'=>intval($tipo),
            'prorroga'=>$prorroga,
            'id_instancia'=>intval($id_instancia)
            ))->result();

        return $result;
    }

    public function obtener_unidades(){
        $this->db->select('*');
        $result = $this->db->get('unidad_aprendizaje')->result();

        return $result;
    }

    public function obtener_tipos_evaluacion(){
        $this->db->select('*');
        $result = $this->db->get('tipo_evaluacion')->result();
        
        return $result;
    }

    public function obtener_evaluaciones_alumno($matricula, $id_instancia){
        $query = "SELECT * FROM obtener_evaluaciones_alumno(?,?)";
        $result = $this->db->query( $query, array('matricula'=>$matricula, 'id_instancia'=>$id_instancia))->result();

        return $result;
    }

    public function subir_nota($id_evaluacion, $nota){
        $query = "CALL modificar_nota(?,?)";
        $result = $this->db->query( $query, array(
            'nota'=>intval($nota),
            'id_evaluacion'=>intval($id_evaluacion)
            ))->result();
    }
}
?>