<div id="agregarAlumno" class="container-fluid" align="center">
	<h3 style="margin-top: 10px;">Complete para ingresar ayudante</h3>
	<form method="post" action="<?=base_url()?>index.php/docente/guardarNuevoAyudante">
	  <div class="row">
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="matricula">Id curso</label>
		    <input type="number" class="form-control" id="curso" name="curso" value="<?=$curso?>" readonly>
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="alumno">Alumnos</label>
		    <select class="form-control" name="alumno" id="alumno">
	          <?foreach($alumnos as $al):?>
	            <option value="<?=$al->num_matricula?>"><?=$al->num_matricula?>, <?=$al->nombre?></option>
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