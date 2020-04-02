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

		public function ver_alumnos(){
			$id_instancia = $this->input->post('id_instancia');
			$this->cargar_alumnos_curso($id_instancia);
		}

		public function ingresarAlumnos(){
			$data['cursoID'] = $this->input->post('id_instancia');
			$data['resultadoCursoInstancias'] = $this->Lista_alumnos_model->cargarDatosInstanciasCurso($data['cursoID']);
			$data['situacion'] = $this->Lista_alumnos_model->obtener_situacion();
			$this->load->view("header");
			$this->load->view("inscribir_alumno_view",$data);
		}

		public function guardarNuevoAlumno(){
			$curso = $this->input->post('id_curso');
			$matricula = $this->input->post('alumnosNo');
			$nota = 0;
			$situacion = $this->input->post('situacion');			

			$registro = $this->Lista_alumnos_model->registrar_alumno_curso($curso, $matricula, $nota, $situacion);

			$data['resultado'] = $this->Lista_alumnos_model->cargar_alumnos_curso($curso);
			$data['id_instancia'] = $curso;
			$this->load->view("header");
			$this->load->view('lista_alumnos_view',$data);
		}
	}

?>