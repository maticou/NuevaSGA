<br>
<div id="listado" class="container">

	<table class="table table-striped">
	<th>Matrícula</th>
	<th>Nombre</th>
    <th>Email</th>
    <th>Nota</th>
    <th>Situación</th>
    <th>Acciones</th>
	<?foreach($resultado as $row):?>
		<tr>
			<td><input type="hidden" value="<?=$row->matricula?>" readonly>
				<p><?=$row->matricula?></p>
			</td>
			<td><input type="hidden"  value="<?=$row->nombre?>" readonly>
				<p><?=$row->nombre?></p>
			</td>
			<td>
				<input type="hidden" value="<?=$row->email?>" readonly>
				<p><?=$row->email?></p>
            </td>
            <td>
				<input type="hidden" value="<?=$row->nota?>" readonly>
				<p><?=$row->nota?></p>
            </td>
            <td>
				<input type="hidden" value="<?=$row->situacion?>" readonly>
				<p><?=$row->situacion?></p>
            </td>
            <td>
				<div class="container">
					<div class="row">
						<div>
							<form method="post" action="<?=base_url()?>index.php/evaluacion/cargar_evaluaciones_alumno">
								<input type="hidden" class="form-control" id="matricula" name="matricula" value="<?=$row->matricula?>">
								<input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$id_instancia?>">
								<button type="submit" class="btn btn-primary">Evaluaciones</button>
							</form>
						</div>

						<div>
						<button class="btn btn-primary" onclick="ver_observaciones(<?=$row->matricula?>)">Observaciones</button>
						</div>
					</div>
				</div>
            </td>
		</tr>
	<?endforeach;?>
</table>
</div>