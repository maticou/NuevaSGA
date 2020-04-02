<br>
<div id="listado" class="container-fluid" align="center">

	<table class="table table-striped"  border="0" cellspacing="5" cellpadding="5">
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
						<div class="col-sm">
							<form method="post" action="<?=base_url()?>index.php/evaluacion/cargar_evaluaciones_alumno">
								<input type="hidden" class="form-control" id="matricula" name="matricula" value="<?=$row->matricula?>">
								<input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$id_instancia?>">
								<button type="submit" class="btn btn-primary">Evaluaciones</button>
							</form>
						</div>

						<div class="col-sm">
							<form method="post" action="<?=base_url()?>index.php/historial_alumno/ver_historial">
								<input type="hidden" class="form-control" id="matricula" name="matricula" value="<?=$row->matricula?>">
								<button type="submit" class="btn btn-primary">Historial</button>
							</form>
						</div>
					</div>
				</div>
            </td>
		</tr>
	<?endforeach;?>
</table>
</div>