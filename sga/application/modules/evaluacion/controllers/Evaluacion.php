<?php  

	class Evaluacion extends MY_Controller{

		public function __construct(){
			parent::__construct();

			$this->load->model("evaluacion/Evaluacion_model");
		}

		public function index(){
			$this->load->view("header");
			$this->load->view("evaluacion_view");
        }
        
        public function cargar_evaluaciones_alumno(){
            $matricula = $this->input->post('matricula');
            $id_instancia = $this->input->post('id_instancia');
			$data['resultado'] = $this->Evaluacion_model->obtener_evaluaciones_alumno($matricula, $id_instancia);
			$this->load->view("header");
			$this->load->view("evaluaciones_alumno_view",$data);
        }

        public function obtener_evaluaciones_curso(){
			$id_instancia = $this->input->post('id_instancia');
			$data['id_instancia'] = $id_instancia;
			$data['resultado'] = $this->Evaluacion_model->obtener_evaluaciones_curso($id_instancia);
			$this->load->view("header");
			$this->load->view("evaluacion_view", $data);
		}
		
        public function vista_registrar_evaluacion(){
			$id_instancia = $this->input->post('id_instancia');
			$data['id_instancia'] = $id_instancia;

			$data['unidades'] = $this->Evaluacion_model->obtener_unidades();
			$data['tipos_evaluacion'] = $this->Evaluacion_model->obtener_tipos_evaluacion();
			$this->load->view("header");
			$this->load->view("registrar_evaluacion_view", $data);
		}
		
		public function almacenar_datos_evaluacion(){
			$id_instancia = $this->input->post('id_instancia');
			$fecha = $this->input->post('fecha');
			$porcentaje = $this->input->post('porcentaje');
			$unidad = $this->input->post('unidad');
			$tipo = $this->input->post('tipo');
			$prorroga = $this->input->post('prorroga');
			$exigible = $this->input->post('exigible');

			if($exigible == 'true'){
				$exigible = TRUE;
			}
			else{
				$exigible = FALSE;
			}
			
			$this->Evaluacion_model->registrar_evaluacion($id_instancia,$fecha,$porcentaje,$unidad,$tipo,$prorroga,$exigible);

			$data['id_instancia'] = $id_instancia;
			$data['resultado'] = $this->Evaluacion_model->obtener_evaluaciones_curso($id_instancia);
			$this->load->view("header");
			$this->load->view("evaluacion_view", $data);
		}

        public function editar_evaluacion(){
			$id_evaluacion = $this->input->post('id_evaluacion');
        }
	}

?>