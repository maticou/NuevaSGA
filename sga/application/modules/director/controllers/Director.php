<?php  

	class Director extends MY_Controller{

		public function __construct(){
			parent::__construct();

            $this->load->model("director/Director_model");
        }
        
        public function index(){
        	$data['resultadoCursos'] = $this->Director_model->cargarDatosCursos();
        	$this->load->view('header');
			$this->load->view('director_view',$data);
		}

		public function ver_instancias_curso(){
			$data['cursoID'] = $this->input->post('id_instancia');					
			$data['resultadoCursoInstancias'] = $this->Director_model->cargarDatosInstanciasCurso($data['cursoID']);
        	$this->load->view('header');
			$this->load->view('director_instancias_curso_view',$data);
		}

		public function agregarInstanciaCurso(){
			$data['cursoID'] = $this->input->post('id_instancia');
			$data['docentes'] = $this->Director_model->obtener_docentes();
			$data['periodos'] = $this->Director_model->obtener_periodos();
			$this->load->view('header');
			$this->load->view('agregar_instancias_curso_view',$data);
		}

		public function guardarNuevaInstancia(){
			$curso = $this->input->post('id_curso');
			$periodo = $this->input->post('periodo');
			$seccion = $this->input->post('seccion');
			$anio = $this->input->post('anio');
			$docente = $this->input->post('docente');

			$registro = $this->Director_model->registrar_instancia_curso($curso, $periodo, $seccion, $anio, $docente);

			$data['cursoID'] = $curso;					
			$data['resultadoCursoInstancias'] = $this->Director_model->cargarDatosInstanciasCurso($data['cursoID']);
        	$this->load->view('header');
			$this->load->view('director_instancias_curso_view',$data);
		}

	}

?>