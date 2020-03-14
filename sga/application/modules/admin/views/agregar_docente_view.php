<div id="agregarDocente" class="container-fluid" align="center">
	<h3 style="margin-top: 10px;">Complete para ingresar nuevo docente</h3>
	<form method="post" action="<?=base_url()?>index.php/admin/guardarNuevoDocente">
	  <div class="row">
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="cedula_docente">Cédula</label>
		    <input type="text" class="form-control" id="cedula_docente" name="cedula_docente" placeholder="Rut del docente">
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="nombre_docente">Nombre</label>
		    <input type="text" class="form-control" id="nombre_docente" name="nombre_docente" placeholder="Nombre del docente">
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="email_docente">Email</label>
		    <input type="text" class="form-control" id="email_docente" name="email_docente" placeholder="Email del docente">
		  </div>
	    </div>
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="contrasenia_docente">Contraseña</label>
		    <input type="text" class="form-control" id="contrasenia_docente" name="contrasenia_docente" placeholder="Contraseña del docente">
		  </div>
	    </div>
	    <div class="col-sm">
	      <button type="submit" class="btn btn-primary" style="margin-top: 30px;">Registrar</button>	      
	    </div>
	  </div>	  	  	  	  	 
	</form>
</div>