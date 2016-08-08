<tr>
	<td>${processo.numero}</td>
	<td><fmt:formatDate value="${processo.dataRecepcao}"
			pattern="dd/MM/yyyy" /></td>
	<td><fmt:formatDate value="${processo.dataDistribuicao}"
			pattern="dd/MM/yyyy" /></td>
	<td><fmt:formatDate value="${processo.dataParecer}"
			pattern="dd/MM/yyyy" /></td>
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