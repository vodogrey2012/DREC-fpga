	component unnamed is
		port (
			noe_in : in std_logic := 'X'  -- noe
		);
	end component unnamed;

	u0 : component unnamed
		port map (
			noe_in => CONNECTED_TO_noe_in  -- noe_in.noe
		);

