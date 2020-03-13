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
	<table id="tablaDocentes" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		<tr> 
		  <th> <font face="Arial">Cédula</font> </th> 
		  <th> <font face="Arial">Nombre</font> </th> 
		  <th> <font face="Arial">Correo</font> </th> 		  
		  <th> <font face="Arial">Estado</font> </th> 
		  <th> <font face="Arial">Acción</font> </th> 
		</tr>
		<?foreach($resultadoDocentes as $row):?>
			<tr>
				<td><input type="hidden" value="<?=$row["cedula"]?>" readonly>
					<p><?=$row["cedula"]?></p>
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
	        <form method="post" action="<?=base_url()?>index.php/admin/editarDocente">
	          <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$row["cedula"]?>">
	          <button type="submit" class="btn btn-primary">Editar</button>
	        </form>
	      </td>
			</tr>
		<?endforeach;?>
	</table>
</div>