<br>

<div class="container">
	<form method="post" action="<?=base_url()?>index.php/observacion/obtener_observaciones">
	<input type="hidden" class="form-control" id="matricula" name="matricula" value="<?=$matricula?>">
	<button type="submit" style="margin-left: 10px;" class="btn btn-primary">Ver Observaciones</button>
	</form>
</div>

<br>
<div id="listado" class="container">

	<table class="table table-striped">
	<th>Nombre Curso</th>
	<th>Sección</th>
    <th>Año</th>
    <th>Periodo</th>
    <th>Nota</th>
    <th>Situacion</th>
    <th>Acciones</th>
	<?foreach($resultado as $row):?>
		<tr>
			<td>
                <input type="hidden" value="<?=$row->nombre_curso?>" readonly>
				<p><?=$row->nombre_curso?></p>
			</td>
			<td>
                <input type="hidden"  value="<?=$row->seccion?>" readonly>
				<p><?=$row->seccion?></p>
			</td>
			<td>
				<input type="hidden" value="<?=$row->anio?>" readonly>
                <p><?=$row->anio?></p>
            </td>
            <td>
				<input type="hidden" value="<?=$row->periodo?>" readonly>
                <p><?=$row->periodo?></p>
            </td>
            <td>
				<input type="hidden" value="<?=$row->nota_final?>" readonly>
                <p><?=$row->nota_final?></p>
            </td>
            <td>
				<input type="hidden" value="<?=$row->situacion?>" readonly>
                <p><?=$row->situacion?></p>
            </td>
            <td>
                <div class="container">
                <div class="row">
                    <div>
                    <form method="post" action="<?=base_url()?>index.php/historial_alumno/ver_evaluaciones">
                        <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$row->id_instancia?>">
                        <input type="hidden" class="form-control" id="matricula" name="matricula" value="<?=$matricula?>">
                        <button type="submit" style="margin-left: 10px;" class="btn btn-primary">Evaluaciones</button>
                    </form>
                    </div>
                </div>
                </div>
            </td>
		</tr>
	<?endforeach;?>
</table>
</div>