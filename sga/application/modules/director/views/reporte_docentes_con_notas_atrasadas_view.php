<div class="container-fluid" align="center">
	<table id="tablaCursos" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		<tr> 
		  <th> <font face="Arial">Cédula</th>
		  <th> <font face="Arial">Nombre</th>
	      <th> <font face="Arial">Curso</th>
		</tr>
		<?foreach($resultadoCursos as $row):?>
			<tr>
				<td><input type="hidden" value="<?=$row['docente']?>" readonly>
					<p><?=$row['docente']?></p>
				</td>
				<td><input type="hidden" value="<?=$row['nombre']?>" readonly>
					<p><?=$row['nombre']?></p>
				</td>
				<td>
					<input type="hidden" value="<?=$row['curso']?>" readonly>
					<p><?=$row['curso']?></p>
	            </td>	            
			</tr>
		<?endforeach;?>
	</table>	
</div>