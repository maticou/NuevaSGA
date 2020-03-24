<div class="container-fluid" align="center">
	<table id="tablaCursos" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		<tr> 
		  <th> <font face="Arial">Nombre</font> </th> 
		  <th> <font face="Arial">Acción</font> </th> 
		</tr>
		<?foreach($resultadoCursos as $row):?>
			<tr>
				<td><input type="hidden"  value="<?=$row["nombre"]?>" readonly>
					<p><?=$row["nombre"]?></p>
				</td>
	      <td>
	        <form method="post" action="<?=base_url()?>index.php/director/ver_instancias_curso">
	          <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$row["id"]?>">
	          <button type="submit" class="btn btn-primary">Ver secciones</button>
	        </form>
	      </td>
			</tr>
		<?endforeach;?>
	</table>	
</div>