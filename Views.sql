views 

/*64. Crie uma View contendo os códigos e os nomes dos clientes que moram nos estados de SP ou
RJ ou MS.*/
CREATE or replace VIEW ex64 AS
 SELECT codigo_cliente, nome_cliente, uf
 FROM cliente
 WHERE uf = 'SP' OR uf = 'RJ' OR uf = 'MS';

 select * from ex64
 
/*65. Crie uma View que selecione todos os números dos pedidos, códigos dos clientes e os prazos de
entrega dos vendedores que tenham o nome ‘Carlos’.*/
 
 create view ex65 as
 select pd.num_pedido,pd.codigo_cliente, pd.prazo_entrega from pedido as pd left join vendedor as vd
 on vd.codigo_vendedor = pd.codigo_vendedor where vd.nome_vendedor = 'Carlos';
 
 select * from ex65
 
/*66. Faça uma View que contenha o número do pedido, código e descrição do produto, quantidade ,
val_unit e o subtotal (quantidade * val_unit).*/
 
 create view ex66 as 
 select pd.num_pedido, prd.codigo_produto,prd.val_unit, prd.descricao_produto, idp.quantidade, round((idp.quantidade * prd.val_unit),2) as subtotal from pedido as pd
 left join item_do_pedido as idp 
 on idp.num_pedido = pd.num_pedido left join produto as prd 
 on prd.codigo_produto = idp.codigo_produto 
 
 select * from ex66
 
 /*67. Tendo referencia ao exercício anterior, crie uma visualização que mostre a soma total de cada
pedido.*/
  
  CREATE VIEW ex67 AS
  SELECT num_pedido, 
  SUM(subtotal) AS TotalPedido
  FROM ex66
  GROUP BY num_pedido;
  
  select * from ex67
  
 /*68. Em relação ao exercício anterior desenvolva uma visualização que contenha o Número do
Pedido, Código, o Nome e o salário fixo do Vendedor e o Total.*/

  create view ex68 as
  select pd.num_pedido, vd.codigo_vendedor, vd.nome_vendedor, vd.salario_fixo, ex.TotalPedido from pedido as pd 
  inner join vendedor as vd 
  on vd.codigo_vendedor = pd.codigo_vendedor inner join ex67 as ex 
  on pd.num_pedido = ex.num_pedido
  
  select * from ex68
  
 /*69. De acordo com a visualização anterior crie outra visualização que mostre o total vendido por
cada vendedor.*/
  create view ex69 as
  select codigo_vendedor, nome_vendedor, sum(TotalPedido) as TotalVendas from ex68 
  group by codigo_vendedor, nome_vendedor;
  
  select * from ex69
  
  /*70. Com base na visualização anterior crie uma consulta que mostre o nome do vendedor, o Salário
Fixo, Salário Total que é a soma Salário fixo + 5% do total de produto vendidos {Salário
Fixo+(Total*0.05)} . Obs: elimine as linhas duplicadas.*/

  create view ex70 as
  select DISTINCT vd.nome_vendedor, vd.salario_fixo, vd.salario_fixo+(ex.TotalVendas*0.05) as salario_total from vendedor as vd inner join ex69 as ex 
  on ex.codigo_vendedor = vd.codigo_vendedor
  
  select * from ex70
  
 /*71. Tendo como referência uma das views criadas anteriormente, mostre a média do total dos
pedidos que o vendedor ‘José’ participou.*/
 
 create or replace view ex71 as
 select round(avg(totalpedido),3)as media from ex68  where nome_vendedor = 'José'
 select * from ex71
  
 /*72. Mostre os códigos e descrições dos produtos e a soma da quantidade pedida agrupado pelo
código e descrição do produto.*/
  create or replace view ex72 as
  select codigo_produto, descricao_produto, sum(quantidade) as soma from ex66 GROUP BY codigo_produto, descricao_produto;

  select * from ex72