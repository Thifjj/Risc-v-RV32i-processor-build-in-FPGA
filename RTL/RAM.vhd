LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- ESTA LINHA É OBRIGATÓRIA
USE ieee.numeric_std.all;

ENTITY RAM IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		byteena		: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
		clken		: IN STD_LOGIC := '1';
		clock		: IN STD_LOGIC := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN STD_LOGIC := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM;


ARCHITECTURE BEHAVIORAL OF ram IS

	-- 1. Definimos o tipo da nossa memória
	type ram_type is array (0 to 511) of std_logic_vector(31 downto 0);
	
    -- 2. Criamos o sinal de memória
	signal mem : ram_type := (others => (others => '0'));
    
    -- 3. Criamos um SINAL para o endereço (em vez de uma variável)
    signal internal_address : integer range 0 to 511;

BEGIN

    -- 4. Convertemos o endereço UMA VEZ, fora do processo.
    --    Isso é uma atribuição "concorrente".
    internal_address <= to_integer(unsigned(address));

	-- 5. Processo de ESCRITA (Síncrona)
	write_process : process(clock)
    -- NENHUMA variável declarada aqui
	begin
		if rising_edge(clock) then
			if clken = '1' then
				if wren = '1' then
                    -- Agora nós APENAS USAMOS o sinal 'internal_address'
                    -- A declaração da variável FOI REMOVIDA.
					if byteena(3) = '1' then
						mem(internal_address)(31 downto 24) <= data(31 downto 24);
					end if;
					if byteena(2) = '1' then
						mem(internal_address)(23 downto 16) <= data(23 downto 16);
					end if;
					if byteena(1) = '1' then
						mem(internal_address)(15 downto 8) <= data(15 downto 8);
					end if;
					if byteena(0) = '1' then
						mem(internal_address)(7 downto 0) <= data(7 downto 0);
					end if;
				end if;
			end if;
		end if;
	end process;
	
	-- 6. Processo de LEITURA (Combinacional)
    -- Usamos o mesmo sinal 'internal_address'
	q <= mem(internal_address);

END BEHAVIORAL;