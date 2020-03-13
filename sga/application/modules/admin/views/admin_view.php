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
	<table id="tablaAlumnos" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		<tr> 
		  <th> <font face="Arial">Matrícula</font> </th> 
		  <th> <font face="Arial">Nombre</font> </th> 
		  <th> <font face="Arial">Correo</font> </th>  
		  <th> <font face="Arial">Estado</font> </th> 
		  <th> <font face="Arial">Acción</font> </th> 
		</tr>
		<?foreach($resultadoAlumnos as $row):?>
			<tr>
				<td><input type="hidden" value="<?=$row["num_matricula"]?>" readonly>
					<p><?=$row["num_matricula"]?></p>
				</td>
				<td><input type="hidden"  value="<?=$row["nombre_completo"]?>" readonly>
					<p><?=$row["nombre_completo"]?></p>
				</td>
				<td>
					<input type="hidden" value="<?=$row["email"]?>" readonly>
					<p><?=$row["email"]?></p>
	      		</td>
				<td>
					<input type="hidden" value="<?=$row["estado"]?>" readonly>
					<p><?=$row["estado"]?></p>
	      		</td>
	      <td>
	        <form method="post" action="<?=base_url()?>index.php/admin/editarAlumno">
	          <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$row["num_matricula"]?>">
	          <button type="submit" class="btn btn-primary">Editar</button>
	        </form>
	      </td>
			</tr>
		<?endforeach;?>
	</table>
</div>