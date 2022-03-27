--A. Selecione os hospitais (nome) que temos pacientes sendo tratados de Covid-19 entre 01.03.2020 e 22.10.2020
select distinct h.nome
from hospital h 
	inner join recepcionista r on r.cod_hospital = h.cod_hospital 
	inner join paciente p on p.cod_recepcionista = r.cod_recepcionista 
	inner join tratamento t on t.cod_paciente = p.cod_paciente 
where lower(t.antiviral) like '%covid%'
and p.data_entrada between '2020-03-01' and '2020-10-22'

--B. Liste os pacientes pelo nome e seus respectivos sintomas que estão sendo tratados pelo médico Carlos
select p.nome, p.sintomas
from paciente p 
	inner join tratamento t on t.cod_paciente = p.cod_paciente 
	inner join medico m on m.cod_profissional = t.cod_profissional 
	inner join profissional_da_saude pds on pds.cod_profissional  = m.cod_profissional 
where pds.nome = 'Carlos'

-- C. Liste todos os exames (id, nome) solicitados pelo médico João durante o período de 01.06.2020 e 30.09.2020
 select e.cod_exame, e.nome
 from exame e 
 	inner join medico m on m.cod_profissional = e.cod_profissional 
 	inner join profissional_da_saude pds on pds.cod_profissional = m.cod_profissional
 where pds.nome = 'João'
 and e.data_exame between '2020-06-01' and '2020-09-30'
 
 -- D. Liste os hospitais e quantidade total de pacientes internados para cada um entre o período de Maio/2020 e Julho/2020
select h.nome,
		count(p.cod_paciente) as qtd_pacientes_internados
from hospital h 
	inner join leito l on l.cod_hospital = h.cod_hospital 
	inner join paciente p on p.num_leito = l.num_leito 
where p.data_entrada between '2020-05-01' and '2020-07-31'
group by h.nome

--E. Liste os hospitais e a quantidade média de enfermeiras e médicos alocadas para cada um.
select h.nome,
	count(pds.cod_profissional) / 2 as media_medicos_enfermeiros,
	count(e.cod_profissional) as qtd_enfemeiro,
	count(m.cod_profissional) as qtd_medico
from hospital h
	inner join profissional_da_saude pds on pds.cod_hospital = h.cod_hospital 
	left join enfermeiro e on e.cod_profissional = pds.cod_profissional 
	left join medico m on m.cod_profissional = pds.cod_profissional 
group by h.nome
	
--F. Liste os tratamentos e o número médio de exames realizados para pacientes em tratamento de Covid-19.
select 
	 	concat(
 		case when t.antibiotico is not null then t.antibiotico || ', ' else '' end,
 		case when t.antiviral is not null then t.antiviral || ', ' else '' end,
 		case when t.drogas_vasoactivas is not null then t.drogas_vasoactivas || ', ' else '' end,
 		case when t.oxigenoterapia is null then 'Nenhum tratamento' else 'Oxigenoterapia: ' || t.oxigenoterapia end
 	) as tratamentos_realizados,
 	count(e.cod_exame) / count(p.cod_paciente) media_exames_pacientes
 from paciente p 
 	left join tratamento t on t.cod_paciente = p.cod_paciente 
 	left join exame e on e.cod_paciente = p.cod_paciente 
  group by t.antibiotico, t.antiviral, t.drogas_vasoactivas, t.oxigenoterapia
 	
--G. Selecione todos os paciente apresentando o nome e a quantidade de exames solicitados para cada um
  select p.nome,
 	count(e.cod_exame) qtd_exames
 from paciente p 
 	left join exame e on e.cod_paciente = p.cod_paciente 
 group by p.cod_paciente, p.nome 
 
--H. Selecione o nome de todos os hospitais e apresente uma relação de quanto tempo médio cada leito fica ocupado por algum paciente.
select h.nome,
	avg(date_part('day',m.data_alta - p.data_entrada)) as media_dias_leito_ocupado_por_paciente
from hospital h 
inner join leito l on l.cod_hospital = h.cod_hospital 
inner join paciente p on p.num_leito = l.num_leito 
left join monitora m on m.cod_paciente = p.cod_paciente
group by h.nome



