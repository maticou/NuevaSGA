<?php  

	class Director extends MY_Controller{

		public function __construct(){
			parent::__construct();

            $this->load->model("director/Director_model");
        }
        
        public function index(){
        	$data['resultadoCursos'] = $this->Director_model->cargarDatosCursos();
        	$this->load->view('header');
			$this->load->view('director_view',$data);
		}

		public function ver_instancias_curso(){
			$data['cursoID'] = $this->input->post('id_instancia');					
			$data['resultadoCursoInstancias'] = $this->Director_model->cargarDatosInstanciasCurso($data['cursoID']);
        	$this->load->view('header');
			$this->load->view('director_instancias_curso_view',$data);
		}

		public function agregarInstanciaCurso(){
			$data['cursoID'] = $this->input->post('id_instancia');
			$data['docentes'] = $this->Director_model->obtener_docentes();
			$data['periodos'] = $this->Director_model->obtener_periodos();
			$this->load->view('header');
			$this->load->view('agregar_instancias_curso_view',$data);
		}

		public function guardarNuevaInstancia(){
			$curso = $this->input->post('id_curso');
			$periodo = $this->input->post('periodo');
			$seccion = $this->input->post('seccion');
			$anio = $this->input->post('anio');
			$docente = $this->input->post('docente');

			$registro = $this->Director_model->registrar_instancia_curso($curso, $periodo, $seccion, $anio, $docente);

			$data['cursoID'] = $curso;					
			$data['resultadoCursoInstancias'] = $this->Director_model->cargarDatosInstanciasCurso($data['cursoID']);
        	$this->load->view('header');
			$this->load->view('director_instancias_curso_view',$data);
		}

		public function alumnosInscritos(){
			$id_instancia = $this->input->post('id_instancia');
			$data['alumnos'] = $this->Director_model->cargar_alumnos_curso($id_instancia);
			$data['cursoID'] = $id_instancia;
			$this->load->view('header');
			$this->load->view('alumnos_instancias_curso_view',$data);
		}

		public function agregarAlumno(){
			$id_instancia = $this->input->post('id_instancia');
			$data['alumnosNo'] = $this->Director_model->cargar_alumnos_no_inscritos($id_instancia);
			$data['situacion'] = $this->Director_model->obtener_situacion();
			$data['cursoID'] = $id_instancia;
			$this->load->view('header');
			$this->load->view('inscribir_alumno_view',$data);			
		}

		public function guardarNuevoAlumno(){
			$curso = $this->input->post('id_curso');
			$matricula = $this->input->post('alumnosNo');
			$nota = 0;
			$situacion = $this->input->post('situacion');			

			$registro = $this->Director_model->registrar_alumno_curso($curso, $matricula, $nota, $situacion);

			$data['alumnos'] = $this->Director_model->cargar_alumnos_curso($curso);
			$data['cursoID'] = $curso;
			$this->load->view('header');
			$this->load->view('alumnos_instancias_curso_view',$data);
		}

		public function reportePromedioNotasCurso(){		
			$data['resultadoPromedios'] = $this->Director_model->cargarPromedios();			
        	$this->load->view('header');
			$this->load->view('reporte_promedio_notas_curso_view',$data);
		}

		public function reporteDocentesAlDia(){		
			$data['resultadoCursos'] = $this->Director_model->cargarDocentesAlDia();			
        	$this->load->view('header');
			$this->load->view('reporte_docentes_con_notas_al_dia_view',$data);
		}

		public function reporteDocentesAtrasados(){		
			$data['resultadoCursos'] = $this->Director_model->cargarDocentesAtrasados();			
        	$this->load->view('header');
			$this->load->view('reporte_docentes_con_notas_atrasadas_view',$data);
		}

		public function reporteCursosSituacionAlumnos(){		
			$data['resultadoCursos'] = $this->Director_model->cargarCurosSituacionAlumnos();			
        	$this->load->view('header');
			$this->load->view('reporte_cursos_situacion_alumnos_view',$data);
		}

		public function reporteNotasDocenteSituacion(){		
			$data['resultadoNotas'] = $this->Director_model->cargarNotasDocenteSituacion();			
        	$this->load->view('header');
			$this->load->view('reporte_notas_situacion_docente_view',$data);
		}

	}

?>