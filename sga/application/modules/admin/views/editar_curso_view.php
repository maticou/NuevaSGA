<div id="agregarAlumno" class="container-fluid" align="center">
	<?foreach($resultadoCurso as $row):?>
		<h3 style="margin-top: 10px;">Modifique el nombre del curso</h3>
		<form method="post" action="<?=base_url()?>index.php/admin/actualizarCurso">
		  <div class="row">
		    <div class="col-sm">
		      <div class="form-group">
			    <label for="id_curso">Matrícula</label>
			    <input type="number" class="form-control" id="id_curso" name="id_curso" placeholder="Matrícula del alumno" value="<?=$row->id?>" readonly>
			  </div>
		    </div>
		    <div class="col-sm">
		      <div class="form-group">
			    <label for="nombre">Nombre</label>
			    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre del alumno" value="<?=$row->nombre?>">
			  </div>
		    </div>
		    <div class="col-sm">
		      <button type="submit" class="btn btn-primary" style="margin-top: 30px;">Guardar</button>	      
		    </div>
		  </div>	  	  	  	  	 
		</form>
	<?endforeach;?>	
</div>