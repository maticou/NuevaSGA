<?php  

	class Observacion extends MY_Controller{

        protected $matricula;
        protected $nombre_alumno;

		public function __construct(){
			parent::__construct();

			$this->load->model("observacion/Observacion_model");
		}

		public function index(){
			$this->load->view("header");
			$this->load->view("lista_docente_view");
        }
        
        public function obtener_observaciones(){
            $matricula = $this->input->post('matricula');
            //$this->matricula = $matricula;
            $data['resultado'] = $this->Observacion_model->obtener_observaciones($matricula);
            $data['matricula'] = $matricula;

            $this->load->view("header");
            $this->load->view('observacion_view',$data);
        }

        public function registrar_observacion(){
            $matricula = $this->input->post('matricula');
            $observacion = $this->input->post('observacion');
            $this->Observacion_model->registrar_observacion($matricula, $observacion);

            $data['resultado'] = $this->Observacion_model->obtener_observaciones($matricula);
            $data['matricula'] = $matricula;
            $this->load->view("header");
            $this->load->view('observacion_view',$data);
        }

	}
?>