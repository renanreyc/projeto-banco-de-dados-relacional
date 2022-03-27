WITH cte_salario
as
(
select 
	e.matr,
	e.NOME,
	e.lotacao_div,
sum(v.valor) salario

from empregado e 
inner join emp_venc ev on e.matr = ev.matr  
inner join vencimento v on v.cod_venc = ev.cod_venc
group by e.matr, e.nome, lotacao_div
),

cte_descontos
as 
(
select e.matr,
	e.NOME,
coalesce (sum(d.valor),0) descontos
from empregado e 
left join emp_desc ed on e.matr = ed.matr 
left join desconto d on d.cod_desc = ed.cod_desc 
group by e.nome, e.matr
),

cte_divisao
as 
(
select d.cod_divisao,
d.nome as divisao,
round(avg(v.valor),2) media_divisao

from empregado e 
inner join emp_venc ev on e.matr = ev.matr  
inner join vencimento v on v.cod_venc = ev.cod_venc
inner join divisao d on d.cod_divisao = e.lotacao_div 
group by d.cod_divisao, d.nome
)


select s.nome,
(s.salario - d.descontos) as salario
from cte_salario s
inner join cte_descontos d on s.matr = d.matr
inner join cte_divisao ds on s.lotacao_div = ds.cod_divisao
where (s.salario - d.descontos) >= ds.media_divisao
order by salario desc



