
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
