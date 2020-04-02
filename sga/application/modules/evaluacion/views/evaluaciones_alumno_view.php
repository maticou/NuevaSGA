<div id="listado" class="container">

	<table class="table table-striped">
	<th>Tipo</th>
	<th>Unidad</th>
    <th>Porcentaje</th>
    <th>Exigible</th>
    <th>Fecha</th>
    <th>Nota</th>
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
        <input type="hidden"  value="<?=$row->nota?>" readonly>
				<p><?=$row->nota?></p>
			</td>
      <td>
        <form method="post" action="<?=base_url()?>index.php/evaluacion/subir_nota">
          <div class="container">
            <div class="row">
              <div class="col-sm">
                <input type="hidden" class="form-control" id="id_evaluacion" name="id_evaluacion" value="<?=$row->id_evaluacion?>">
                <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$id_instancia?>">
                <input type="hidden" class="form-control" id="matricula" name="matricula" value="<?=$matricula?>">
                <input type="text" class="form-control" id="nota" name="nota">
              </div>
              <div class="col-sm">
                <button type="submit" class="btn btn-primary">Subir nota</button>
              </div>
            </div>
          </div>
        </form>
      </td>
		</tr>
	<?endforeach;?>
</table>
</div>