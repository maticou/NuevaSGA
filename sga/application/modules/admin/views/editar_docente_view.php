<div id="agregarAlumno" class="container-fluid" align="center">
	<?foreach($resultadoDocente as $row):?>
		<h3 style="margin-top: 10px;">Modifique los datos del docente</h3>
		<form method="post" action="<?=base_url()?>index.php/admin/actualizarDocente">
		  <div class="row">
		    <div class="col-sm">
		      <div class="form-group">
			    <label for="cedula">Cédula</label>
			    <input type="number" class="form-control" id="cedula" name="cedula" placeholder="Cédula del docente" value="<?=$row->cedula?>" readonly>
			  </div>
		    </div>
		    <div class="col-sm">
		      <div class="form-group">
			    <label for="nombre">Nombre</label>
			    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre del docente" value="<?=$row->nombre?>">
			  </div>
		    </div>
		    <div class="col-sm">
		      <div class="form-group">
			    <label for="email">Email</label>
			    <input type="text" class="form-control" id="email" name="email" placeholder="Email del docente" value="<?=$row->email?>">
			  </div>
		    </div>
		    <div class="col-sm">
		      <button type="submit" class="btn btn-primary" style="margin-top: 30px;">Guardar</button>	      
		    </div>
		  </div>	  	  	  	  	 
		</form>
	<?endforeach;?>	
</div>