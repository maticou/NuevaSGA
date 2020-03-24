<div id="agregarInstanciaCurso" class="container-fluid" align="center">
	<form method="post" action="<?=base_url()?>index.php/director/agregarInstanciaCurso">
	  <div class="row">
	    <div class="col-sm">
		    <div class="col-sm">
		      <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$cursoID?>">
		      <button type="submit" class="btn btn-primary" style="margin-top: 20px;">Agregar instancia</button>	      
		    </div>
	  </div>	  	  	  	  	 
	</form>
</div>

<div class="container-fluid" align="center">
	<table id="tablaInstanciasCurso" class="table table-striped" border="0" cellspacing="5" cellpadding="5"> 
		<tr> 
		  <th> <font face="Arial">Nombre</font> </th> 
		  <th> <font face="Arial">Periodo</font> </th> 
		  <th> <font face="Arial">Sección</font> </th> 
		  <th> <font face="Arial">Año</font> </th> 
		  <th> <font face="Arial">Docente</font> </th> 
		  <th> <font face="Arial">Porcentaje restante</font> </th> 
		</tr>
		<?foreach($resultadoCursoInstancias as $row):?>
			<tr>
				<td><input type="hidden"  value="<?=$row->nombre?>" readonly>
					<p><?=$row->nombre?></p>
				</td>
				<td><input type="hidden"  value="<?=$row->periodo?>" readonly>
					<p><?=$row->periodo?></p>
				</td>
				<td><input type="hidden"  value="<?=$row->seccion?>" readonly>
					<p><?=$row->seccion?></p>
				</td>
				<td><input type="hidden"  value="<?=$row->anio?>" readonly>
					<p><?=$row->anio?></p>
				</td>
				<td><input type="hidden"  value="<?=$row->docente?>" readonly>
					<p><?=$row->docente?></p>
				</td>
				<td><input type="hidden"  value="<?=$row->porcentaje_restante?>" readonly>
					<p><?=$row->porcentaje_restante?></p>
				</td>
			</tr>
		<?endforeach;?>
	</table>	
</div>