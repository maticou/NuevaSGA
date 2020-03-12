<?php  

	class Evaluacion extends MY_Controller{

		public function __construct(){
			parent::__construct();

			$this->load->model("evaluacion/Evaluacion_model");
		}

		public function index(){
			$this->load->view("evaluacion_view");
        }
        
        public function cargar_evaluaciones_alumno(){
            $matricula = $this->input->post('matricula');
            $id_instancia = $this->input->post('id_instancia');
			$data['resultado'] = $this->Evaluacion_model->obtener_evaluaciones_alumno($matricula, $id_instancia);
			$this->load->view("evaluaciones_alumno_view",$data);
        }

        public function obtener_evaluaciones_curso(){
            $id_instancia = $this->input.->post('id_instancia');
        }

        public function ver_alumnos(){
			$id_instancia = $this->input->post('id_instancia');
			$this->cargar_alumnos_curso($id_instancia);
		}

        public function registrar_evaluacion(){

        }

        public function_modificar_evaluacion(){

        }

		public function cargar_cursos_docente(){
			$cedula = $this->session->userdata("cedula");
			$data['resultado'] = $this->Docente_model->obtener_cursos_docente($cedula);
			$this->load->view("docente_view",$data);
		}
	}

?>