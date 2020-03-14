<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<div class="container-fluid">
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand">Bienvenido docente</a>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="<?=base_url()?>index.php/docente/cargar_cursos_docente">Cursos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<?=base_url()?>index.php/login/cerrarSesion">Salir</a>
        </li>
      </ul>
    </div>
  </nav>  
</div>

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