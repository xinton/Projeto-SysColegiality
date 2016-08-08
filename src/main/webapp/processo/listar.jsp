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
<script src="${pageContext.request.contextPath}/tinymce/tinymce.min.js"></script>
<script type="text/javascript">
  tinymce.init({
    selector: '#parecer'
  });
 </script>
<title> Processos </title>
</head>
<body>

	<c:import url="../templates/navbar.jsp"/>
	
	<div class="container">
		<div class="main-page" style="margin-top: 70px">
			<h3><i class="glyphicon glyphicon-list"></i> Processos </h3>
			<div class="panel panel-primary">
				<!-- Default panel contents -->
				<div class="panel-heading">Filtros</div>
				<div class="panel-body">
					<form action="${pageContext.request.contextPath}/controller.do"
						method="POST" class="form-horizontal">
						<input type="hidden" name="op" value="filproc">
						<div class="row">
							<div class="col-md-2">
								<label for="membro">Relator:</label> <select
									class="form-control" id="membro" name="membro">
									<option value="99">Nenhum Relator</option>
									<c:forEach var="membro" items="${utilBean.membros}">
										<!--Só professores do colegiado podem ser um relator -->
										<!--Ver questão do colegial ativo do curso -->
										<c:if test="${membro.tipo eq 'PROFESSOR'}">
											<option value="${membro.id}">${membro.professor.nome}
											</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
							<!-- 						<div class="col-md-2">os que estão num determinado status</div> -->
						</div>
						<div class="row" style="margin-top: 10px">
							<div class="col-sm-2" class="form-group">
								<br /> <input type="submit" class="btn btn-primary"
									value="Fltrar">
							</div>
						</div>
					</form>
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
							<th>Data da Recepcao</th>
							<th>Data de Distribuicao</th>
							<th>Data do Parecer</th>
							<th>Parecer</th>
							<th>Decisão</th>
							<th>Assunto</th>
							<th>Votos</th>
							<th>Relator</th>
							<th>Requisitante</th>
							<th>Reunião</th>
							<th>Editar</th>
						</tr>
					</thead>
					<tbody>
<%-- 						<c:set var="processos" value="${utilBean.processos}" /> --%>
<%-- 						<c:if test="${not empty param.relator}"> --%>
<%-- 							<c:forEach var="processoIteretor" items="${utilBean.processos}"> --%>
<%-- 								<c:if test="${processoIteretor.numero eq param.processo}"> --%>
<%-- 									<c:set var="processos" value="${utilBean.processos}" /> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>

						<c:choose>
						    <c:when test="${empty requestScope.processos}">
						    	<c:set var="processos" value="${utilBean.processos}" />
						    </c:when>
						    <c:otherwise>
						    	<c:set var="processos" value="${requestScope.processos}" />
						    </c:otherwise>
						</c:choose>

						<c:forEach var="processo" items="${processos}">
							<tr>
								<td>${processo.numero}</td>
								<td><fmt:formatDate value="${processo.dataRecepcao}"
										pattern="dd/MM/yyyy" /></td>
								<td><fmt:formatDate value="${processo.dataDistribuicao}"
										pattern="dd/MM/yyyy" /></td>
								<td><fmt:formatDate value="${processo.dataParecer}"
										pattern="dd/MM/yyyy" /></td>
								<%-- 								<td>${processo.parecer}</td> --%>
								<td> 
									<div>
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#parecerModal">
											Parecer</button>
									</div> 
								</td>
								<td>${processo.decisao}</td>
								<td>${processo.assunto.descricao}</td>
								<%-- 								<td>${processo.votos}</td> --%>
								<td>votos</td>
								<td>${processo.relator.professor.nome}</td>
								<td>${processo.requisitante.nome}</td>
								<td>${processo.reuniao.id}</td>
								<td>
									<center>
									<a href="${pageContext.request.contextPath}/processo/cadastrar.jsp?processo=${processo.numero}"> <i class="glyphicon glyphicon-pencil"></i> </a>
									</center> 
								</td>
							</tr>

							<!-- Modal -->
							<!--TODO Variar parecer -->
							<!-- http://v4-alpha.getbootstrap.com/components/modal/#varying-modal-content-based-on-trigger-button -->
							<div class="modal fade" id="parecerModal" tabindex="-1"
								role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-lg" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">Parecer do
												processo</h4>
										</div>
										<div class="modal-body">
											<textarea class="form-control" id="parecer" name="parecer">${processo.parecer} </textarea>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">Fechar</button>
											<button type="button" class="btn btn-primary">Salvar</button>
										</div>
									</div>
								</div>
							</div>



						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>