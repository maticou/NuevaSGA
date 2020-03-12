<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<div class="container-fluid">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand">Bienvenido administrador</a>
	  <div class="collapse navbar-collapse" id="navbarNav">
	    <ul class="navbar-nav">
	      <li class="nav-item">
	        <a class="nav-link" href="<?=base_url()?>index.php/admin/index">Alumnos <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<?=base_url()?>index.php/admin/indexCursos">Cursos</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<?=base_url()?>index.php/admin/indexDocentes">Docentes</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<?=base_url()?>index.php/login/index">Salir</a>
	      </li>
	    </ul>
	  </div>
	</nav>	
</div>