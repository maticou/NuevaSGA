<div id="agregarAlumno" class="container-fluid" align="center">
	<form method="post" action="<?=base_url()?>index.php/admin/agregarNuevoCurso">
	  <div class="row">
	    <div class="col-sm">
		    <div class="col-sm">
		      <button type="submit" class="btn btn-primary" style="margin-top: 20px;">Agregar curso</button>	      
		    </div>
	  </div>	  	  	  	  	 
	</form>
</div>

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
	        <form method="post" action="<?=base_url()?>index.php/admin/editarCurso">
	          <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$row["id"]?>">
	          <button type="submit" class="btn btn-primary">Editar</button>
	        </form>
	      </td>
			</tr>
		<?endforeach;?>
	</table>	
</div>