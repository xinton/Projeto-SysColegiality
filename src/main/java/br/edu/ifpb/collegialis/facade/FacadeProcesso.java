package br.edu.ifpb.collegialis.facade;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import br.edu.ifpb.collegialis.dao.AlunoDAO;
import br.edu.ifpb.collegialis.dao.AssuntoDAO;
import br.edu.ifpb.collegialis.dao.MembroDAO;
import br.edu.ifpb.collegialis.dao.PersistenceUtil;
import br.edu.ifpb.collegialis.dao.ProcessoDAO;
import br.edu.ifpb.collegialis.entity.Aluno;
import br.edu.ifpb.collegialis.entity.Assunto;
import br.edu.ifpb.collegialis.entity.Membro;
import br.edu.ifpb.collegialis.entity.Processo;
import br.edu.ifpb.collegialis.type.TipoDecisao;

public class FacadeProcesso {
	
	private Processo processo;
	
	private List<String> mensagensErro;
	
	public List<Processo> filtrarPorRelator(String idrelator){
		ProcessoDAO dao = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
		List<Processo> processos = dao.findByRelator(Integer.valueOf(idrelator));
		return processos;
	}
	
	public Resultado cadastrar(Map<String, String[]> parametros) {
		
		Resultado resultado = new Resultado();
		
		// Se passar na validacao, o objeto Processo pode ser persistido
		if (this.validarParametros(parametros)) {
			ProcessoDAO dao = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
			dao.beginTransaction();
			dao.insert(this.processo);
			dao.commit();
			resultado.setErro(false);
			resultado.setMensagensErro(Collections.singletonList("Processo criado com sucesso"));
		} else {
			resultado.setEntitade(this.processo);
			resultado.setErro(true);
			resultado.setMensagensErro(this.mensagensErro);
		}
		return resultado;
	}

	public Resultado atualizar(Map<String, String[]> parametros) {
		// TODO Auto-generated method stub
		return null;
	}
	
	private boolean validarParametros(Map<String, String[]> parametros) {
		// Parametros do form para criar um processo
		String[] numero = parametros.get("numero");
		String[] datarecepcao = parametros.get("datarecepcao");
		String[] datadistribuicao = parametros.get("datadistribuicao");
		String[] dataparecer = parametros.get("dataparecer");
		String[] assunto = parametros.get("assunto");
		String[] decisao = parametros.get("decisao");
		String[] relator = parametros.get("relator");
		String[] requisitante = parametros.get("requisitante");
		
		this.processo = new Processo();
		
		this.mensagensErro = new ArrayList<String>();
		
		// Descricao é obrigatorio
		if (numero == null || numero.length == 0 || numero[0].isEmpty()) {
			this.mensagensErro.add("Numero do Processo é campo obrigatório!");
		} else {
			this.processo.setNumero(numero[0]);
		}
		
		// Data da Recepção é obrigatória
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (datarecepcao == null || datarecepcao.length == 0 || datarecepcao[0].isEmpty()) {
			this.mensagensErro.add("Data de Recepção é campo obrigatório!");
		} else {
			try {
				Date dataRecepcao = sdf.parse(datarecepcao[0]);
				this.processo.setDataRecepcao(dataRecepcao);
			} catch (ParseException e) {
				this.mensagensErro.add("Formato inválido para a data início");
			}
		}
		
		// Define Data de Distribuição
		if (datadistribuicao != null || datadistribuicao.length != 0 || !datadistribuicao[0].isEmpty()){ 
			try{
				Date dataDistribuicao = sdf.parse(datadistribuicao[0]);
				this.processo.setDataDistribuicao(dataDistribuicao);
			} catch (ParseException e) {
				this.mensagensErro.add("Formato inválido para a data início");
			}
			
		}

		// Define Data do Parecer
		if (dataparecer != null || dataparecer.length != 0 || !dataparecer[0].isEmpty()){ 
			try{
				Date dataParecer = sdf.parse(dataparecer[0]);
				this.processo.setDataParecer(dataParecer);
			} catch (ParseException e) {
				this.mensagensErro.add("Formato inválido para a data início");
			}

		}
		
		// Define decisão
		if (decisao != null || decisao.length != 0 || !decisao[0].isEmpty()){ 			
			this.processo.setDecisao(TipoDecisao.valueOf(decisao[0]));
		}
		
		//Busca o Relator na base de dados
		if (relator != null && relator.length != 0 && !relator[0].isEmpty()) {
			MembroDAO dao = new MembroDAO(PersistenceUtil.getCurrentEntityManager());
			Membro m = dao.find(Integer.parseInt(relator[0]));
			this.processo.setRelator(m);
		}

		//Requisitante é obrigatório
		if (requisitante == null || requisitante.length == 0 || requisitante[0].isEmpty()) {
			this.mensagensErro.add("Requisitante é campo obrigatório!");
		} else {
			//Busca o assunto na base de dados
			if (requisitante != null && requisitante.length != 0 && !requisitante[0].isEmpty()) {
				AlunoDAO dao = new AlunoDAO(PersistenceUtil.getCurrentEntityManager());
				Aluno a = dao.find(Integer.parseInt(requisitante[0]));
				this.processo.setRequisitante(a);
			}
		}

		//Assunto é obrigatório
		if (assunto == null || assunto.length == 0 || assunto[0].isEmpty()) {
			this.mensagensErro.add("Assunto é campo obrigatório!");
		} else {
			//Busca o assunto na base de dados
			if (assunto != null && assunto.length != 0 && !assunto[0].isEmpty()) {
				AssuntoDAO dao = new AssuntoDAO(PersistenceUtil.getCurrentEntityManager());
				Assunto a = dao.find(Integer.parseInt(assunto[0]));
				this.processo.setAssunto(a);
			}
		}
		
		return this.mensagensErro.isEmpty();

	}
	

}