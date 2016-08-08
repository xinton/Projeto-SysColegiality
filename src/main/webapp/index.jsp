<%@page import="br.edu.ifpb.collegialis.entity.Reuniao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/font-awesome-4.6.3/css/font-awesome.min.css"
	rel="stylesheet">
<title>Home</title>
</head>
<body>
	<c:import url="templates/navbar.jsp" />
	
	<div class="container">
		<div class="main-page" style="margin-top: 70px">
			<h3><i class="glyphicon glyphicon-education"></i> Collegialis </h3>
			
			<p>Sistema de gestão de processos de colegiados dos cursos de
		tecnologia do IFPB</p>
			
		</div>
	</div>
	

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>