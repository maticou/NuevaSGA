<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<div class="container-fluid">
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand">Bienvenido docente</a>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="<?=base_url()?>index.php/admin/indexCursos">Cursos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<?=base_url()?>index.php/login/cerrarSesion">Salir</a>
        </li>
      </ul>
    </div>
  </nav>  
</div>

<br>

<div class="container">

  <div>
    <h3>Registrar nueva evaluación</h3>
  </div>

  <br>

  <div>
    <form method="post" action="<?=base_url()?>index.php/evaluacion/almacenar_datos_evaluacion">
      <input type="hidden" id="id_instancia" placeholder="" name="id_instancia" value="<?=$id_instancia?>">
      <div class="form-group">
        <label for="fecha">Fecha</label>
        <input class="form-control" id="fecha" name="fecha" placeholder="ej: MM/DD/AAAA o AAAA/MM/DD">
      </div>
      <div class="form-group">
        <label for="porcentaje">Porcentaje</label>
        <input class="form-control" name="porcentaje" id="porcentaje">
      </div>
      <div class="form-group">
        <label for="unidad">Unidad</label>
        <select class="form-control" name="unidad" id="unidad">
          <?foreach($unidades as $unidad):?>
            <option value="<?=$unidad->id?>"><?=$unidad->nombre?></option>
          <?endforeach;?>
        </select>
      </div>
      <div class="form-group">
        <label for="tipo">Tipo Evaluación</label>
        <select class="form-control" name="tipo" id="tipo">
          <?foreach($tipos_evaluacion as $tipos):?>
            <option value="<?=$tipos->id?>"><?=$tipos->tipo?></option>
          <?endforeach;?>
        </select>
      </div>
      <div class="form-group">
        <label for="prorroga">Prorroga</label>
        <input class="form-control" name="prorroga" id="prorroga">
      </div>
      <div class="form-group">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" name="exigible" value="true" id="exigible">
          <label class="form-check-label" for="exigible">
            Exigible
          </label>
        </div>
      </div>
      <button type="submit" class="btn btn-primary">Registrar</button>
    </form>
  </div>
</div>
