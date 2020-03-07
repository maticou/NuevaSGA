<br>
<div class="container">
	<h4>Iniciar Sesión</h4>

	<br>
	<form method="post" action="<?=base_url()?>index.php/login/ingresar">
	  <div class="form-group">
	    <label for="nombre_usuario">Cédula</label>
	    <input type="text" class="form-control" id="nombre_usuario" name="nombre_usuario" placeholder="Nombre de usuario">
	  </div>
	  <div class="form-group">
	    <label for="contrasena">Contraseña</label>
	    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña">
	  </div>
	  <button type="submit" class="btn btn-primary">Ingresar</button>
	</form>
</div>