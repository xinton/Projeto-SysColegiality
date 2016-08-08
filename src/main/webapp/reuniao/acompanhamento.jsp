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
<title> Reuniao </title>
</head>
<body>
	<c:import url="../templates/navbar.jsp"/>
	
	<div class="container">
		<div class="main-page" style="margin-top: 70px">

			<div class="row">
				<div class="col-sm-6">
					<h3>
						<i class="fa fa-edit"></i> Reuniao numeroDinamico
					</h3>
				</div>

				<div class="col-sm-2 pull-right">
					<label for="dataReuniao" class="control-label">Data:</label>
					<input type="date" id="dataReuniao" value=""/>
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
									<a href="acompanhamento.jsp?reuniao=${param.reuniao}&processo=${processoI.numero}" 
									class="list-group-item"> ${processoI.numero} </a>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<input type="submit" class="btn btn-primary">
				</div>

				<div class="col-sm-9 " class="form-group">
					<div class="panel panel-primary">
						<div class="panel-heading"> Processo em apreciação </div>
						<div class="panel-body">
							<form action="${pageContext.request.contextPath}/controller.do" method="POST" class="form-horizontal">
								<input type="hidden" name="idProcesso" value="${processo.id}">
<!-- 								DETALHE AQ -->
								
								
								<div class="row">								
									<div class="col-sm-4" class="form-group">
										<label for="numeroProcesso" class="control-label">Nº:</label>
										<div>
											<input type="text" id="numeroProcesso" value="${processo.numero}"
												name="numeroProcesso" class="form-control" placeholder="00" />
										</div>
										
										<label for="assunto" class="control-label">Assunto:</label>
										<div>
											<input type="text" id="assunto" value="${processo.assunto.descricao}"
												name="assunto" class="form-control" placeholder="Descricao" />
										</div>
										
										<label for="relator" class="control-label">Relator:</label>
										<div>
											<input type="text" id="relator" value="${processo.relator.professor.nome}"
												name="relator" class="form-control" placeholder="Relator" />
										</div>
									</div>

									<div class="col-sm-4" class="form-group">
										<label for="solicitante" class="control-label">Solicitante:</label>
											<div>
												<input type="text" id="solicitante"
													value="${processo.requisitante.nome}" name="solicitante"
													class="form-control" placeholder="Solicitante"> </input>
											</div>

										<div class="row">
										
											<div class="col-sm-6" class="form-group">
												<label for="decisao" class="control-label">Decisão:</label>
												<div>
													<input type="text" id="decisao"
														value="${processo.decisao}" name="decisao"
														class="form-control" placeholder="decisao"> </input>
												</div>
											</div>
											
											<div class="col-sm-6" class="form-group">
												<label for="parecer" class="control-label">Parecer:</label>
												<div>
													<input type="file" accept=".pdf" id="parecer" name="parecer"/>													
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
															<input type="radio" name="voto-${membro.id}" value="COM_RELATOR"/>
															Com o relator														
														</td>
														<td>
															<input type="radio" name="voto-${membro.id}" value="DIVERGENTE"/>
															Divergente
														</td>
														<td>
															<input type="radio" name="voto-${membro.id}" value="ausente"/>
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
										<br /> <input type="submit" class="btn btn-primary" name="op"
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
	
	<c:set var="endofconversation" value="true" scope="request"/>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>