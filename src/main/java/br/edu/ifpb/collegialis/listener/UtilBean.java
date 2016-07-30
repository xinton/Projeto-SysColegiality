package br.edu.ifpb.collegialis.listener;

import java.util.List;

import br.edu.ifpb.collegialis.dao.ColegiadoDAO;
import br.edu.ifpb.collegialis.dao.CursoDAO;
import br.edu.ifpb.collegialis.dao.PersistenceUtil;
import br.edu.ifpb.collegialis.entity.Colegiado;
import br.edu.ifpb.collegialis.entity.Curso;

public class UtilBean {

	public List<Curso> getCursos() {
		CursoDAO dao = new CursoDAO(PersistenceUtil.getCurrentEntityManager());
		List<Curso> cursos = dao.findAll();
		return cursos;
	}
	
	public List<Colegiado> getColegiados() {
		ColegiadoDAO dao = new ColegiadoDAO(PersistenceUtil.getCurrentEntityManager());
		List<Colegiado> colegiados = dao.findAll();
		return colegiados;
	}

}
