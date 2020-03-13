<br>
<div id="listado" class="container">

	<table class="table table-striped">
	<th>Nombre Curso</th>
	<th>Sección</th>
    <th>Año</th>
    <th>Acciones</th>
	<?foreach($resultado as $row):?>
		<tr>
			<td><input type="hidden" value="<?=$row->nombre_curso?>" readonly>
				<p><?=$row->nombre_curso?></p>
			</td>
			<td><input type="hidden"  value="<?=$row->seccion?>" readonly>
				<p><?=$row->seccion?></p>
			</td>
			<td>
				<input type="hidden" value="<?=$row->anio?>" readonly>
				<p><?=$row->anio?></p>
      </td>
      <td>
        <form method="post" action="<?=base_url()?>index.php/lista_alumnos/ver_alumnos">
          <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$row->id_instancia?>">
          <button type="submit" class="btn btn-primary">Alumnos</button>
        </form>
      </td>
		</tr>
	<?endforeach;?>
</table>
</div>