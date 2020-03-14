<div id="agregarAlumno" class="container-fluid" align="center">
	<?foreach($resultadoAlumno as $row):?>
		<h3 style="margin-top: 10px;">Modifique los datos del alumno</h3>
		<form method="post" action="<?=base_url()?>index.php/admin/actualizarAlumno">
		  <div class="row">
		    <div class="col-sm">
		      <div class="form-group">
			    <label for="matricula">Matrícula</label>
			    <input type="number" class="form-control" id="matricula" name="matricula" placeholder="Matrícula del alumno" value="<?=$row->num_matricula?>" readonly>
			  </div>
		    </div>
		    <div class="col-sm">
		      <div class="form-group">
			    <label for="nombre_alumno">Nombre</label>
			    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre del alumno" value="<?=$row->nombre?>">
			  </div>
		    </div>
		    <div class="col-sm">
		      <div class="form-group">
			    <label for="email_alumno">Email</label>
			    <input type="text" class="form-control" id="email" name="email" placeholder="Email del alumno" value="<?=$row->email?>">
			  </div>
		    </div>
		    <div class="col-sm">
		      <button type="submit" class="btn btn-primary" style="margin-top: 30px;">Guardar</button>	      
		    </div>
		  </div>	  	  	  	  	 
		</form>
	<?endforeach;?>	
</div>