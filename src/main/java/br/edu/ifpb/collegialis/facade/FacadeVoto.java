package br.edu.ifpb.collegialis.facade;

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
	private Voto voto;
	private Voto voto2;
	private Voto voto3;
	
	private List<String> msgsErro;
	
	public void votarProcesso (Map<String, String[]> parametros)
	{
		if (this.validarParametros(parametros))
		{
			VotoDAO dao = new VotoDAO(PersistenceUtil.getCurrentEntityManager());
			dao.beginTransaction();
			dao.insert(this.voto);
			dao.insert(this.voto2);
			dao.insert(this.voto3);
			dao.commit();
		}
	}
	
	private boolean validarParametros(Map<String, String[]> parametros)
	{
		this.voto = new Voto();
		this.voto2 = new Voto();
		this.voto3 = new Voto();
		String[] numProcesso = parametros.get("idProcesso");
		String[] voto1 = parametros.get("voto-1");
		String[] voto2 = parametros.get("voto-2");
		String[] voto3 = parametros.get("voto-3");
		MembroDAO dao = new MembroDAO(PersistenceUtil.getCurrentEntityManager());
		Membro m1 = dao.find(1);
		Membro m2 = dao.find(2);
		Membro m3 = dao.find(3);
		ProcessoDAO daoProcesso = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
		Processo p1 = daoProcesso.find(Integer.parseInt(numProcesso[0]));
		this.voto.setProcesso(p1);
		this.voto.setMembro(m1);		
		this.voto.setProcesso(p1);
		this.voto2.setProcesso(p1);
		this.voto3.setProcesso(p1);
		this.voto2.setMembro(m2);
		this.voto3.setMembro(m3);
		
		if (!voto1[0].contains("ausente")) {
			this.voto.setVoto(TipoVoto.valueOf(voto1[0]));
		} else {
			this.voto.setAusente(true);
		}
		
		if (!voto2[0].contains("ausente")) {
			this.voto2.setVoto(TipoVoto.valueOf(voto2[0]));
		} else {
			this.voto2.setAusente(true);
		}
		
		if (!voto3[0].contains("ausente")) {
			this.voto3.setVoto(TipoVoto.valueOf(voto3[0]));
		} else {
			this.voto3.setAusente(true);
		}
		
		return true;		
		
	}
}
