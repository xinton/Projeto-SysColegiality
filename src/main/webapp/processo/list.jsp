<%@page import="br.edu.ifpb.collegialis.entity.Reuniao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/font-awesome-4.6.3/css/font-awesome.min.css" rel="stylesheet">
<title> Processos </title>
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
			<h3><i class="glyphicon glyphicon-list"></i> Processos </h3>
			<div class="panel panel-primary">
				<!-- Default panel contents -->
				<div class="panel-heading">Filtros</div>
				<div class="row">
					<div class="col-md-2">
						apenas os não atribuídos a um relator
					</div>
					<div class="col-md-2">
						<label for="membro">Relator:</label> 
						<select class="form-control" id="membro" name="membro">
							<c:forEach var="membro" items="${utilBean.membros}">
<!-- 								Só professores do colegiado podem ser um relator -->
								<c:if test="${membro.tipo eq 'PROFESSOR'}">
									<option value="${membro.id}">${membro.professor.nome}
									</option>
								</c:if>								
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2">
						os que estão num determinado status
					</div>
				</div>
			</div>
			
			<div class="panel panel-primary">
				<!-- Default panel contents -->
				<div class="panel-heading"></div>


				<!-- 			Tabela de processos -->
				<table class="table table-bordered table-hover">
					<thead>
						<tr class="info">
							<th>Número</th>
							<th>dataRecepcao</th>
							<th>dataDistribuicao</th>
							<th>dataParecer</th>
							<th>parecer</th>
							<th>decisao</th>
							<th>assunto</th>
							<th>votos</th>
							<th>relator</th>
							<th>requisitante</th>
							<th>reuniao</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="processo" items="${utilBean.processos}">
							<tr>
								<td>${processo.numero}</td>
								<td>
									<fmt:formatDate value="${processo.dataRecepcao}"
										pattern="dd/MM/yyyy" />
								</td>
								<td>
									<fmt:formatDate value="${processo.dataDistribuicao}"
										pattern="dd/MM/yyyy" />
								</td>
								<td>
									<fmt:formatDate value="${processo.dataParecer}"
										pattern="dd/MM/yyyy" />
								</td>
<%-- 								<td>${processo.parecer}</td> --%>
								<td>parecer</td>
								<td>${processo.decisao}</td>
								<td>${processo.assunto.descricao}</td>
<%-- 								<td>${processo.votos}</td> --%>
								<td>votos</td>
								<td>${processo.relator.professor.nome}</td>
								<td>${processo.requisitante.nome}</td>								
								<td>${processo.reuniao.id}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</table>
			</div>
		</div>
	</div>
</body>
</html>