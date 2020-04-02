<br>
<div id="listado" class="container-fluid" align="center">

	<table class="table table-striped"  border="0" cellspacing="5" cellpadding="5">
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
        <div class="container">
          <div class="row">
            <div>
              <form method="post" action="<?=base_url()?>index.php/lista_alumnos/ver_alumnos">
                <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$row->id_instancia?>">
                <button type="submit" class="btn btn-primary">Alumnos</button>
              </form>
            </div>

            <div>
              <form method="post" action="<?=base_url()?>index.php/evaluacion/obtener_evaluaciones_curso">
                <input type="hidden" class="form-control" id="id_instancia" name="id_instancia" value="<?=$row->id_instancia?>">
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