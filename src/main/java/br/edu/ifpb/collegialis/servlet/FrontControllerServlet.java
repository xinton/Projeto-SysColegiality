package br.edu.ifpb.collegialis.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.edu.ifpb.collegialis.entity.Colegiado;
import br.edu.ifpb.collegialis.entity.Processo;
import br.edu.ifpb.collegialis.facade.FacadeColegiado;
import br.edu.ifpb.collegialis.facade.FacadeReuniao;
import br.edu.ifpb.collegialis.facade.Resultado;

/**
 * Servlet que atende a todas as requisi��es dos diversos casos de uso da
 * aplica��o. Possui um par�metro obrigat�rio onde deve ser informada a opera��o
 * a ser executada.
 * 
 * Exemplo: para cadastrar um colegiado, a URL �
 * http://container:porta/collegialis/controller.do?op=cadcol
 */
@WebServlet("/controller.do")
public class FrontControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Para as operacoes com colegiado
		FacadeColegiado facadeColegiado = new FacadeColegiado();
		FacadeReuniao facadeReuniao = new FacadeReuniao();
		String proxPagina = null;
		String paginaErro = null;
		String paginaSucesso = null;
		List <Processo> processos = null;
		HttpSession session = request.getSession();
		//List<Processo> processos;
		this.getServletContext().removeAttribute("msgsErro");

		String operacao = request.getParameter("op");
		if (operacao == null) {
			this.getServletContext().setAttribute("msgsErro", "Opera��o (op) n�o especificada na requisi��o!");
			response.sendRedirect(request.getHeader("Referer"));
			return;
		}

		Resultado resultado = null;
		switch (operacao) {
		// Cria novo colegiado
		case "novcol":
			paginaSucesso = "colegiado/listar.jsp";
			paginaErro = "colegiado/cadastrar.jsp";
			resultado = facadeColegiado.cadastrar(request.getParameterMap());
			if (!resultado.isErro()) {
				proxPagina = paginaSucesso;
			} else {
				request.setAttribute("colegiado", (Colegiado) resultado.getEntitade());
				request.setAttribute("msgsErro", resultado.getMensagensErro());
				proxPagina = paginaErro;
			}
			break;
			// Atualiza um colegiado existente
		case "atucol":
			resultado = facadeColegiado.atualizar(request.getParameterMap());
			if (!resultado.isErro()) {
				proxPagina = paginaErro;
			} else {
				request.setAttribute("msgsErro", resultado.getMensagensErro());
				proxPagina = paginaSucesso;
			}
			break;
		case "+":
			processos = (ArrayList<Processo>) session.getAttribute("processos"); 
			session.setAttribute("processos", facadeReuniao.adicionarProcesso(
						request.getParameterMap(), processos
						));
				//request.setAttribute("processos",
					/*request.setAttribute(
							"processos", facadeReuniao.adicionarProcesso(
									request.getParameterMap(), processos)
							);*/
					//request.setAttribute("processos", arg1);
					proxPagina = "reuniao/planejamento.jsp";
					break;
		case "Salvar":
			System.out.println("ChegouNoSalvar");
			processos = (ArrayList<Processo>) session.getAttribute("processos");
			facadeReuniao.cadastrar(request.getParameterMap(),processos);
			proxPagina = "colegiado/listar.jsp";
			break;
		default:
			request.setAttribute("erro", "Opera��o n�o especificada no servlet!");
			proxPagina = "../erro/erro.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(proxPagina);
		dispatcher.forward(request, response);
	}
	
/*	private void adicionarProcesso()
	{
		
	}*/

}
