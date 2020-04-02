<?php  

	class Historial_alumno extends MY_Controller{

		public function __construct(){
			parent::__construct();

            $this->load->model("historial_alumno/Historial_alumno_model");
        }

        public function ver_historial(){
            $matricula = $this->input->post('matricula');
            $data['resultado'] = $this->Historial_alumno_model->obtener_cursos_alumno($matricula);
            $data['matricula'] = $matricula;
            $this->load->view("header");
            $this->load->view("historial_alumno_view",$data);
        }

        public function ver_evaluaciones(){
            $matricula = $this->input->post('matricula');
            $id_instancia = $this->input->post('id_instancia');
			$data['resultado'] = $this->Historial_alumno_model->obtener_evaluaciones_alumno($matricula, $id_instancia);
			$data['matricula'] = $matricula;
            $data['id_instancia'] = $id_instancia;
            $this->load->view("header");
			$this->load->view("lista_evaluaciones_view",$data);
        }
	}

?>