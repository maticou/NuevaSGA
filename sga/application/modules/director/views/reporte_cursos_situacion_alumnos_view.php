<div class="container-fluid" align="center">
	<table id="tablaPromedio" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		<tr> 
		  <th> <font face="Arial">Curso</th>
		  <th> <font face="Arial">Periodo</th>
	      <th> <font face="Arial">Año</th>
	      <th> <font face="Arial">Sección</th>
	      <th> <font face="Arial">Alumno</th>
	      <th> <font face="Arial">Nombre del alumno</th>
	      <th> <font face="Arial">Situación</th>
		</tr>
		<?foreach($resultadoCursos as $row):?>
			<tr>
				<td><input type="hidden" value="<?=$row['curso']?>" readonly>
					<p><?=$row['curso']?></p>
				</td>
				<td><input type="hidden"  value="<?=$row['periodo']?>" readonly>
					<p><?=$row['periodo']?></p>
				</td>
				<td>
					<input type="hidden" value="<?=$row['anio']?>" readonly>
					<p><?=$row['anio']?></p>
	            </td>
	            <td>
					<input type="hidden" value="<?=$row['seccion']?>" readonly>
					<p><?=$row['seccion']?></p>
	            </td>
	            <td>
					<input type="hidden" value="<?=$row['alumno']?>" readonly>
					<p><?=$row['alumno']?></p>
	            </td>	
	            <td>
					<input type="hidden" value="<?=$row['nombre_alumno']?>" readonly>
					<p><?=$row['nombre_alumno']?></p>
	            </td>
	            <td>
					<input type="hidden" value="<?=$row['situacion']?>" readonly>
					<p><?=$row['situacion']?></p>
	            </td>			
			</tr>
		<?endforeach;?>
	</table>	
</div>