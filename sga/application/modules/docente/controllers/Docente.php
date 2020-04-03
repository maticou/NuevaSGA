<?php  

	class Docente extends MY_Controller{

		public function __construct(){
			parent::__construct();
			$this->load->model("docente/Docente_model");
		}

		public function cargar_cursos_docente(){
			$cedula = $this->session->userdata("cedula");
			$data['cedula'] = $cedula;
			$data['resultado'] = $this->Docente_model->obtener_cursos_docente($cedula);
			$this->load->view("header");
			$this->load->view("docente_view",$data);
		}	

		public function agregarInstanciaCurso(){
			$data['cursos'] = $this->Docente_model->obtener_cursos();
			$data['docente'] = $this->input->post('cedula');
			$data['periodos'] = $this->Docente_model->obtener_periodos();
			$this->load->view('header');
			$this->load->view('inscribir_instancias_curso_view',$data);
		}

		public function guardarNuevaInstancia(){
			$curso = $this->input->post('curso');
			$periodo = $this->input->post('periodo');
			$seccion = $this->input->post('seccion');
			$anio = $this->input->post('anio');
			$docente = $this->input->post('docente');

			$registro = $this->Docente_model->registrar_instancia_curso($curso, $periodo, $seccion, $anio, $docente);

			$cedula = $this->session->userdata("cedula");
			$data['cedula'] = $cedula;
			$data['resultado'] = $this->Docente_model->obtener_cursos_docente($cedula);
			$this->load->view("header");
			$this->load->view("docente_view",$data);
		}


		public function ayudantes(){
			$curso = $this->input->post('id_instancia');
			$cedula = $this->session->userdata("cedula");
			$data['cedula'] = $cedula;
			$data['curso'] = $curso;
			$data['resultado'] = $this->Docente_model->obtener_ayudantes($curso);
			$this->load->view("header");
			$this->load->view("ayudantes_view",$data);
		}

		public function docenteInvitado(){
			$curso = $this->input->post('id_instancia');
			$cedula = $this->session->userdata("cedula");
			$data['cedula'] = $cedula;
			$data['curso'] = $curso;
			$data['resultado'] = $this->Docente_model->obtener_docentes_invitado($curso);
			$this->load->view("header");
			$this->load->view("docente_invitado_view",$data);
		}

		public function agregarAyudante(){
			$curso = $this->input->post('curso');
			$data['curso'] = $curso;
			$data['alumnos'] = $this->Docente_model->obtener_alumnos_ayudantes($curso);
			$this->load->view('header');
			$this->load->view('agregar_ayudante_view',$data);
		}

		public function agregarDocente(){
			$curso = $this->input->post('curso');
			$data['curso'] = $curso;
			$data['docentes'] = $this->Docente_model->obtener_docentes_ayudantes($curso);
			$this->load->view('header');
			$this->load->view('agregar_docente_view',$data);
		}

		public function guardarNuevoAyudante(){
			$curso = $this->input->post('curso');
			$alumno = $this->input->post('alumno');

			$registro = $this->Docente_model->registrar_ayudante_invitado($curso, $alumno);

			$cedula = $this->session->userdata("cedula");
			$data['cedula'] = $cedula;
			$data['curso'] = $curso;
			$data['resultado'] = $this->Docente_model->obtener_ayudantes($curso);
			$this->load->view("header");
			$this->load->view("ayudantes_view",$data);
		}


		public function guardarNuevoDocenteInvitado(){
			$curso = $this->input->post('curso');
			$docente = $this->input->post('docente');

			$registro = $this->Docente_model->registrar_docente_invitador($curso, $docente);
			$cedula = $this->session->userdata("cedula");
			$data['cedula'] = $cedula;
			$data['curso'] = $curso;
			$data['resultado'] = $this->Docente_model->obtener_docentes_invitado($curso);
			$this->load->view("header");
			$this->load->view("docente_invitado_view",$data);
		}
		
	}

?>