-- CREATE DATABASE hotelNebula;
USE hotelNebula;
CREATE TABLE hospede( 
	id_hospede INT AUTO_INCREMENT PRIMARY KEY,  
	nome_hospede VARCHAR(80),
	cpf_hospede VARCHAR(14),  
	telefone_hospede VARCHAR(14),  
	email_hospede VARCHAR(120),  
	data_nascimento DATE  
); 

CREATE TABLE funcionario( 
	id_funcionario INT AUTO_INCREMENT PRIMARY KEY,  
	nome_funcionario VARCHAR(80),  
	cargo VARCHAR(20),  
	salario DOUBLE,  
	telefone_funcionario VARCHAR(14),  
	email_funcionario VARCHAR(120)  
);

CREATE TABLE quarto( 
	id_quarto INT AUTO_INCREMENT PRIMARY KEY,  
	numero VARCHAR(14),  
	andar INT,  
	status_quarto VARCHAR(15),  
	valor_diaria double,  
	tipo_quarto VARCHAR(15)  
); 

CREATE TABLE reserva( 
	id_reserva INT AUTO_INCREMENT PRIMARY KEY,  
	id_hospede INT,  
	id_funcionario INT,  
	data_reserva DATE,  
	data_entrada DATE,  
	data_saida DATE,  
	status_reserva VARCHAR(15),  
	
	CONSTRAINT fk_reserva_hospede 
		FOREIGN KEY(id_hospede)
		REFERENCES hospede(id_hospede),
		
	CONSTRAINT fk_reserva_funcionario 
		FOREIGN KEY(id_funcionario)
		REFERENCES funcionario(id_funcionario)
); 

CREATE TABLE hospedagem( 
	id_hospedagem INT AUTO_INCREMENT PRIMARY KEY,  
	id_reserva INT,  
	id_funcionario INT,  
	id_hospede INT,  
	check_in DATE,  
	check_out DATE,  
	qntd_hospedes INT,  
	
	CONSTRAINT fk_hospedagem_reserva 
		FOREIGN KEY (id_reserva)
		REFERENCES reserva(id_reserva),
	
	CONSTRAINT fk_hospedagem_funcionario
		FOREIGN KEY (id_funcionario)
		REFERENCES funcionario(id_funcionario),
	
	CONSTRAINT fk_hospedagem_hospede
		FOREIGN KEY (id_hospede)
		REFERENCES hospede(id_hospede)	
); 

CREATE TABLE pagamento( 
	id_pagamento INT AUTO_INCREMENT PRIMARY KEY,  
	id_hospedagem INT,  
	data_pagamento DATE,  
	forma_pagamento VARCHAR(10),  
	hora_pagamento TIME,  
	valor DOUBLE,
	
	CONSTRAINT fk_pagamento_hospedagem
		FOREIGN KEY (id_hospedagem)
		REFERENCES hospedagem(id_hospedagem)
); 

CREATE TABLE avaliacao( 
	id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,  
	id_hospedagem INT,  
	id_hospede INT,  
	comentario VARCHAR(500),  
	nota INT,  
	data_avaliacao DATETIME,  
	
	CONSTRAINT fk_avaliacao_hospedagem
		FOREIGN KEY (id_hospedagem)
		REFERENCES hospedagem(id_hospedagem),
	
	CONSTRAINT fk_avaliacao_hospede
		FOREIGN KEY (id_hospede)
		REFERENCES hospede(id_hospede)
); 

CREATE TABLE hospedagemQuarto( 
	id_hospedagem INT,  
	id_quarto INT,  
	
	PRIMARY KEY(id_hospedagem, id_quarto),
	
	CONSTRAINT fk_hospedagem_quarto
		FOREIGN KEY (id_hospedagem)
		REFERENCES hospedagem(id_hospedagem),

	CONSTRAINT fk_quarto_hospedagem
		FOREIGN KEY (id_quarto)
		REFERENCES quarto(id_quarto)
); 

CREATE TABLE funcionarioLimpeza ( 
	id_funcionario INT,  
	id_quarto INT,
	
	PRIMARY KEY(id_funcionario, id_quarto),  

	CONSTRAINT fk_funcionario_quarto
		FOREIGN KEY (id_funcionario)
		REFERENCES funcionario(id_funcionario),
	
	CONSTRAINT fk_quarto_funcionario
		FOREIGN KEY (id_quarto)
		REFERENCES quarto(id_quarto)
); 



-- INSERÇÃO DE DADOS
INSERT INTO hospede(nome_hospede, email_hospede, telefone_hospede, cpf_hospede, data_nascimento)
VALUES
('Guilherme Brito', 'guizikatopdaora@gmail.com', '(11)99999-1111', '111.111.111-11', '1995-03-12'),
('Gabirel Augustos', 'guizikameumelhoraluno@gmail.com', '(11)98888-2222', '222.222.222-22', '1605-07-25'),
('Josielma silva', 'josima@gmail.com', '(11)97777-3333', '333.333.333-33', '1992-11-08'),
('Ricardo Alves', 'ricardoproa@gmail.com', '(11)96666-4444', '444.444.444-44', '1989-01-15'),
('Marcos Pontes', 'antoniofagundes@gmail.com', '(11)95555-5555', '555.555.555-55', '2000-05-19');

