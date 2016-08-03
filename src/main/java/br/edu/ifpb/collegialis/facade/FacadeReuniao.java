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
	
	public Resultado cadastrarReuniao(Map<String, String[]> parametros)
	{
		Resultado resultado = new Resultado();
		
		if (this.isParametrosValidos(parametros)) {
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
	// MUDAR ESTE METODO PARA SÓ VERIFICAR A DATA
	private boolean isParametrosValidos(Map<String, String[]> parametros)
	{
		String[] data = parametros.get("data");
		//String[] processo = parametros.get("processo");
		
		this.reuniao = new Reuniao();
		this.mensagensErro = new ArrayList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if (data == null || data.length == 0 || data[0].isEmpty()) {
			this.mensagensErro.add("Data é campo obrigatório");
		} else {
			try {
				Date dataReuniao = sdf.parse(data[0]);
				this.reuniao.setData(dataReuniao);
			} catch (ParseException e) {
				this.mensagensErro.add("Formato invalido para a data!");
			}
		}
	/*		
		if (algo == null || processo.length == 0 || processo[0].isEmpty()) {
			this.mensagensErro = new ArrayList<String>();
		} else {
			this.reuniao.setProcessos(processos); // Tem que resgatar do banco o processo para jogar lá
		}
	}*/
		/*if (processo != null && processo.length != 0 && !processo[0].isEmpty()) {
			ProcessoDAO dao = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
			Processo p = dao.find(Integer.parseInt(processo[0]));
			this.reuniao.adicionarProcesso(p);
			p.setReuniao(reuniao);
		}*/
		this.reuniao.setStatus(StatusReuniao.PLANEJADA);
		
		return this.mensagensErro.isEmpty();
	}
	
	public void adicionarProcessoReuniao(Map<String, String[]> parametros)
	{
		String[] processo = parametros.get("processo");

		
		if (this.isProcessoValido(processo)) {
			ProcessoDAO dao = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
			Processo p = dao.find(Integer.parseInt(processo[0]));
			this.reuniao = new Reuniao();
			this.reuniao.adicionarProcesso(p);
			p.setReuniao(reuniao);
			/*ReuniaoDAO dao = new ReuniaoDAO(PersistenceUtil.getCurrentEntityManager());
			dao.beginTransaction();
			dao.insert(this.reuniao);
			dao.commit();
			resultado.setErro(false);
			resultado.setMensagensSucesso(Collections.singletonList("Colegiado criado com sucesso"));*/
		}
	}
	// DEPOIS MUDAR ESTE METODO PARA ELE APENAS VALIDAR O PROCESSO, NESTE CASO ELE ESTA VALIDANDO E SETANDO.
	private boolean isProcessoValido(String[] processo)
	{	
		if (processo == null || processo.length == 0 || processo[0].isEmpty()) {
			return false;
		}
		
		return true;
	}
}
