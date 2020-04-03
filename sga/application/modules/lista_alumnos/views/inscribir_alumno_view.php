<div id="agregarAlumnoInstanciaCurso" class="container-fluid" align="center">
	<h3 style="margin-top: 10px;">Complete para inscribir un nuevo alumno</h3>
	<form method="post" action="<?=base_url()?>index.php/Lista_alumnos/guardarNuevoAlumno">
	  <div class="row">
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="id_curso">ID curso</label>
		    <input type="text" class="form-control" id="id_curso" name="id_curso" value="<?=$cursoID?>" readonly>
		  </div>
		</div>
		<div class="col-sm">
	      <div class="form-group">
		    <label for="alumnosNo">Alumnos no inscritos</label>
		    <select class="form-control" name="alumnosNo" id="alumnosNo">
	          <?foreach($resultadoCursoInstancias as $alno):?>
	            <option value="<?=$alno->num_matricula?>"><?=$alno->num_matricula?>, <?=$alno->nombre?></option>
	          <?endforeach;?>
	        </select>
		  </div>
		</div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="situacion">Situación</label>
		    <select class="form-control" name="situacion" id="situacion">
	          <?foreach($situacion as $sit):?>
	            <option value="<?=$sit->id?>"><?=$sit->situacion?></option>
	          <?endforeach;?>
	        </select>		    
		  </div>
		</div>		    
	    <div class="col-sm">
	      <button type="submit" class="btn btn-primary" style="margin-top: 30px;">Registrar</button>	      
	    </div>
	  </div>	  	  	  	  	 
	</form>
</div>