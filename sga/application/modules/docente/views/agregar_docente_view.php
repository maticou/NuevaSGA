<div id="agregarAlumno" class="container-fluid" align="center">
	<h3 style="margin-top: 10px;">Complete para ingresar docente</h3>
	<form method="post" action="<?=base_url()?>index.php/docente/guardarNuevoDocenteInvitado">
	  <div class="row">
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="matricula">Id curso</label>
		    <input type="number" class="form-control" id="curso" name="curso" value="<?=$curso?>" readonly>
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="docente">Docentes</label>
		    <select class="form-control" name="docente" id="docente">
	          <?foreach($docentes as $doc):?>
	            <option value="<?=$doc->cedula?>"><?=$doc->cedula?>, <?=$doc->nombre?></option>
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