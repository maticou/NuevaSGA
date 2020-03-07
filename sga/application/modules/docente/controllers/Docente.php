<?php  

	class Docente extends MY_Controller{

		public function __construct(){
			parent::__construct();

			$this->load->model("docente/Docente_model");
		}

		public function index(){
			$this->load->view("docente_view");
		}
	}

?>