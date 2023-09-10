-- Tabela Cliente
CREATE TABLE Cliente (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    CPF_CNPJ VARCHAR(20),
    Tipo VARCHAR(2)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    ID INT PRIMARY KEY,
    DataPedido DATE,
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

-- Tabela Produto
CREATE TABLE Produto (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Preco DECIMAL(10, 2),
    Estoque INT
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    ID INT PRIMARY KEY,
    Tipo VARCHAR(255),
    Pedido_ID INT,
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    ID INT PRIMARY KEY,
    Status VARCHAR(255),
    CodigoRastreio VARCHAR(255),
    Pedido_ID INT,
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID)
);

-- Tabela Pedido_Produto (para representar a relação N:M entre Pedido e Produto)
CREATE TABLE Pedido_Produto (
    Pedido_ID INT,
    Produto_ID INT,
    Quantidade INT,
    PRIMARY KEY (Pedido_ID, Produto_ID),
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID),
    FOREIGN KEY (Produto_ID) REFERENCES Produto(ID)
);

-- Tabela Fornecedor_Produto (para representar a relação N:M entre Fornecedor e Produto)
CREATE TABLE Fornecedor_Produto (
    Fornecedor_ID INT,
    Produto_ID INT,
    PRIMARY KEY (Fornecedor_ID, Produto_ID),
    FOREIGN KEY (Fornecedor_ID) REFERENCES Fornecedor(ID),
    FOREIGN KEY (Produto_ID) REFERENCES Produto(ID)
);

 -- pedidos cada cliente
SELECT Cliente.Nome, COUNT(Pedido.ID) AS TotalPedidos
FROM Cliente
LEFT JOIN Pedido ON Cliente.ID = Pedido.Cliente_ID
GROUP BY Cliente.Nome;

-- fornecedor cliente
SELECT DISTINCT Cliente.Nome AS VendedorFornecedor
FROM Cliente
INNER JOIN Fornecedor ON Cliente.Nome = Fornecedor.Nome
WHERE Cliente.Tipo = 'PJ';

-- produtos fornecedores e estoques
SELECT Produto.Nome, Fornecedor.Nome AS NomeFornecedor, Produto.Estoque
FROM Produto
INNER JOIN Fornecedor_Produto ON Produto.ID = Fornecedor_Produto.Produto_ID
INNER JOIN Fornecedor ON Fornecedor_Produto.Fornecedor_ID = Fornecedor.ID;

-- fornecedor nome

SELECT Fornecedor.Nome AS NomeFornecedor, Produto.Nome AS NomeProduto
FROM Fornecedor
INNER JOIN Fornecedor_Produto ON Fornecedor.ID = Fornecedor_Produto.Fornecedor_ID
INNER JOIN Produto ON Fornecedor_Produto.Produto_ID = Produto.ID;


