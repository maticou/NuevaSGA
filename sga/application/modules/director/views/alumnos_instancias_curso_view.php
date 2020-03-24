<div id="agregarAlumno" class="container-fluid" align="center">
	<form method="post" action="<?=base_url()?>index.php/director/agregarAlumno">
	  <div class="row">
	    <div class="col-sm">
		    <div class="col-sm">
		      <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$cursoID?>">
		      <button type="submit" class="btn btn-primary" style="margin-top: 20px;">Inscribir alumno</button>	      
		    </div>
	  </div>	  	  	  	  	 
	</form>
</div>

<div class="container-fluid" align="center">
	<table id="tablaInstanciasCurso" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		<tr> 
		  <th> <font face="Arial">Matrícula</th>
		  <th> <font face="Arial">Nombre</th>
	      <th> <font face="Arial">Email</th>
	      <th> <font face="Arial">Nota</th>
	      <th> <font face="Arial">Situación</th>
		</tr>
		<?foreach($alumnos as $row):?>
			<tr>
				<td><input type="hidden" value="<?=$row->matricula?>" readonly>
					<p><?=$row->matricula?></p>
				</td>
				<td><input type="hidden"  value="<?=$row->nombre?>" readonly>
					<p><?=$row->nombre?></p>
				</td>
				<td>
					<input type="hidden" value="<?=$row->email?>" readonly>
					<p><?=$row->email?></p>
	            </td>
	            <td>
					<input type="hidden" value="<?=$row->nota?>" readonly>
					<p><?=$row->nota?></p>
	            </td>
	            <td>
					<input type="hidden" value="<?=$row->situacion?>" readonly>
					<p><?=$row->situacion?></p>
	            </td>				
			</tr>
		<?endforeach;?>
	</table>	
</div>