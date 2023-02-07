

entity vending_machinej_b_l_sc is
   port (
      ck         : in      bit;
      rst_n      : in      bit;
      water_soda : in      bit;
      vdd        : in      bit;
      vss        : in      bit;
      coin_in    : in      bit_vector(1 downto 0);
      coin_out   : out     bit_vector(1 downto 0);
      drink_out  : out     bit_vector(1 downto 0);
      scanin     : in      bit;
      test       : in      bit;
      scanout    : out     bit
 );
end vending_machinej_b_l_sc;

architecture structural of vending_machinej_b_l_sc is
Component inv_x4
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x2
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component ao22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a3_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a4_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component nxr2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component xr2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component nao22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o3_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component on12_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o2_x2
   port (
      i1  : in      bit;
      i0  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component oa22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component noa22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component sff2_x4
   port (
      ck  : in      bit;
      cmd : in      bit;
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component buf_x2
   port (
      i   : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

signal not_coin_in            : bit_vector( 1 downto 0);
signal not_vending_machine_cs : bit_vector( 2 downto 0);
signal vending_machine_cs     : bit_vector( 3 downto 0);
signal xr2_x1_sig             : bit;
signal xr2_x1_2_sig           : bit;
signal on12_x1_sig            : bit;
signal on12_x1_8_sig          : bit;
signal on12_x1_7_sig          : bit;
signal on12_x1_6_sig          : bit;
signal on12_x1_5_sig          : bit;
signal on12_x1_4_sig          : bit;
signal on12_x1_3_sig          : bit;
signal on12_x1_2_sig          : bit;
signal oa22_x2_sig            : bit;
signal oa22_x2_4_sig          : bit;
signal oa22_x2_3_sig          : bit;
signal oa22_x2_2_sig          : bit;
signal o3_x2_sig              : bit;
signal o3_x2_2_sig            : bit;
signal o2_x2_sig              : bit;
signal o2_x2_4_sig            : bit;
signal o2_x2_3_sig            : bit;
signal o2_x2_2_sig            : bit;
signal nxr2_x1_sig            : bit;
signal nxr2_x1_2_sig          : bit;
signal not_water_soda         : bit;
signal not_rst_n              : bit;
signal not_aux5               : bit;
signal not_aux4               : bit;
signal not_aux3               : bit;
signal noa22_x1_sig           : bit;
signal noa22_x1_6_sig         : bit;
signal noa22_x1_5_sig         : bit;
signal noa22_x1_4_sig         : bit;
signal noa22_x1_3_sig         : bit;
signal noa22_x1_2_sig         : bit;
signal no3_x1_sig             : bit;
signal no3_x1_3_sig           : bit;
signal no3_x1_2_sig           : bit;
signal no2_x1_sig             : bit;
signal no2_x1_2_sig           : bit;
signal nao22_x1_sig           : bit;
signal nao22_x1_2_sig         : bit;
signal na4_x1_sig             : bit;
signal na4_x1_2_sig           : bit;
signal na3_x1_sig             : bit;
signal na3_x1_2_sig           : bit;
signal na2_x1_sig             : bit;
signal na2_x1_3_sig           : bit;
signal na2_x1_2_sig           : bit;
signal aux9                   : bit;
signal aux8                   : bit;
signal aux7                   : bit;
signal aux6                   : bit;
signal aux10                  : bit;
signal aux1                   : bit;
signal a4_x2_sig              : bit;
signal a3_x2_sig              : bit;
signal a2_x2_sig              : bit;
signal a2_x2_2_sig            : bit;

begin

not_aux4_ins : a2_x2
   port map (
      i0  => vending_machine_cs(3),
      i1  => not_vending_machine_cs(1),
      q   => not_aux4,
      vdd => vdd,
      vss => vss
   );

not_aux3_ins : o3_x2
   port map (
      i0  => water_soda,
      i1  => vending_machine_cs(2),
      i2  => not_vending_machine_cs(1),
      q   => not_aux3,
      vdd => vdd,
      vss => vss
   );

not_vending_machine_cs_2_ins : inv_x2
   port map (
      i   => vending_machine_cs(2),
      nq  => not_vending_machine_cs(2),
      vdd => vdd,
      vss => vss
   );

not_vending_machine_cs_0_ins : inv_x2
   port map (
      i   => vending_machine_cs(0),
      nq  => not_vending_machine_cs(0),
      vdd => vdd,
      vss => vss
   );

not_aux5_ins : no2_x1
   port map (
      i0  => vending_machine_cs(3),
      i1  => vending_machine_cs(1),
      nq  => not_aux5,
      vdd => vdd,
      vss => vss
   );

not_vending_machine_cs_1_ins : inv_x4
   port map (
      i   => vending_machine_cs(1),
      nq  => not_vending_machine_cs(1),
      vdd => vdd,
      vss => vss
   );

not_rst_n_ins : inv_x2
   port map (
      i   => rst_n,
      nq  => not_rst_n,
      vdd => vdd,
      vss => vss
   );

not_water_soda_ins : inv_x2
   port map (
      i   => water_soda,
      nq  => not_water_soda,
      vdd => vdd,
      vss => vss
   );

not_coin_in_1_ins : inv_x2
   port map (
      i   => coin_in(1),
      nq  => not_coin_in(1),
      vdd => vdd,
      vss => vss
   );

not_coin_in_0_ins : inv_x2
   port map (
      i   => coin_in(0),
      nq  => not_coin_in(0),
      vdd => vdd,
      vss => vss
   );

aux10_ins : o2_x2
   port map (
      i1  => vending_machine_cs(2),
      i0  => water_soda,
      q   => aux10,
      vdd => vdd,
      vss => vss
   );

aux9_ins : o2_x2
   port map (
      i1  => vending_machine_cs(1),
      i0  => water_soda,
      q   => aux9,
      vdd => vdd,
      vss => vss
   );

aux8_ins : no2_x1
   port map (
      i0  => not_vending_machine_cs(0),
      i1  => not_aux3,
      nq  => aux8,
      vdd => vdd,
      vss => vss
   );

aux7_ins : o2_x2
   port map (
      i1  => vending_machine_cs(2),
      i0  => not_coin_in(1),
      q   => aux7,
      vdd => vdd,
      vss => vss
   );

aux6_ins : na2_x1
   port map (
      i0  => water_soda,
      i1  => vending_machine_cs(1),
      nq  => aux6,
      vdd => vdd,
      vss => vss
   );

aux1_ins : ao22_x2
   port map (
      i0  => vending_machine_cs(1),
      i1  => vending_machine_cs(2),
      i2  => water_soda,
      q   => aux1,
      vdd => vdd,
      vss => vss
   );

a3_x2_ins : a3_x2
   port map (
      i0  => vending_machine_cs(0),
      i1  => not_vending_machine_cs(2),
      i2  => aux6,
      q   => a3_x2_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_ins : o2_x2
   port map (
      i1  => vending_machine_cs(2),
      i0  => not_aux5,
      q   => o2_x2_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_2_ins : noa22_x1
   port map (
      i0  => o2_x2_sig,
      i1  => not_coin_in(1),
      i2  => vending_machine_cs(0),
      nq  => noa22_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

nao22_x1_ins : nao22_x1
   port map (
      i0  => noa22_x1_2_sig,
      i1  => a3_x2_sig,
      i2  => rst_n,
      nq  => nao22_x1_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_ins : na3_x1
   port map (
      i0  => not_water_soda,
      i1  => not_aux5,
      i2  => not_coin_in(1),
      nq  => na3_x1_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_3_ins : noa22_x1
   port map (
      i0  => vending_machine_cs(0),
      i1  => na3_x1_sig,
      i2  => coin_in(0),
      nq  => noa22_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_ins : on12_x1
   port map (
      i0  => aux7,
      i1  => vending_machine_cs(1),
      q   => on12_x1_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_2_ins : o2_x2
   port map (
      i1  => aux7,
      i0  => not_aux5,
      q   => o2_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_ins : oa22_x2
   port map (
      i0  => o2_x2_2_sig,
      i1  => on12_x1_sig,
      i2  => vending_machine_cs(0),
      q   => oa22_x2_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_ins : noa22_x1
   port map (
      i0  => oa22_x2_sig,
      i1  => noa22_x1_3_sig,
      i2  => nao22_x1_sig,
      nq  => noa22_x1_sig,
      vdd => vdd,
      vss => vss
   );

nxr2_x1_ins : nxr2_x1
   port map (
      i0  => vending_machine_cs(1),
      i1  => coin_in(1),
      nq  => nxr2_x1_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_2_ins : on12_x1
   port map (
      i0  => nxr2_x1_sig,
      i1  => not_coin_in(0),
      q   => on12_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_ins : na2_x1
   port map (
      i0  => not_aux5,
      i1  => not_vending_machine_cs(2),
      nq  => na2_x1_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_2_ins : oa22_x2
   port map (
      i0  => na2_x1_sig,
      i1  => vending_machine_cs(0),
      i2  => on12_x1_2_sig,
      q   => oa22_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_3_ins : on12_x1
   port map (
      i0  => not_coin_in(1),
      i1  => aux10,
      q   => on12_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_ins : na4_x1
   port map (
      i0  => not_vending_machine_cs(0),
      i1  => not_coin_in(0),
      i2  => vending_machine_cs(1),
      i3  => on12_x1_3_sig,
      nq  => na4_x1_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_4_ins : noa22_x1
   port map (
      i0  => na4_x1_sig,
      i1  => oa22_x2_2_sig,
      i2  => not_rst_n,
      nq  => noa22_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_2_ins : na2_x1
   port map (
      i0  => not_coin_in(1),
      i1  => vending_machine_cs(1),
      nq  => na2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

a4_x2_ins : a4_x2
   port map (
      i0  => not_vending_machine_cs(2),
      i1  => vending_machine_cs(3),
      i2  => na2_x1_2_sig,
      i3  => aux6,
      q   => a4_x2_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_ins : no2_x1
   port map (
      i0  => aux8,
      i1  => a4_x2_sig,
      nq  => no2_x1_sig,
      vdd => vdd,
      vss => vss
   );

xr2_x1_ins : xr2_x1
   port map (
      i0  => vending_machine_cs(1),
      i1  => coin_in(1),
      q   => xr2_x1_sig,
      vdd => vdd,
      vss => vss
   );

nxr2_x1_2_ins : nxr2_x1
   port map (
      i0  => xr2_x1_sig,
      i1  => vending_machine_cs(2),
      nq  => nxr2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_4_ins : on12_x1
   port map (
      i0  => nxr2_x1_2_sig,
      i1  => vending_machine_cs(0),
      q   => on12_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_3_ins : oa22_x2
   port map (
      i0  => no2_x1_sig,
      i1  => on12_x1_4_sig,
      i2  => not_coin_in(0),
      q   => oa22_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_6_ins : on12_x1
   port map (
      i0  => aux9,
      i1  => coin_in(1),
      q   => on12_x1_6_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_ins : no3_x1
   port map (
      i0  => on12_x1_6_sig,
      i1  => vending_machine_cs(0),
      i2  => not_vending_machine_cs(2),
      nq  => no3_x1_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_2_ins : no2_x1
   port map (
      i0  => coin_in(1),
      i1  => vending_machine_cs(3),
      nq  => no2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_2_ins : no3_x1
   port map (
      i0  => vending_machine_cs(1),
      i1  => no2_x1_2_sig,
      i2  => vending_machine_cs(2),
      nq  => no3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

o3_x2_ins : o3_x2
   port map (
      i0  => aux8,
      i1  => no3_x1_2_sig,
      i2  => no3_x1_sig,
      q   => o3_x2_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_5_ins : on12_x1
   port map (
      i0  => o3_x2_sig,
      i1  => coin_in(0),
      q   => on12_x1_5_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_5_ins : noa22_x1
   port map (
      i0  => on12_x1_5_sig,
      i1  => oa22_x2_3_sig,
      i2  => not_rst_n,
      nq  => noa22_x1_5_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_2_ins : na4_x1
   port map (
      i0  => coin_in(0),
      i1  => rst_n,
      i2  => coin_in(1),
      i3  => not_aux5,
      nq  => na4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_3_ins : no3_x1
   port map (
      i0  => not_vending_machine_cs(0),
      i1  => vending_machine_cs(2),
      i2  => na4_x1_2_sig,
      nq  => no3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

xr2_x1_2_ins : xr2_x1
   port map (
      i0  => vending_machine_cs(1),
      i1  => vending_machine_cs(2),
      q   => xr2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

a2_x2_ins : a2_x2
   port map (
      i0  => not_water_soda,
      i1  => not_vending_machine_cs(0),
      q   => a2_x2_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_3_ins : na2_x1
   port map (
      i0  => a2_x2_sig,
      i1  => xr2_x1_2_sig,
      nq  => na2_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_6_ins : noa22_x1
   port map (
      i0  => not_vending_machine_cs(2),
      i1  => vending_machine_cs(3),
      i2  => aux9,
      nq  => noa22_x1_6_sig,
      vdd => vdd,
      vss => vss
   );

nao22_x1_2_ins : nao22_x1
   port map (
      i0  => aux1,
      i1  => noa22_x1_6_sig,
      i2  => vending_machine_cs(0),
      nq  => nao22_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

drink_out_0_ins : noa22_x1
   port map (
      i0  => nao22_x1_2_sig,
      i1  => na2_x1_3_sig,
      i2  => not_rst_n,
      nq  => drink_out(0),
      vdd => vdd,
      vss => vss
   );

on12_x1_7_ins : on12_x1
   port map (
      i0  => aux1,
      i1  => not_rst_n,
      q   => on12_x1_7_sig,
      vdd => vdd,
      vss => vss
   );

drink_out_1_ins : no2_x1
   port map (
      i0  => not_vending_machine_cs(0),
      i1  => on12_x1_7_sig,
      nq  => drink_out(1),
      vdd => vdd,
      vss => vss
   );

o2_x2_3_ins : o2_x2
   port map (
      i1  => vending_machine_cs(0),
      i0  => not_aux3,
      q   => o2_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

o3_x2_2_ins : o3_x2
   port map (
      i0  => not_vending_machine_cs(0),
      i1  => vending_machine_cs(1),
      i2  => not_vending_machine_cs(2),
      q   => o3_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

coin_out_0_ins : noa22_x1
   port map (
      i0  => o3_x2_2_sig,
      i1  => o2_x2_3_sig,
      i2  => not_rst_n,
      nq  => coin_out(0),
      vdd => vdd,
      vss => vss
   );

a2_x2_2_ins : a2_x2
   port map (
      i0  => water_soda,
      i1  => not_aux4,
      q   => a2_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

on12_x1_8_ins : on12_x1
   port map (
      i0  => a2_x2_2_sig,
      i1  => vending_machine_cs(2),
      q   => on12_x1_8_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_2_ins : na3_x1
   port map (
      i0  => water_soda,
      i1  => vending_machine_cs(2),
      i2  => vending_machine_cs(1),
      nq  => na3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_4_ins : o2_x2
   port map (
      i1  => not_aux4,
      i0  => aux10,
      q   => o2_x2_4_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_4_ins : oa22_x2
   port map (
      i0  => o2_x2_4_sig,
      i1  => na3_x1_2_sig,
      i2  => not_vending_machine_cs(0),
      q   => oa22_x2_4_sig,
      vdd => vdd,
      vss => vss
   );

coin_out_1_ins : noa22_x1
   port map (
      i0  => oa22_x2_4_sig,
      i1  => on12_x1_8_sig,
      i2  => not_rst_n,
      nq  => coin_out(1),
      vdd => vdd,
      vss => vss
   );

vending_machine_cs_0_ins_scan_0 : sff2_x4
   port map (
      ck  => ck,
      cmd => test,
      i0  => noa22_x1_sig,
      i1  => scanin,
      q   => vending_machine_cs(0),
      vdd => vdd,
      vss => vss
   );

vending_machine_cs_1_ins_scan_1 : sff2_x4
   port map (
      ck  => ck,
      cmd => test,
      i0  => noa22_x1_4_sig,
      i1  => vending_machine_cs(0),
      q   => vending_machine_cs(1),
      vdd => vdd,
      vss => vss
   );

vending_machine_cs_2_ins_scan_2 : sff2_x4
   port map (
      ck  => ck,
      cmd => test,
      i0  => noa22_x1_5_sig,
      i1  => vending_machine_cs(1),
      q   => vending_machine_cs(2),
      vdd => vdd,
      vss => vss
   );

vending_machine_cs_3_ins_scan_3 : sff2_x4
   port map (
      ck  => ck,
      cmd => test,
      i0  => no3_x1_3_sig,
      i1  => vending_machine_cs(2),
      q   => vending_machine_cs(3),
      vdd => vdd,
      vss => vss
   );

buf_scan_4 : buf_x2
   port map (
      i   => vending_machine_cs(3),
      q   => scanout,
      vdd => vdd,
      vss => vss
   );


end structural;
