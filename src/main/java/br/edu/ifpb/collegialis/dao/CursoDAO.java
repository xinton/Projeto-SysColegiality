package br.edu.ifpb.collegialis.dao;

import java.io.Serializable;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import br.edu.ifpb.collegialis.entity.Coordenador;
import br.edu.ifpb.collegialis.entity.Curso;

public class CursoDAO extends GenericDAO<Curso, Integer> implements Serializable{
	private static final long serialVersionUID = 1L;


	public CursoDAO() {
		super();
	}

	public CursoDAO(EntityManager em) {
		super(em);
	}
	
	@SuppressWarnings("unchecked")
	public List<Curso> findAll() throws DAOException {
		try {
		Query q = this.getEntityManager().createQuery("from Curso a order by a.nome asc");
		return (List<Curso>) q.getResultList();
		} catch(PersistenceException e) {
			throw new DAOException("Não foi possível obter todos os cursos do banco. " + e.getMessage());
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Coordenador> selectHistorico(Curso curso) {
		try {
			Query q = this.getEntityManager().createQuery("from Coordenador c where c.curso = :curso order by c.dataInicio desc");
			q.setParameter("curso", curso);
			return q.getResultList();
		} catch (PersistenceException e) {
			throw new DAOException("Não foi possível obter histórico do coordenador. " + e.getMessage());
		}
	}
}
