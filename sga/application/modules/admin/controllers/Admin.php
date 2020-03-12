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
	}

?>