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
	<c:import url="../templates/navbar.jsp"/>
	
	<div class="container">
		<div class="main-page" style="margin-top: 70px">
			<h3><i class="fa fa-edit"></i> Reuniões </h3>

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
					<br /> <a href="${pageContext.request.contextPath}/reuniao/cadastrar.jsp"><button class="btn btn-primary" > Novo </button></a>				</div>
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
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reuniao" items="${utilBean.reunioes}">
							<tr>
								<td>${reuniao.id} 
								<a href="${pageContext.request.contextPath}/reuniao/acompanhamento.jsp?reuniao=${reuniao.id}"> <span class="label label-success">  Abrir  </span> </a> 
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
								<td>
									<center>
																		
									<button type="submit" value="" class="btn btn-default">
									<i class="glyphicon glyphicon-file text-defalut"></i> PDF</button>
									
									<button type="submit" value="" class="btn btn-danger">
									<i class="glyphicon glyphicon-remove text-defalut"></i> Excluir</button>
									</center>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</table>
			</div>
		</div>
	
	<c:set var="endofconversation" value="true" scope="request"/>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>