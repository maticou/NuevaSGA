<div id="agregarAlumno" class="container-fluid" align="center">
	<form method="post" action="<?=base_url()?>index.php/docente/agregarAyudante">
	  <div class="row">
	    <div class="col-sm">
		    <div class="col-sm">
		      <input type="hidden" class="form-control" id="curso" name="curso" value="<?=$curso?>">
		      <button type="submit" class="btn btn-primary" style="margin-top: 20px;">Agregar alumno</button>	      
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
		</tr>
		<?foreach($resultado as $row):?>
			<tr>
				<td><input type="hidden" value="<?=$row->num_matricula?>" readonly>
					<p><?=$row->num_matricula?></p>
				</td>
				<td><input type="hidden"  value="<?=$row->nombre?>" readonly>
					<p><?=$row->nombre?></p>
				</td>
				<td>
					<input type="hidden" value="<?=$row->email?>" readonly>
					<p><?=$row->email?></p>
	      		</td>
				<td>
					<input type="hidden" value="<?=$row->estado?>" readonly>
					<p><?=$row->estado?></p>
	      		</td>
			</tr>
		<?endforeach;?>
	</table>
</div>