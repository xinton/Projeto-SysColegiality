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
    selector: '#mytextarea'
  });
  </script>
<title> Reuniao </title>
</head>
<body>
	<c:import url="../templates/navbar.jsp"/>
	
	<div class="container">
		<div class="main-page" style="margin-top: 70px">

			<div class="row">
				<div class="col-md-10">
					<h3>
						<i class="fa fa-edit"></i> Reuniao 
					</h3>
				</div>

				<div class="col-md-2" style="border:2px solid #337ab7; border-radius:5px">
					<label for="dataReuniao" class="control-label">Data:</label>
					<c:forEach var="reuniao" items="${utilBean.reunioes}">
						<c:if test="${reuniao.id eq param.reuniao}">
							<h4><fmt:formatDate type="date" value="${reuniao.data}"/></h4>
						</c:if>
					</c:forEach>
				</div>
			</div>

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

	<c:if test="${not empty param.processo}">
		<c:forEach var="processoIteretor" items="${utilBean.processos}">
			<c:if test="${processoIteretor.numero eq param.processo}">
				<c:set var="processo"  value="${processoIteretor}"/>
			</c:if>
		</c:forEach>
	</c:if>
	
	<%
//         br.edu.ifpb.collegialis.dao.ReuniaoDAO reuniaoDAO = new br.edu.ifpb.collegialis.dao.ReuniaoDAO();
// 		Integer reuniaoID = (Integer) request.getAttribute("reuniao");
// 		Reuniao reuniao = reuniaoDAO.getReuniao(reuniaoID);
//         pageContext.setAttribute("reuniao", reuniao, PageContext.PAGE_SCOPE);
    %>

			<div class="row">

				<div class="col-sm-3" class="form-group">
					<div class="panel panel-primary">
						<!-- Default panel contents -->
						<div class="panel-heading">Pauta</div>

						<!-- List group -->
						<div class="list-group">
							<c:forEach var="processoI" items="${utilBean.processos}">
								<c:if test="${processoI.reuniao.id eq param.reuniao}">
									<a href="${pageContext.request.contextPath}/reuniao/acompanhamento.jsp?reuniao=${param.reuniao}&processo=${processoI.numero}" 
									class="list-group-item"> ${processoI.numero} </a>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<input type="submit" class="btn btn-primary" value="Encerrar Reunião">
				</div>

				<div class="col-sm-9 " class="form-group">
					<div class="panel panel-primary">
						<div class="panel-heading"> Processo em apreciação </div>
						<div class="panel-body">
							<form action="${pageContext.request.contextPath}/controller.do" method="POST" class="form-horizontal">

<!-- 								DETALHE AQ -->
								<input type="hidden" name="op" value="novcol">
<!-- 								DETALHE AQ -->
								
								<div class="row">								
									<div class="col-sm-4" class="form-group">
										<label for="numeroProcesso" class="control-label disabled">Nº:</label>
										<div>
											<p id="numeroProcesso" name="numeroProcesso" class="form-control-static">${processo.numero}</p>
<%-- 											<input type="text" id="numeroProcesso" value="${processo.numero}" --%>
<!-- 												name="numeroProcesso" class="form-control disabled" placeholder="00" /> -->
										</div>
										
										<label for="assunto" class="control-label">Assunto:</label>
										<div>
											<p id="assunto" name="assunto" class="form-control-static">${processo.assunto.descricao}</p>
<%-- 											<input type="text" id="assunto" value="${processo.assunto.descricao}" --%>
<!-- 												name="assunto" class="form-control disabled" placeholder="Descricao" /> -->
										</div>
										
										<label for="relator" class="control-label">Relator:</label>
										<div>
											<p id="relator" name="relator" class="form-control-static">${processo.relator.professor.nome}</p>
<%-- 											<input type="text" id="relator" value="${processo.relator.professor.nome}" --%>
<!-- 												name="relator" class="form-control disabled" placeholder="Relator" /> -->
										</div>
									</div>

									<div class="col-sm-4" class="form-group">
										<label for="solicitante" class="control-label disabled">Solicitante:</label>
											<div>
												<p id="solicitante" name="solicitante" class="form-control-static">${processo.requisitante.nome}</p>
<!-- 												<input type="text" id="solicitante" -->
<%-- 													value="${processo.requisitante.nome}" name="solicitante" --%>
<!-- 													class="form-control disabled" placeholder="Solicitante"> </input> -->
											</div>

										<div class="row">

											<div class="col-sm-8" class="form-group">
												<label for="decisao">Decisão:</label> <select
													class="form-control" id="decisao" name="decisao">
													<option value="DEFERIDO" label="DEFERIDO">DEFERIDO</option>
													<option value="INDEFERIDO" label="INDEFERIDO">INDEFERIDO</option>
												</select>
											</div>

											<!-- <div class="col-sm-6" class="form-group"> -->
<!-- 												<label for="decisao" class="control-label disabled">Decisão:</label> -->
<!-- 												<div> -->
<!-- 													<input type="text" id="decisao" -->
<%-- 														value="${processo.decisao}" name="decisao" --%>
<!-- 														class="form-control disabled" placeholder="decisao"> </input> -->
<!-- 												</div> -->
<!-- 											</div> -->
											
											<div class="col-sm-6" class="form-group">
												<label for="parecer" class="control-label disabled">Parecer:</label>
												<div>
													<button type="button" class="btn btn-primary"
														data-toggle="modal" data-target="#parecerModal">
														Parecer
													</button>
<!-- 													<input type="file" accept=".pdf" id="parecer" name="parecer"/>													 -->
												</div>
											</div>

										</div>

									</div>
								</div>																
								
								<!-- GAMBIS -->
								<div style="margin-bottom:30px"></div>
								<div class="list-group">
									<a class="list-group-item active"> Voto </a>
								</div>
								
								<div class="row">
									<div class="col-sm-12" class="form-group">
										<table class="table">
											<tbody>
												<c:forEach var="membro" items="${utilBean.membros}">
													<tr>
														<td>
															<!-- Ver os alunos membros tb -->
															${membro.professor.nome}
														</td>
														<td>
															<input type="radio" name="voto${membro.id}" value="comrelator"/>
															Com o relator														
														</td>
														<td>
															<input type="radio" name="voto${membro.id}" value="divergente"/>
															Divergente
														</td>
														<td>
															<input type="radio" name="voto${membro.id}" value="ausente"/>
														 	Ausente
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>

								<div class="row">
									<div class="col-sm-2" class="form-group">
										<br /> <input type="submit" class="btn btn-primary"
											value="Concluir">
									</div>
									<div class="col-sm-2" class="form-group">
										<br /> <input type="submit" class="btn btn-primary"
											value="Retirar Pauta">
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div style="margin-bottom:30px"></div>
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="parecerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	        <h4 class="modal-title" id="myModalLabel">Parecer do processo</h4>
	      </div>
	      <div class="modal-body">
	        	<textarea id="mytextarea">Hello, World!</textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
	        <button type="button" class="btn btn-primary">Salvar</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<c:set var="endofconversation" value="true" scope="request"/>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>