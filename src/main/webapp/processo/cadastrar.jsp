<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastro Processo</title>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/font-awesome-4.6.3/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>

	<c:import url="../templates/navbar.jsp"/>

	<div class="container">
		<div class="main-page" style="margin-top: 70px">
			<h3><i class="fa fa-edit"></i> Cadastrar Processo</h3>

			<!-- Mensagens de erro do formulario -->
			<c:if test="${not empty msgsErro}">
				<div style="color: red">
					<ul>
						<c:forEach var="msg" items="${msgsErro}">
							<li>${msg}</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>
			
			<div style="margin-bottom:30px"></div>

			<div class="panel panel-primary">
				<div class="panel-heading">Dados do Processo</div>
				<div class="panel-body">

					<form action="${pageContext.request.contextPath}/controller.do" method="POST" class="form-horizontal">
						<input type="hidden" name="op" value="novproc">
						<div class="row">
							<div class="col-sm-3 class="form-group">
								<label for="numero" class="control-label"> *Número do Processo:</label>
								<div>
									<input id="numero" value="${processo.numero}" name="numero" type="text" class="form-control" placeholder="0000000000000/yyyy" />
								</div>
							</div>
						</div>
						<div class="row" style="margin-top:10px">
							<div class="col-sm-2" class="form-group">
								<label for="datarecepcao" class="control-label">*Data de Recepcao:</label>
								<div>
									<input id="datarecepcao" value="${processo.dataRecepcao}" name="datarecepcao" class="form-control" type="date" />
								</div>
							</div>						
							<div class="col-sm-2" class="form-group">
								<label for="datadistribuicao" class="control-label">Data da Distribuicao:</label>
								<fmt:formatDate var="dif" value="${processo.dataDistribuicao}" pattern="dd/MM/yyyy"/>  
								<input id="datadistribuicao" value="${dif}" name="datadistribuicao" class="form-control" type="date" placeholder="dd/mm/aaaa" />
							</div>
							<div class="col-sm-2" class="form-group">
								<label for="dataparecer" class="control-label">Data do Parecer:</label> 
								<fmt:formatDate var="dff" value="${processo.dataParecer}" pattern="dd/MM/yyyy"/>
								<input id="dataparecer" value="${dff}" name="dataparecer" class="form-control" type="date" placeholder="dd/mm/aaaa" />
							</div>
						</div>

						<div class="row" style="margin-top:10px">
							<div class="col-sm-4" class="form-group">
									<label for="assunto">*Assunto:</label> 
									<select class="form-control" id="assunto" name="assunto">
									<option value=""> Selecione </option>
									<c:forEach var="assunto" items="${utilBean.assuntos}">
										<option value="${assunto.id}" label="${assunto.descricao}" selected>${assunto.descricao}</option>
									</c:forEach>
									</select>
							</div>
							<div class="col-sm-2" class="form-group">
								<label for="decisao">Decisão:</label> 
								<select class="form-control" id="decisao" name="decisao">
									<option value="DEFERIDO" label="DEFERIDO">DEFERIDO</option>
									<option value="INDEFERIDO" label="INDEFERIDO">INDEFERIDO</option>
								</select>
							</div>
						</div>
						
						<div class="row" style="margin-top:10px">
							<div class="col-sm-3" class="form-group">
								<label for="requisitante">*Requisitante:</label> 
									<select class="form-control" id="requisitante" name="requisitante">
										<option value=""> Selecione </option>
										<c:forEach var="aluno" items="${utilBean.alunos}">
											<option value="${aluno.id}">${aluno.nome}</option>
										</c:forEach>
									</select>
							</div>
							<div class="col-sm-3" class="form-group">
								<label for="relator">Relator:</label> 
								<select class="form-control" id="relator" name="relator">
									<option value=""> Selecione </option>
									<c:forEach var="membro" items="${utilBean.membros}">
									<!--Só professores do colegiado podem ser um relator -->
									<!--Ver questão do colegial ativo do curso -->
									<!--Aqui simulando atual colegiado de TSI -->
									<!--Isso seria pego do coordenador logado(curso e colegiado atual) -->
										<c:if test="${membro.tipo eq 'PROFESSOR' and membro.colegiado.id eq 1}">
											<option value="${membro.id}">${membro.professor.nome}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="row" style="margin-top:10px">
							<div class="col-sm-2" class="form-group">
								<br /> <input type="submit" class="btn btn-primary" value="Criar">
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