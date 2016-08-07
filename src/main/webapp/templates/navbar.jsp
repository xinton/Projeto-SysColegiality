<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp"><i class="glyphicon glyphicon-home"></i></a>
		</div>
		<ul class="nav navbar-nav">
<!-- 		<li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li> -->
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">Colegiado <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/colegiado/cadastrar.jsp">Cadastrar</a></li>
					<li><a href="${pageContext.request.contextPath}/colegiado/listar.jsp">Listar</a></li>
				</ul>
			</li>
			
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false"> Reunião <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/reuniao/planejamento.jsp">Planejar</a></li>
<!-- 					<li><a href="${pageContext.request.contextPath}/reuniao/acompanhamento.jsp">Acompanhar</a></li> -->
				</ul>
			</li>
			
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false"> Processos <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/processo/cadastrar.jsp">Cadastrar</a></li>
					<li><a href="${pageContext.request.contextPath}/processo/listar.jsp">Listar</a></li>
				</ul>
			</li>
		</ul>
	</div>
</nav>