<div id="agregarCurso" class="container-fluid" align="center">
	<h3>Complete para ingresar nuevo curso</h3>
	<form method="post" action="<?=base_url()?>index.php/admin/guardarNuevoCurso">
	  <div class="row">
	    <div class="col-sm">
	      <div class="form-group">
		    <label for="nombre_curso">Nombre del curso</label>
		    <input type="text" class="form-control" id="nombre_curso" name="nombre_curso" placeholder="Nombre del curso">
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
		echo '<table id="tablaCursos" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		      <tr> 
		          <th> <font face="Arial">Id</font> </th> 
		          <th> <font face="Arial">Nombre</font> </th> 
		      </tr>';
		$i=0;
		while ( $i < count($resultadoCursos)) {
			$row = $resultadoCursos[$i];
	        $field1name = $row["id"];
	        $field2name = $row["nombre"];
	 
	        echo '<tr> 
	                  <td>'.$field1name.'</td> 
	                  <td>'.$field2name.'</td> 
	              </tr>';
	      	$i++;
	    }
	?>
</div>