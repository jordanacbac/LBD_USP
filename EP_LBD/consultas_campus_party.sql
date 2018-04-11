-- 1. Uso do comando LIKE como forma de busca de informação em campos do tipo texto.
-- Enunciado: liste o id, o tipo, o titulo, data, hora do inicio, cpf e nome do palestrante
-- de todas as atividades que tenham 'tecnologia' como parte do tema.

select a.id_atividade, a.tipo_atividade, p.titulo_palestra, a.data_atividade, a.hora_inicio
from atividade as a
inner join palestrante as p on p.cpf = a.cpf_palestrante
where tema_palestra like '%tecnologia%';


-- 2. Uso de comandos de pertinência a conjuntos (IN ou ALL). 
-- Enunciado: liste o nome do participante, modelo e marca e valor pago em sua barraca, e, por fim, o valor pago na inscrição desde que
-- o participante tenha como ocupação 'funcionario publico' e tenha se inscrito com a categoria pagante com barraca.

-- Retornos esperados dos seguintes registros:
-- PARTICIPANTE ('21111111111', 'Gabriel Garcia', TO_DATE('12/12/2000', 'dd/mm/yyyy'), 'gabriel@email.com', '11977766545', 'M', 'Funcionario Publico', 'pagante com barraca', 300, 0, 1, 10, 4);
-- BARRACA (id_barraca, cpf, modelo, marca) VALUES (6, '21111111111', 'Modelo 1', 'Marca 1');
-- PAGANTE (cpf, valor_insc) VALUES ('21111111111', 450.00)

select participante.nome,
	   participante.valor_barraca as custo_barraca,
	   barraca.modelo as modelo_barraca,
	   barraca.marca as marca_barraca,
	   pagante.valor_insc as custo_inscricao
from participante,
	 barraca,
	 pagante
where participante.cpf = barraca.cpf and participante.cpf = pagante.cpf and participante.cpf in (
	select participante.cpf
	from participante
	where ocupacao like '%Funcionario Publico%' and categoria_ins like 'pagante com barraca'
);


-- 3. Qual o custo médio pago pelos participantes em suas inscrições?
-- Faça uma consulta utilizando como
-- critério os que alugaram barraca e os que não e encontre os valores mínimo e máximo para cada grupo.

-- Custo médio das inscrições geral
select avg(valor_insc), min(valor_insc), max(valor_insc)
from pagante;

-- Custo médio do aluguel das barracas
select avg(valor_barraca), min(valor_barraca), max(valor_barraca)
from participante;


-- 4. Retorne o nome, a cidade de origem e a quantidade de pessoas transportadas da caravana que apresenta a
--    maior quantidade de ônibus utilizados para o evento.

-- 5. Qual a cidade de origem da maior parte dos participantes do evento? E se considerarmos apenas os isentos?

-- 6. Recupere os nomes de todos os palestrantes e painelistas cujas atividades ocorrerão no dia 11/01/2018.

-- 7.a Retorne os nomes das exposições em que os expositores apresentem pelo menos 1 produto cujo preço é maior do que R$100,00 e que
-- a somatoria dos produtos seja maior do que R$250,00.

-- Retornos esperados dos seguintes registros:
-- PRODUTO (4, 'Moletom Mulher Maravilha', 'vestuario', 'Vermelha com estampa, capuz', 500, 200.00, '44444444444')
-- PRODUTO (6, 'Replica Dr. Estranho', 'colecionavel', 'Replica de aço escala 1/6', 100, 500.00, '99999999999')
-- PRODUTO (7, 'Chaveiro Ada Lovelace', 'colecionavel', 'Branco com estampa feito de pano', 1000, 50.00, '99999999999')
-- EXPOSITOR ('99999999999', 'Renner', 'vestuario')
-- EXPOSITOR ('44444444444', 'Colecionaveis show de bola', 'colecionaveis')
-- EXPOSITOR ('11111111111', 'Loja oficial do evento', 'souvenir');

select expositor.nome_exposicao
from expositor
where cpf in
	(select cpf
	from produto
	where preco > 100.00
	)
and cpf in
	(select cpf
	from produto
	group by cpf
	having sum(preco) > 250.00
	)
;

-- 7.b Retorne os nomes das exposições com produtos entre 50 e 150 reais e que não tem produtos mais caros do que 200 reais

select expositor.nome_exposicao
from expositor
where cpf in
	(select cpf
	from produto
	where preco between 50.00 and 150.00
	)
and cpf not in
	(select cpf
	from produto
	where preco > 199.99
	)
;