<?php  

	class Admin extends MY_Controller{

		public function __construct(){
			parent::__construct();

            $this->load->model("admin/Admin_model");
        }
        
        public function index(){
			$this->load->view("admin_view");
		}
	}

?>