INSERT INTO funcionario(nome_funcionario, cargo, salario, telefone_funcionario, email_funcionario)
VALUES
('João Mendes', 'Administração', 2500.00, '(11)94444-1111', 'joao@hotel.com'),
('Ana Costa', 'Limpeza', 6500.00, '(11)93333-2222', 'ana@hotel.com'),
('Paulo Henrique', 'Limpeza', 2200.00, '(11)92222-3333', 'paulo@hotel.com'),
('Larissa Martins', 'Administração', 2700.00, '(11)91111-4444', 'larissa@hotel.com'),
('Felipe Gomes', 'Limpeza', 3000.00, '(11)90000-5555', 'felipe@hotel.com');

INSERT INTO quarto(numero, andar, status_quarto, valor_diaria, tipo_quarto)
VALUES
('101', 1, 'Disponível', 180.00, 'Executivo'),
('102', 1, 'Disponível', 200.00, 'Executivo'),
('201', 2, 'Ocupado', 320.00, 'Luxo'),
('301', 3, 'Reservado', 500.00, 'Suíte'),
('401', 4, 'Ocupado', 450.00, 'Luxo');

INSERT INTO reserva(id_hospede, id_funcionario, data_reserva, data_entrada, data_saida, status_reserva)
VALUES
(1, 1, '2026-05-01', '2026-05-10', '2026-05-15', 'Confirmada'),
(2, 4, '2026-05-03', '2026-05-12', '2026-05-14', 'Confirmada'),
(3, 4, '2026-05-05', '2026-05-20', '2026-05-25', 'Pendente'),
(4, 1, '2026-05-06', '2026-05-18', '2026-05-22', 'Cancelada'),
(5, 4, '2026-05-08', '2026-05-28', '2026-06-02', 'Confirmada');

INSERT INTO hospedagem(id_reserva, id_funcionario, id_hospede, check_in, check_out, qntd_hospedes)
VALUES
(1, 1, 1, '2026-05-10', '2026-05-15', 2),
(2, 4, 2, '2026-05-12', '2026-05-14', 1),
(3, 1, 3, '2026-05-20', '2026-05-25', 3),
(5, 4, 5, '2026-05-28', '2026-06-02', 2);

INSERT INTO pagamento(id_hospedagem, data_pagamento, forma_pagamento, hora_pagamento, valor)
VALUES
(1, '2026-05-10', 'Cartão', '14:30:00', 1750.00),
(2, '2026-05-12', 'PIX', '12:15:00', 440.00),
(3, '2026-05-20', 'Dinheiro', '16:45:00', 2500.00),
(4, '2026-05-28', 'Débito', '18:20:00', 1800.00);

INSERT INTO avaliacao(id_hospedagem, id_hospede, comentario, nota, data_avaliacao)
VALUES
(1, 1, 'Eu sou zika, e o quarto estava à altura da minha zikeza.', 5, '2026-05-16 10:30:00'),
(2, 2, 'Prefiro o hotel Gui Top.', 1, '2026-05-15 09:00:00'),
(3, 3, 'Hotel muito limpo e organizado.', 5, '2026-05-26 14:20:00'),
(4, 5, 'Atendimento razoável.', 3, '2026-06-03 11:15:00');

INSERT INTO hospedagemQuarto(id_hospedagem, id_quarto)
VALUES
(1, 3),
(2, 1),
(3, 4),
(4, 2);

INSERT INTO funcionarioLimpeza(id_funcionario, id_quarto)
VALUES
(2, 1),
(3, 2),
(3, 3),
(4, 4),
(2, 5);



-- Mostrando informações completas das hospedagens confirmadas
SELECT 
	h.nome_hospede,
	h.telefone_hospede,
	f.nome_funcionario,
	hp.check_in,
	hp.check_out,
	r.status_reserva,
	q.numero,
	q.tipo_quarto
FROM hospedagem AS hp
INNER JOIN hospede AS h
	ON hp.id_hospede = h.id_hospede
INNER JOIN funcionario AS f
	ON hp.id_funcionario = f.id_funcionario
INNER JOIN reserva AS r
	ON hp.id_reserva = r.id_reserva
INNER JOIN hospedagemQuarto AS hq
	ON hp.id_hospedagem = hq.id_hospedagem
INNER JOIN quarto AS q
	ON hq.id_quarto = q.id_quarto
WHERE r.status_reserva = "Confirmada";

-- Mostrando os quartos que já receberam nota 5
SELECT 
	q.numero,
	q.andar,
	q.tipo_quarto
FROM hospedagem AS hp
INNER JOIN hospedagemQuarto AS hq
	ON hp.id_hospedagem = hq.id_hospedagem
INNER JOIN quarto AS q
	ON hq.id_quarto = q.id_quarto
INNER JOIN avaliacao AS a
	ON hp.id_hospedagem = a.id_hospedagem
WHERE a.nota = 5
GROUP BY q.numero;

DESCRIBE funcionario;
DESCRIBE hospede;
DESCRIBE hospedagem;
DESCRIBE reserva;

-- Mostrando quais funcionários são responsáveis pela administração da reserva de quais hóspedes
SELECT
	f.nome_funcionario,
	h.nome_hospede,
	r.status_reserva
FROM reserva AS r
INNER JOIN funcionario AS f
	ON r.id_funcionario = f.id_funcionario
INNER JOIN hospede AS h
	ON r.id_hospede = h.id_hospede;
	
-- Mostrando quantos hóspedes cada funcionário atendeu
SELECT 
   f.nome_funcionario,
   COUNT(hp.id_hospedagem) AS total_hospedagens
FROM funcionario AS f
INNER JOIN hospedagem AS hp
   ON f.id_funcionario = hp.id_funcionario
GROUP BY f.id_funcionario, f.nome_funcionario;

-- Mostrando quantos hóspedes já passaram pelo hotel
SELECT COUNT(DISTINCT id_hospede) FROM hospedagem;