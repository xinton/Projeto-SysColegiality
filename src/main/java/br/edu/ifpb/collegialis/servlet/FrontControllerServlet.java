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
import br.edu.ifpb.collegialis.facade.FacadeProcesso;
import br.edu.ifpb.collegialis.facade.Resultado;

/**
 * Servlet que atende a todas as requisições dos diversos casos de uso da
 * aplicação. Possui um parâmetro obrigatório onde deve ser informada a operação
 * a ser executada.
 * 
 * Exemplo: para cadastrar um colegiado, a URL é
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
		FacadeProcesso facadeProcesso = new FacadeProcesso();

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
			this.getServletContext().setAttribute("msgsErro", "Operação (op) não especificada na requisição!");
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
		// Cria novo processo
		case "novproc":
			paginaSucesso = "processo/listar.jsp";
			paginaErro = "processo/cadastrar.jsp";
			resultado = facadeProcesso.cadastrar(request.getParameterMap());
			if (!resultado.isErro()) {
				proxPagina = paginaSucesso;
			} else {
				request.setAttribute("processo", (Processo) resultado.getEntitade());
				request.setAttribute("msgsErro", resultado.getMensagensErro());
				proxPagina = paginaErro;
			}
			break;
			// Cria novo processo
		case "filproc":
			paginaSucesso = "processo/listar.jsp";
			paginaErro = "processo/listar.jsp";
			
			List<Processo> processos = facadeProcesso.filtrarPorRelator(request.getParameter("membro") );
			request.setAttribute("processos", processos);
			request.setAttribute("membro", request.getParameter("membro"));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(paginaSucesso);
			dispatcher.forward(request, response);
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
			request.setAttribute("erro", "Operação não especificada no servlet!");
			proxPagina = "../erro/erro.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(proxPagina);
		dispatcher.forward(request, response);

	}
	
}
