<div id="agregarCurso" class="container-fluid" align="center">
	<h3 style="margin-top: 10px;">Complete para ingresar nuevo curso</h3>
	<form method="post" action="<?=base_url()?>index.php/admin/guardarNuevoCurso">
	  <div class="row">
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="nombre_curso">Nombre del curso</label>
		    <input type="text" class="form-control" id="nombre_curso" name="nombre_curso" placeholder="Nombre del curso">
		  </div>
	    </div>
	    <div class="col-sm">
	      <button type="submit" class="btn btn-primary" style="margin-top: 30px;">Registrar</button>	      
	    </div>
	  </div>	  	  	  	  	 
	</form>
</div>