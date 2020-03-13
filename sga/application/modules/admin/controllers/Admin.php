<?php  

	class Admin extends MY_Controller{

		public function __construct(){
			parent::__construct();

            $this->load->model("admin/Admin_model");
        }
        
        public function index(){

        	$data['resultadoAlumnos'] = $this->Admin_model->cargarDatosAlumnos();
        	$this->load->view('header');
			$this->load->view('admin_view',$data);
		}

		public function indexCursos(){

        	$data['resultadoCursos'] = $this->Admin_model->cargarDatosCursos();
        	$this->load->view('header');
			$this->load->view('admin_view_curso',$data);
		}

		public function indexDocentes(){

        	$data['resultadoDocentes'] = $this->Admin_model->cargarDatosDocentes();
        	$this->load->view('header');
			$this->load->view('admin_view_docente',$data);
		}

		public function guardarNuevoAlumno(){
			$matricula = $this->input->post('matricula');
			$nombre = $this->input->post('nombre_alumno');
			$email = $this->input->post('email_alumno');
			$contrasenia = $this->input->post('contrasenia_alumno');

			$registro = $this->Admin_model->registrar_alumno($matricula, $nombre, $email, $contrasenia);

			$data['resultadoAlumnos'] = $this->Admin_model->cargarDatosAlumnos();
			$this->load->view('header');
			$this->load->view('admin_view',$data);
		}

		public function guardarNuevoCurso(){
			$nombre = $this->input->post('nombre_curso');

			$registro = $this->Admin_model->registrar_curso($nombre);

			$data['resultadoCursos'] = $this->Admin_model->cargarDatosCursos();
			$this->load->view('header');
			$this->load->view('admin_view_curso',$data);
		}

		public function guardarNuevoDocente(){
			$cedula = $this->input->post('cedula_docente');
			$nombre = $this->input->post('nombre_docente');
			$email = $this->input->post('email_docente');
			$contrasenia = $this->input->post('contrasenia_docente');

			$registro = $this->Admin_model->registrar_docente($cedula, $nombre, $email, $contrasenia);

			$data['resultadoDocentes'] = $this->Admin_model->cargarDatosDocentes();
			$this->load->view('header');
			$this->load->view('admin_view_docente',$data);
		}	

		public function editarAlumno(){			
			$matricula = $this->input->post('id_instancia');
			$data['resultadoAlumno'] = $this->Admin_model->buscarAlumno($matricula);
			$this->load->view('header');
			$this->load->view('editar_alumno_view',$data);			
		}

		public function actualizarAlumno(){
			$matricula = $this->input->post('matricula');
			$nombre = $this->input->post('nombre');
			$email = $this->input->post('email');
			$this->Admin_model->actualizarAlumno($matricula,$nombre,$email);
			$this->index();
		}

		public function editarCurso(){
			$id_curso = $this->input->post('id_instancia');
			$data['resultadoCurso'] = $this->Admin_model->buscarCurso($id_curso);
			$this->load->view('header');
			$this->load->view('editar_curso_view',$data);	
		}	

		public function actualizarCurso(){
			$id_curso = $this->input->post('id_curso');
			$nombre = $this->input->post('nombre');			
			$this->Admin_model->actualizarCurso($id_curso,$nombre);
			$this->indexCursos();
		}

		public function editarDocente(){			
			$cedula = $this->input->post('id_instancia');
			$data['resultadoDocente'] = $this->Admin_model->buscarDocente($cedula);
			$this->load->view('header');
			$this->load->view('editar_docente_view',$data);			
		}

		public function actualizarDocente(){
			$cedula = $this->input->post('cedula');
			$nombre = $this->input->post('nombre');
			$email = $this->input->post('email');
			$this->Admin_model->actualizarDocente($cedula,$nombre,$email);
			$this->indexDocentes();
		}

		public function agregarNuevoAlumno(){
			$this->load->view('header');
			$this->load->view('agregar_alumno_view');
		}

		public function agregarNuevoCurso(){
			$this->load->view('header');
			$this->load->view('agregar_curso_view');
		}

		public function agregarNuevoDocente(){
			$this->load->view('header');
			$this->load->view('agregar_docente_view');
		}

	}

?>