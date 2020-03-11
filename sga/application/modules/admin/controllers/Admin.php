<?php  

	class Admin extends MY_Controller{

		public function __construct(){
			parent::__construct();

            $this->load->model("admin/Admin_model");
        }
        
        public function index(){

        	$data['resultado'] = $this->Admin_model->cargarDatos();
			$this->load->view('admin_view',$data);
		}

		public function cargarDatos(){
			$data['resultado'] = $this->modelo->cargarDatos();
			return $this->load->view('admin_view',$data);
		}

		public function guardarDatos(){
			$cedula = $this->input->post('cedula_docente');
			$nombre = $this->input->post('nombre_docente');
			$email = $this->input->post('email_docente');
			$contrasenia = $this->input->post('contrasenia_docente');

			$registro = $this->Admin_model->registrar_docente($cedula, $nombre, $email, $contrasenia);

			$data['resultado'] = $this->Admin_model->cargarDatos();
			$this->load->view('admin_view',$data);
		}
	}

?>