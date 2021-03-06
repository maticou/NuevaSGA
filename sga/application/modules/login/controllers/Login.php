<?php  

	class Login extends MY_Controller{

		public function __construct(){
			parent::__construct();

            $this->load->model("login/Login_model");
            $this->load->module("admin");
            $this->load->module("director");
            $this->load->module("docente");
		}

		public function index(){
			$this->load->view("login_view");
		}

		public function ingresar(){
			$usuario = $this->input->post('email_usuario');
			$clave = $this->input->post('contrasena');

            
            $login = $this->Login_model->validar_usuario($usuario, $clave);

            if($login){
                $data['nombre'] = $this->Login_model->obtener_nombre_usuario($usuario);
                $data['tipo_usuario'] = $this->Login_model->obtener_tipo_usuario($usuario);                
                $data['cedula'] = $this->Login_model->obtener_cedula_usuario($usuario);
                $data['email'] = $usuario;

                $this->session->set_userdata($data);

                if($this->session->userdata("tipo_usuario")=="Admin"){
                    $this->admin->index();
                }
                else if($this->session->userdata("tipo_usuario")=="Docente"){
                    $this->docente->cargar_cursos_docente();
                }
                else if($this->session->userdata("tipo_usuario")=="Director"){
                    $this->director->index();
                }
            }
            else{
                $this->index();
            }
        }

        public function cerrarSesion(){
            session_destroy();
            $this->index();
        }
	}

?>