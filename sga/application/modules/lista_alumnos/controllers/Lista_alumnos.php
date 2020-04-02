<?php  

	class Lista_alumnos extends MY_Controller{

		public function __construct(){
			parent::__construct();

			$this->load->model("lista_alumnos/Lista_alumnos_model");
		}

		public function index(){
			$this->load->view("header");
			$this->load->view("lista_docente_view");
		}

		public function cargar_alumnos_curso($id_instancia){
			$data['resultado'] = $this->Lista_alumnos_model->cargar_alumnos_curso($id_instancia);
			$data['id_instancia'] = $id_instancia;
			$this->load->view("header");
			$this->load->view('lista_alumnos_view',$data);
		}

		public function cerrar_semestre(){
			$id_instancia = $this->input->post('id_instancia');
			$data = $this->Lista_alumnos_model->cerrar_semestre($id_instancia);
			$this->cargar_alumnos_curso($id_instancia);
		}

		public function ver_alumnos(){
			$id_instancia = $this->input->post('id_instancia');
			$this->cargar_alumnos_curso($id_instancia);
		}
	}

?>