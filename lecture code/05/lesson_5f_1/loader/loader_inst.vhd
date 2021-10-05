	component loader is
		port (
			noe_in : in std_logic := 'X'  -- noe
		);
	end component loader;

	u0 : component loader
		port map (
			noe_in => CONNECTED_TO_noe_in  -- noe_in.noe
		);

