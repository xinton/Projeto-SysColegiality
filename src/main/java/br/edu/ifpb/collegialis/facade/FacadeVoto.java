package br.edu.ifpb.collegialis.facade;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import br.edu.ifpb.collegialis.dao.MembroDAO;
import br.edu.ifpb.collegialis.dao.PersistenceUtil;
import br.edu.ifpb.collegialis.dao.ProcessoDAO;
import br.edu.ifpb.collegialis.dao.VotoDAO;
import br.edu.ifpb.collegialis.entity.Membro;
import br.edu.ifpb.collegialis.entity.Processo;
import br.edu.ifpb.collegialis.entity.Voto;
import br.edu.ifpb.collegialis.type.TipoVoto;

public class FacadeVoto 
{
	private List<Voto> votos;
	private List<String> msgsErro;
	
	public void votarProcesso (Map<String, String[]> parametros)
	{
		if (this.validarParametros(parametros))
		{
			VotoDAO dao = new VotoDAO(PersistenceUtil.getCurrentEntityManager());
			dao.beginTransaction();
			
			for(Voto voto: votos){
				dao.insert(voto);
			}
			
			dao.commit();
		}
	}
	
	private boolean validarParametros(Map<String, String[]> parametros)
	{
		System.out.println("ChegouNoValidarParametros");
		this.votos = new ArrayList<Voto>();
		String[] numProcesso = parametros.get("idProcesso");
		
		for(String key: parametros.keySet()){
			if (key.contains("voto")) {
				Voto voto = new Voto(); 
				validarVotacao(voto,parametros.get(key));
				String[] parts = key.split("-");
				adicionarMembro(voto,parts[1]);
				adicionarProcesso(voto,numProcesso);
				this.votos.add(voto);
			} 
		}
		
		return true;		
	}
	
	private void adicionarProcesso(Voto voto, String[] idProcesso)
	{
		ProcessoDAO daoProcesso = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
		Processo processo = daoProcesso.find(Integer.parseInt(idProcesso[0]));
		voto.setProcesso(processo);
	}
	private void adicionarMembro(Voto voto, String idMembro)
	{
		MembroDAO dao = new MembroDAO(PersistenceUtil.getCurrentEntityManager());
		Membro membro = dao.find(Integer.parseInt(idMembro));
		voto.setMembro(membro);
	}
	
	private void validarVotacao(Voto voto, String[] valorVoto)
	{
		if (!valorVoto[0].contains("ausente")) {
			voto.setVoto(TipoVoto.valueOf(valorVoto[0]));
		} else {
			voto.setAusente(true);
		}
	}
}
