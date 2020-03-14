<div id="agregarAlumno" class="container-fluid" align="center">
	<h3 style="margin-top: 10px;">Complete para ingresar nuevo alumno</h3>
	<form method="post" action="<?=base_url()?>index.php/admin/guardarNuevoAlumno">
	  <div class="row">
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="matricula">Matrícula</label>
		    <input type="number" class="form-control" id="matricula" name="matricula" placeholder="Matrícula del alumno">
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="nombre_alumno">Nombre</label>
		    <input type="text" class="form-control" id="nombre_alumno" name="nombre_alumno" placeholder="Nombre del alumno">
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="email_alumno">Email</label>
		    <input type="text" class="form-control" id="email_alumno" name="email_alumno" placeholder="Email del alumno">
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="contrasenia_alumno">Contraseña</label>
		    <input type="text" class="form-control" id="contrasenia_alumno" name="contrasenia_alumno" placeholder="Contraseña del alumno">
		  </div>
	    </div>
	    <div class="col-sm">
	      <button type="submit" class="btn btn-primary" style="margin-top: 30px;">Registrar</button>	      
	    </div>
	  </div>	  	  	  	  	 
	</form>
</div>