package br.edu.ifpb.collegialis.dao;

import javax.persistence.EntityManager;

import br.edu.ifpb.collegialis.entity.Membro;

public class MembroDAO extends GenericDAO<Membro, Integer> {

	public MembroDAO() {
		super();
	}

	public MembroDAO(EntityManager em) {
		super(em);
	}
	

}
