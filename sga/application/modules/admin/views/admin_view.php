<div id="agregarAlumno" class="container-fluid" align="center">
	<h3>Complete para ingresar nuevo alumno</h3>
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
	      <button type="submit" class="btn btn-primary">Registrar</button>	      
	    </div>
	  </div>	  	  	  	  	 
	</form>
</div>

<div class="container-fluid" align="center">
	<?php
		echo '<table id="tablaAlumnos" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		      <tr> 
		          <th> <font face="Arial">Matrícula</font> </th> 
		          <th> <font face="Arial">Nombre</font> </th> 
		          <th> <font face="Arial">Correo</font> </th> 
		          <th> <font face="Arial">Contraseña</font> </th> 
		          <th> <font face="Arial">Estado</font> </th> 
		      </tr>';
		$i=0;
		while ( $i < count($resultadoAlumnos)) {
			$row = $resultadoAlumnos[$i];
	        $field1name = $row["num_matricula"];
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