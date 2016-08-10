package br.edu.ifpb.collegialis.facade;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import br.edu.ifpb.collegialis.dao.PersistenceUtil;
import br.edu.ifpb.collegialis.dao.ProcessoDAO;
import br.edu.ifpb.collegialis.dao.ReuniaoDAO;
import br.edu.ifpb.collegialis.entity.Processo;
import br.edu.ifpb.collegialis.entity.Reuniao;
import br.edu.ifpb.collegialis.type.StatusReuniao;

public class FacadeReuniao
{
	private Reuniao reuniao;
	private List<String> mensagensErro;
	
	public Resultado cadastrar(Map<String, String[]> parametros, List<Processo> processos)
	{
		System.out.println("Chegou no cadastrar");
		Resultado resultado = new Resultado();
		if (this.validarDados(parametros,processos)) {
			ReuniaoDAO dao = new ReuniaoDAO(PersistenceUtil.getCurrentEntityManager());
			dao.beginTransaction();
			dao.insert(this.reuniao);
			dao.commit();
			resultado.setErro(false);
			resultado.setMensagensSucesso(Collections.singletonList("Reuniao criado com sucesso"));
		} else {
			resultado.setEntitade(this.reuniao);
			resultado.setErro(true);
			resultado.setMensagensErro(mensagensErro);
		}
		
		return resultado;
	}
	
	private boolean validarDados(Map<String, String[]> parametros, List <Processo> processos)
	{
		this.reuniao = new Reuniao();
		String[] data = parametros.get("data"); 
		this.mensagensErro = new ArrayList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if (processos == null || processos.size() == 0 || processos.isEmpty()) {
			this.mensagensErro.add("E necessario ao menos adicionar um processo na reuniao!");
		} else {
			try {				
				this.reuniao.setProcessos(processos);
				for(Processo p : processos){
					p.setReuniao(this.reuniao);
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		
		if (data == null || data.length == 0 || data[0].isEmpty()) {
			this.mensagensErro.add("Data é campo obrigatorio");
		} else {
			try {
				Date dataReuniao = sdf.parse(data[0]);
				this.reuniao.setData(dataReuniao);
			} catch (ParseException e) {
				this.mensagensErro.add("Formato invalido para a data!");
			}
		}
		this.reuniao.setStatus(StatusReuniao.PLANEJADA);

		return this.mensagensErro.isEmpty();
	}
	
	public List<Processo> adicionarProcesso(Map<String, String[]> parametros, List<Processo> processos)
	{		
		String[] processo = parametros.get("processo");
		
		if (processos == null) {
			processos = new ArrayList<Processo>();
		}
			ProcessoDAO dao = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
			Processo p = dao.find(Integer.parseInt(processo[0]));
			System.out.println(p.getRelator());
			processos.add(p);
		
		return processos;
	}
	
	private boolean isProcessoValido(String[] processo)
	{	
		if (processo == null || processo.length == 0 || processo[0].isEmpty()) {
			return false;
		}
		return true;
	}
}
