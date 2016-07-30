package br.edu.ifpb.collegialis.dao;

import javax.persistence.EntityManager;

import br.edu.ifpb.collegialis.entity.Reuniao;

public class ReuniaoDAO extends GenericDAO<Reuniao, Integer> {

	public ReuniaoDAO() {
		super();
	}

	public ReuniaoDAO(EntityManager em) {
		super(em);
	}
	

}
