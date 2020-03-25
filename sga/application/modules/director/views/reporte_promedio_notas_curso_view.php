<div class="container-fluid" align="center">
	<table id="tablaPromedio" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		<tr> 
		  <th> <font face="Arial">Nombre</th>
		  <th> <font face="Arial">Sección</th>
	      <th> <font face="Arial">Año</th>
	      <th> <font face="Arial">Periodo</th>
	      <th> <font face="Arial">Promedio final</th>
		</tr>
		<?foreach($resultadoPromedios as $row):?>
			<tr>
				<td><input type="hidden" value="<?=$row['nombre']?>" readonly>
					<p><?=$row['nombre']?></p>
				</td>
				<td><input type="hidden"  value="<?=$row['seccion']?>" readonly>
					<p><?=$row['seccion']?></p>
				</td>
				<td>
					<input type="hidden" value="<?=$row['anio']?>" readonly>
					<p><?=$row['anio']?></p>
	            </td>
	            <td>
					<input type="hidden" value="<?=$row['periodo']?>" readonly>
					<p><?=$row['periodo']?></p>
	            </td>
	            <td>
					<input type="hidden" value="<?=$row['promedio_nota_final']?>" readonly>
					<p><?=$row['promedio_nota_final']?></p>
	            </td>				
			</tr>
		<?endforeach;?>
	</table>	
</div>