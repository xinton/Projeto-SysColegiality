package br.edu.ifpb.collegialis.dao;


import java.util.Arrays;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import br.edu.ifpb.collegialis.entity.Processo;
import br.edu.ifpb.collegialis.entity.Reuniao;

public class ProcessoDAO extends GenericDAO<Processo, Integer> {

	public ProcessoDAO() {
		super();
	}

	public ProcessoDAO(EntityManager em) {
		super(em);
	}
	
	@SuppressWarnings("unchecked")
	public Processo update(Processo p) {
		Query q = this.getEntityManager().createQuery(
				"UPDATE "
				+ "FROM Processo "
				+ "SET dt_distribuicao = :p_dt_distribuicao,"
				+ "dt_parecer = :p_dt_parecer, dt_recepcao = :p_dt_recepcao,"
				+ "tp_decisao = :p_tp_decisao,  id_relator = :p_id_relator,"
				+ "lb_parecer = :p_lb_parecer, id_assunto = :p_id_assunto,"
				+ "id_requisitante = :p_id_requisitante"
				+ "WHERE nu_processo = :p_nu_processo"
				);
		q.setParameter("p_dt_distribuicao", p.getDataDistribuicao());
		q.setParameter("p_dt_parecer", p.getDataParecer());
		q.setParameter("p_dt_recepcao", p.getDataRecepcao());
		q.setParameter("p_tp_decisao", p.getDecisao());
		q.setParameter("p_id_relator", p.getRelator().getId());
		//q.setParameter("p_id_reuniao", p.getReuniao().getId());
		q.setParameter("p_id_requisitante", p.getRequisitante().getId());
		return (Processo) q.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Processo> find(Integer[] ids) {
		Query q = this.getEntityManager().createQuery("from Processo where id IN :ids");
		q.setParameter("ids", Arrays.asList(ids));
		return q.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Processo> findByRelator(Integer idrelator) {
		//Processos sem realtor
		if (idrelator == 99) {
			Query q = this.getEntityManager().createQuery("from Processo where id_relator is null");
			return q.getResultList();
		} else {
			Query q = this.getEntityManager().createQuery("from Processo where id_relator = :idrelator");
			q.setParameter("idrelator", idrelator);
			return q.getResultList();
		}
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Processo> findAll() throws DAOException {
		try {
		Query q = this.getEntityManager().createQuery("from Processo p");
		return (List<Processo>) q.getResultList();
		} catch(PersistenceException e) {
			throw new DAOException("Não foi possível obter todos os coordenadores do banco. " + e.getMessage());
		}
	}

}
