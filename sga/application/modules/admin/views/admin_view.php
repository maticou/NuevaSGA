<head>
    <meta charset="UTF-8">
    <title>SGA - Administrador</title>
    <link rel="stylesheet" href="<?php echo base_url(); ?>css/stilo.css">
    <link rel="stylesheet" href="<?php echo base_url(); ?>css/normalize.css">
</head>
<h1>Bienvenido administrador</h1>
<div id="ingreso">
	<h3>Complete para ingresar nuevo docente</h3>
	<form method="post" action="<?=base_url()?>index.php/admin/guardarDatos">
	  <div class="form-group">
	    <label for="cedula_docente">Cédula</label>
	    <input type="text" class="form-control" id="cedula_docente" name="cedula_docente" placeholder="Rut del docente">
	  </div>
	  <div class="form-group">
	    <label for="nombre_docente">Nombre</label>
	    <input type="text" class="form-control" id="nombre_docente" name="nombre_docente" placeholder="Nombre del docente">
	  </div>
	  <div class="form-group">
	    <label for="email_docente">Email</label>
	    <input type="text" class="form-control" id="email_docente" name="email_docente" placeholder="Email del docente">
	  </div>
	  <div class="form-group">
	    <label for="contrasenia_docente">Contraseña</label>
	    <input type="text" class="form-control" id="contrasenia_docente" name="contrasenia_docente" placeholder="Contraseña del docente">
	  </div>
	  <button type="submit" class="btn btn-primary">Registrar</button>
	</form>
</div>
<?php
	echo '<table border="0" cellspacing="5" cellpadding="5"> 
	      <tr> 
	          <th> <font face="Arial">Cedula</font> </th> 
	          <th> <font face="Arial">Nombre</font> </th> 
	          <th> <font face="Arial">Correo</font> </th> 
	          <th> <font face="Arial">Contrasenia</font> </th> 
	          <th> <font face="Arial">Estado</font> </th> 
	      </tr>';
	$i=0;
	while ( $i < count($resultado)) {
		$row = $resultado[$i];
        $field1name = $row["cedula"];
        $field2name = $row["nombre_completo"];
        $field3name = $row["email"];
        $field4name = $row["contrasenia"];
        $field5name = $row["estado"];
 
        echo '<tr> 
                  <td>'.$field1name.'</td> 
                  <td>'.$field2name.'</td> 
                  <td>'.$field3name.'</td> 
                  <td>'.$field4name.'</td> 
                  <td>'.$field5name.'</td> 
              </tr>';
      	$i++;
    }
?>