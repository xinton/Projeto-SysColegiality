<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/font-awesome-4.6.3/css/font-awesome.min.css" rel="stylesheet">
<title>Planejamento de Reunioes</title>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="../index.jsp">Home</a>
			</div>
		</div>
	</nav>
	
	<div class="container">
		<div class="main-page" style="margin-top: 70px">
			<h3><i class="fa fa-edit"></i> Planejamento de reuniões </h3>

			<!-- Mensagens de erro do formulario -->
<%-- 			<c:if test="${not empty msgsErro}"> --%>
<!-- 				<div style="color: red"> -->
<!-- 					<ul> -->
<%-- 						<c:forEach var="msg" items="${msgsErro}"> --%>
<%-- 							<li>${msg}</li> --%>
<%-- 						</c:forEach> --%>
<!-- 					</ul> -->
<!-- 				</div> -->
<%-- 			</c:if> --%>
			
			<div style="margin-bottom:30px"></div>

<!-- 			Botão nova reuniao (tirar?) -->
			<div class="row">
				<div class="col-sm-2" class="form-group">
					<br /> <input type="submit" class="btn btn-primary" value="Novo">
				</div>
				<div class="col-sm-2 pull-right" class="form-group">
					<label for="status">Status:</label> <select class="form-control"
						id="status" name="status">
						<option value="PLANEJADA" selected>PLANEJADAS</option>
						<option value="ENCERRADA" >ENCERRADAS</option>
					</select>
				</div>
			</div>
			
			<div style="margin-bottom:30px"></div>


			<div class="panel panel-primary">
				<!-- Default panel contents -->
				<div class="panel-heading">Reuniões</div>


				<!-- 			Tabela da reunioes -->
				<table class="table table-bordered table-hover">
					<thead>
						<tr class="info">
							<th>Reuniao</th>
							<th>Data</th>
							<th>Processos</th>
							<th>Status</th>
							<th>Operacoes</th>
							<th>Excluir</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reuniao" items="${utilBean.reunioes}">
							<tr>
								<td>${reuniao.id} 
								<a href="acompanhamento.jsp?reuniao=${reuniao.id}"> <span class="label label-success">  Ir  </span> </a> 
								</td>
								
<%-- 								<a href=" --%>
<%-- 									<c:url value='/cadastraUsuario.jsp'> --%>
<%-- 										<c:param name="id" value="123"> --%>
<%-- 									</c:url> --%>
<!-- 									">click!</a> -->
								
								<td><fmt:formatDate value="${reuniao.data}"
										pattern="dd/MM/yyyy" /></td>
								<td>${reuniao.countProcessos}</td>
								<td>${reuniao.status}</td>
								<td><input type="submit" class="btn btn-primary"
									value="PDF"></td>
								<td><input type="submit" class="btn btn-primary"
									value="x"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</table>
			</div>


			<div class="panel panel-primary">
				<div class="panel-heading">Nova Reunião</div>
				<div class="panel-body">

					<form action="${pageContext.request.contextPath}/controller.do" method="POST" class="form-horizontal">
						<input type="hidden" name="op" value="novcol">
						<div class="row">
							<div class="col-sm-2" class="form-group">
								<!-- 	O que é esse "07/2016" -->
								<label for="reuniao" class="control-label">Reuniao:</label>
								<div>
									<input type="number" id="reuniao" value="${reuniao.status}" name="descricao"  class="form-control" placeholder="00" />
								</div>
								<label for="data" class="control-label">Data:</label>
								<div>	
									<input type="date" id="data" value="${reuniao.data}" name="data"  class="form-control" placeholder=dd/mm/aaaa" />
								</div>
							</div>
							
							<div class="col-sm-5 pull-right" class="form-group">
								<label for="observacoes" class="control-label">Observações:</label>
								<div>
									<textarea id="observacoes" value="" name="observacoes"  class="form-control" placeholder="Observações" > </textarea>
								</div>
							</div>							
						</div>

						<div class="row">
							<div class="col-sm-6" class="form-group">
								<label for="processo" class="control-label">Processos:</label> 
								<select
									class="form-control" id="processo" name="processo">
									<c:forEach var="processo" items="${utilBean.processos}">
										<option value="${processo.id}">${processo.numero},
											${processo.relator.professor.nome}</option>
									</c:forEach>
								</select>
							</div>

							<div class="col-sm-2" class="form-group">
								<br /> <input type="submit" class="btn btn-primary" value="+">
							</div>
						</div>
						
						<div style="margin-bottom:30px"></div>

						<!-- 			Tabela da processos -->
						<table class="table table-bordered table-hover">
							<thead>
								<tr class="info">
									<th>Nº</th>
									<th>Requisitante</th>
									<th>Assunto</th>
									<th>Relator</th>
									<th>Excluir</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="processo" items="${utilBean.processos}">
									<tr>
										<td>${processo.numero}</td>
										<td>${processo.requisitante.nome}</td>
										<td>${processo.assunto.descricao}</td>
										<td>${processo.relator.professor.nome}</td>	
										<td><input type="submit" class="btn btn-primary" value="Excluir"></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<div class="row">
							<div class="col-sm-2" class="form-group">
								<br /> <input type="submit" class="btn btn-primary" value="Salvar">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<c:set var="endofconversation" value="true" scope="request"/>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>