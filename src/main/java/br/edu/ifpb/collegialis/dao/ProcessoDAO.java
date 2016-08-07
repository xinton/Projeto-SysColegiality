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
