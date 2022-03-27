-- 01.
select d.cod,
d.nome
from disciplina d
inner join cursa c on d.cod = c.cod_disciplina 
inner join professor p on c.matricula_professor = p.matricula 
where p.nome = 'Fábio'
and c.periodo = 'Período 2020.1'

--02.
select d.nome,
count(distinct p.cpf) as qnt_professores
from departamento d
inner join curso c on d.cod_dep = c.cod_dep 
inner join professor p on p.cod_curso = c.cod_curso
group by d.nome

--03. 
select a.nome,
sum(d.creditos) as total_creditos
from aluno a
inner join cursa c on c.matricula_aluno = a.matricula 
inner join disciplina d on c.cod_disciplina = d.cod 
where c.periodo = 'Período 2022.1' --supondo o periodo atual para "cursando" - no momento
group by a.nome 
order by total_creditos desc

--04.
select a.nome,
sum(d.creditos) as total_creditos
from aluno a
inner join cursa c on c.matricula_aluno = a.matricula 
inner join disciplina d on c.cod_disciplina = d.cod 
inner join orienta o on o.matricula_aluno = a.matricula 
inner join professor p on o.matricula_professor = p.matricula 
where c.periodo = 'Período 2020.1' 
and p.nome = 'Fábio'
group by a.nome 

--05.
select d.cod,
	d.nome,
	count(a.matricula) as qtd_alunos
from disciplina d 
inner join cursa c on c.cod_disciplina = d.cod 
inner join aluno a on c.matricula_aluno = a.matricula 
where c.periodo = 'Período 2020.2'
group by d.cod, d.nome 
order by qtd_alunos desc



