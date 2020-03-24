<div id="agregarInstanciaCurso" class="container-fluid" align="center">
	<h3 style="margin-top: 10px;">Complete para ingresar nueva instancia</h3>
	<form method="post" action="<?=base_url()?>index.php/director/guardarNuevaInstancia">
	  <div class="row">
	  	<div class="col-sm">
	      <div class="form-group">
		    <label for="id_curso">ID curso</label>
		    <input type="text" class="form-control" id="id_curso" name="id_curso" value="<?=$cursoID?>" readonly>
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="periodo">Periodo</label>
		    <select class="form-control" name="periodo" id="periodo">
	          <?foreach($periodos as $tiempo):?>
	            <option value="<?=$tiempo->id?>"><?=$tiempo->tipo?></option>
	          <?endforeach;?>
	        </select>
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="seccion">Sección</label>
		    <input type="text" class="form-control" id="seccion" name="seccion" placeholder="Sección del curso">
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="anio">Año</label>
		    <input type="number" class="form-control" id="anio" name="anio" placeholder="Año del curso">
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="docente">Docente</label>
		    <select class="form-control" name="docente" id="docente">
	          <?foreach($docentes as $profesor):?>
	            <option value="<?=$profesor->cedula?>"><?=$profesor->cedula?>, <?=$profesor->nombre_completo?></option>
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