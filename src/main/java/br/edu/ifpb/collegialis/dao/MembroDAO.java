package br.edu.ifpb.collegialis.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import br.edu.ifpb.collegialis.entity.Membro;

public class MembroDAO extends GenericDAO<Membro, Integer> {

	public MembroDAO() {
		super();
	}

	public MembroDAO(EntityManager em) {
		super(em);
	}
	
	@SuppressWarnings("unchecked")
	public List<Membro> findAll() throws DAOException {
		try {
		Query q = this.getEntityManager().createQuery("from Membro m");
		return (List<Membro>) q.getResultList();
		} catch(PersistenceException e) {
			throw new DAOException("Não foi possível obter todos os coordenadores do banco. " + e.getMessage());
		}
	}
	

}
