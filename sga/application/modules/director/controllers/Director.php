<?php  

	class Director extends MY_Controller{

		public function __construct(){
			parent::__construct();

            $this->load->model("director/Director_model");
        }
        
        public function index(){

        	$this->load->view('header');
			$this->load->view('director_view');
		}

	}

?>