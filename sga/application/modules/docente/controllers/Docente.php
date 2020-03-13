<?php  

	class Docente extends MY_Controller{

		public function __construct(){
			parent::__construct();

			$this->load->model("docente/Docente_model");
		}

		public function index(){
			$this->load->view("header");
			$this->load->view("docente_view");
		}

		public function cargar_cursos_docente(){
			$cedula = $this->session->userdata("cedula");
			$data['resultado'] = $this->Docente_model->obtener_cursos_docente($cedula);
			$this->load->view("header");
			$this->load->view("docente_view",$data);
		}
	}

?>