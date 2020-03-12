<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="#">Docente</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="#">Cursos <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Cerrar Sesion</span></a>
      </li>
    </ul>
  </div>
</nav>

<br>
<div id="listado" class="container">

	<table class="table table-striped">
	<th>Matricula</th>
	<th>Nombre</th>
    <th>Email</th>
    <th>Nota</th>
    <th>Situacion</th>
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