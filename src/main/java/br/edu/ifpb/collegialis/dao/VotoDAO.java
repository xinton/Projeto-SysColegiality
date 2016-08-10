package br.edu.ifpb.collegialis.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import br.edu.ifpb.collegialis.entity.Aluno;
import br.edu.ifpb.collegialis.entity.Voto;

public class VotoDAO extends GenericDAO<Voto, Integer> {

	public VotoDAO() {
		super();
	}

	public VotoDAO(EntityManager em) {
		super(em);
	}
	
	@SuppressWarnings("unchecked")
	public List<Voto> findAll() throws DAOException {
		try {
		Query q = this.getEntityManager().createQuery("from Voto v");
		return (List<Voto>) q.getResultList();
		} catch(PersistenceException e) {
			throw new DAOException("Não foi possível obter todos os votos do banco. " + e.getMessage());
		}
	}

}
