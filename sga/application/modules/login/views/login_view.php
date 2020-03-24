<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<head>
    <meta charset="UTF-8">
    <title>SGA - Iniciar Sesión</title>
    <link rel="stylesheet" href="<?php echo base_url(); ?>css/stilo.css">
    <link rel="stylesheet" href="<?php echo base_url(); ?>css/normalize.css">
</head>
<br>
<div class="container">
	<h4>Iniciar Sesión</h4>

	<br>
	<form method="post" action="<?=base_url()?>index.php/login/ingresar">
	  <div class="form-group">
	    <label for="nombre_usuario">Email</label>
	    <input type="email" class="form-control" id="email_usuario" name="email_usuario" placeholder="Email del usuario">
	  </div>
	  <div class="form-group">
	    <label for="contrasena">Contraseña</label>
	    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña">
	  </div>
	  <button type="submit" class="btn btn-primary">Ingresar</button>
	</form>
</div>