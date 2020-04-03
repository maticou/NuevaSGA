<br>
<div class="container">
    <h3>Registrar Observacion</h3>
</div>

<br>

<div class="container">
	<form method="post" action="<?=base_url()?>index.php/observacion/registrar_observacion">
	<input type="hidden" id="matricula" placeholder="" name="matricula" value="<?=$matricula?>">

	<div class="form-group">
		<label for="observacion">Observacion</label>
		<textarea class="form-control" id="observacion" name="observacion" rows="3"></textarea>
	</div>
		<button type="submit" class="btn btn-primary">Registrar</button>
	</form>
</div>

<br>

<div class="container">
	<h3>Observaciones</h3>
</div>

<div id="listado" class="container">

	
	<br>
	<table class="table table-striped"  border="0" cellspacing="5" cellpadding="5">
	<th>Profesor</th>
	<th>Observacion</th>

	<?foreach($resultado as $row):?>
		<tr>
			<td><input type="hidden" value="<?=$row->nombre_profesor?>" readonly>
				<p><?=$row->nombre_profesor?></p>
			</td>
			<td><input type="hidden"  value="<?=$row->observacion?>" readonly>
				<p><?=$row->observacion?></p>
			</td>
		</tr>
	<?endforeach;?>
</table>
</div>