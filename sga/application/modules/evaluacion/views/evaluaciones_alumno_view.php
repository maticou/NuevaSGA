<div id="listado" class="container">

	<table class="table table-striped">
	<th>Tipo</th>
	<th>Unidad</th>
    <th>Porcentaje</th>
    <th>Exigible</th>
    <th>Fecha</th>
    <th>Prorroga</th>
    <th>Acciones</th>
	<?foreach($resultado as $row):?>
		<tr>
			<td>
                <input type="hidden" value="<?=$row->tipo_evaluacion?>" readonly>
				<p><?=$row->tipo_evaluacion?></p>
			</td>
			<td>
                <input type="hidden"  value="<?=$row->unidad_evaluacion?>" readonly>
				<p><?=$row->unidad_evaluacion?></p>
			</td>
            <td>
                <input type="hidden"  value="<?=$row->porcentaje?>" readonly>
				<p><?=$row->porcentaje?></p>
			</td>
            <td>
                <input type="hidden"  value="<?=$row->exigible?>" readonly>
				<p><?=$row->exigible?></p>
			</td>
            <td>
                <input type="hidden"  value="<?=$row->fecha?>" readonly>
				<p><?=$row->fecha?></p>
			</td>
			<td>
				<input type="hidden" value="<?=$row->prorroga?>" readonly>
				<p><?=$row->prorroga?></p>
            </td>
      <td>
        <form method="post" action="<?=base_url()?>index.php/evaluacion/editar_evaluacion">
          <input type="hidden" class="form-control" id="id_evaluacion" name="id_evaluacion" value="<?=$row->id_evaluacion?>">
          <button type="submit" class="btn btn-primary">Editar</button>
        </form>
        
      </td>
		</tr>
	<?endforeach;?>
</table>
</div>