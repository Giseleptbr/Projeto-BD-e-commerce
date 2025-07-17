# Projeto-BD-e-commerce
Este projeto consiste na modelagem e implementação de um banco de dados relacional para um cenário de e-commerce, com base em um modelo lógico refinado. O objetivo é representar as entidades envolvidas, seus relacionamentos, e realizar testes com persistência de dados e consultas SQL mais avançadas.
O modelo contempla:

- Clientes Pessoa Física e Jurídica
- Pedidos e formas de pagamento
- Vendedores e fornecedores
- Produtos com classificação e avaliações
- Estoques e localizações de armazenamento
- Relacionamentos complexos (N:N com tabelas associativas)

---

## Estrutura do Banco de Dados

As principais tabelas implementadas foram:

- `clients` – Informações de clientes PF ou PJ
- `orders` – Pedidos realizados
- `product` – Produtos vendidos na plataforma
- `seller` – Vendedores da plataforma
- `supplier` – Fornecedores de produtos
- `productOrder` – Relação N:N entre pedidos e produtos
- `productSeller` – Relação N:N entre vendedores e produtos
- `productSupplier` – Relação N:N entre fornecedores e produtos
- `productStorage` – Estoque de produtos por localização
- `storageLocation` – Associação entre produtos e locais de armazenamento

---

## Refinamentos Implementados

- **Clientes PF e PJ:** restrição para que um cliente seja apenas PF ou PJ.
- **Pedidos com múltiplas formas de pagamento** (exemplo para ser expandido).
- **Entrega com status e código de rastreio** (coluna `poStatus` e exemplo na `productOrder`).
- **Relacionamentos complexos** (tabelas associativas com PK composta e constraints de integridade).
