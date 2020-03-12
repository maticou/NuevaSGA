<div id="agregarDocente" class="container-fluid" align="center">
	<h3>Complete para ingresar nuevo docente</h3>
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
	      <button type="submit" class="btn btn-primary">Registrar</button>	      
	    </div>
	  </div>	  	  	  	  	 
	</form>
</div>

<div class="container-fluid" align="center">
	<?php
		echo '<table  id="tablaDocentes" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		      <tr> 
		          <th> <font face="Arial">Cédula</font> </th> 
		          <th> <font face="Arial">Nombre</font> </th> 
		          <th> <font face="Arial">Correo</font> </th> 
		          <th> <font face="Arial">Contraseña</font> </th> 
		          <th> <font face="Arial">Estado</font> </th> 
		      </tr>';
		$i=0;
		while ( $i < count($resultadoDocentes)) {
			$row = $resultadoDocentes[$i];
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
</div>