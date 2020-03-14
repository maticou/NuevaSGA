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
                <button class="btn btn-primary" onclick="ver_evaluaciones(<?=$row->matricula?>)">Evaluaciones</button>
                <button class="btn btn-primary" onclick="ver_observaciones(<?=$row->matricula?>)">Observaciones</button>
            </td>
		</tr>
	<?endforeach;?>
</table>
</div>