package br.edu.ifpb.collegialis.listener;

import java.util.List;

import br.edu.ifpb.collegialis.dao.AlunoDAO;
import br.edu.ifpb.collegialis.dao.AssuntoDAO;
import br.edu.ifpb.collegialis.dao.ColegiadoDAO;
import br.edu.ifpb.collegialis.dao.CursoDAO;
import br.edu.ifpb.collegialis.dao.MembroDAO;
import br.edu.ifpb.collegialis.dao.PersistenceUtil;
import br.edu.ifpb.collegialis.dao.ProcessoDAO;
import br.edu.ifpb.collegialis.dao.ReuniaoDAO;
import br.edu.ifpb.collegialis.entity.Aluno;
import br.edu.ifpb.collegialis.entity.Assunto;
import br.edu.ifpb.collegialis.entity.Colegiado;
import br.edu.ifpb.collegialis.entity.Curso;
import br.edu.ifpb.collegialis.entity.Membro;
import br.edu.ifpb.collegialis.entity.Processo;
import br.edu.ifpb.collegialis.entity.Reuniao;

public class UtilBean {
	
//	public Reuniao getReuniao(int id) {
//		ReuniaoDAO dao = new ReuniaoDAO(PersistenceUtil.getCurrentEntityManager());
//		Reuniao reuniao = dao.find(id);
//		return reuniao;
//	}
	
//	public List<Processo> getProcessosByRelator(String relator){
//		ProcessoDAO dao = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
//		List<Processo> processos = dao.findByRelator(Integer.valueOf(relator));
//		return processos;
//	}

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
	
	public List<Reuniao> getReunioes() {
		ReuniaoDAO dao = new ReuniaoDAO(PersistenceUtil.getCurrentEntityManager());
		List<Reuniao> reunioes = dao.findAll();
		return reunioes;
	}
	
	public List<Processo> getProcessos() {
		ProcessoDAO dao = new ProcessoDAO(PersistenceUtil.getCurrentEntityManager());
		List<Processo> processos = dao.findAll();
		return processos;
	}
	
	public List<Assunto> getAssuntos() {
		AssuntoDAO dao = new AssuntoDAO(PersistenceUtil.getCurrentEntityManager());
		List<Assunto> assuntos = dao.findAll();
		return assuntos;
	}
	
	public List<Membro> getMembros() {
		MembroDAO dao = new MembroDAO(PersistenceUtil.getCurrentEntityManager());
		List<Membro> membros = dao.findAll();
		return membros;
	}
	
	public List<Aluno> getAlunos() {
		AlunoDAO dao = new AlunoDAO(PersistenceUtil.getCurrentEntityManager());
		List<Aluno> alunos = dao.findAll();
		return alunos;
	}

}
