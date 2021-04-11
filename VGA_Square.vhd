library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;  

entity vga_square is
  port ( CLK_50MHz		: in std_logic;
			RESET				: in std_logic;
			key_air        : in unsigned(3 downto 0)  ;
			LED_R				: out unsigned(9 downto 0) ;
			SW_R			   : in unsigned(9 downto 0)  ;
			Seg_0          : out unsigned(6 downto 0) ;
			Seg_1          : out unsigned(6 downto 0) ;
			Seg_2          : out unsigned(6 downto 0) ;
			Seg_3          : out unsigned(6 downto 0) ;
			Seg_4          : out unsigned(6 downto 0) ;
			Seg_5          : out unsigned(6 downto 0) ;
			ColorOut			: out unsigned(11 downto 0); -- RED & GREEN & BLUE
			SQUAREWIDTH		: in unsigned(7 downto 0);
			ScanlineX		: in unsigned(10 downto 0);
			ScanlineY		: in unsigned(10 downto 0)
  );
end vga_square;

architecture Behavioral of vga_square is
  
signal pseudo_rand : unsigned (31 downto 0);
signal pseudo_rand_1 : unsigned (31 downto 0);
signal output_ran_x  : unsigned (10  downto 0); 
signal output_ran_x_width : unsigned(1 downto 0);
signal output_ran_y : unsigned(8 downto 0) ;
signal output_ran_x_1  : unsigned (10  downto 0); 
signal output_ran_x_width_1 : unsigned(1 downto 0);
signal output_ran_y_1 : unsigned(8 downto 0) ;
signal output_ran_x_2  : unsigned (10  downto 0); 
signal output_ran_x_width_2 : unsigned(1 downto 0);
signal output_ran_y_2 : unsigned(8 downto 0) ;

signal ColorOutput: unsigned(11 downto 0);
signal Time_Game : unsigned(32 downto 0) ;
signal Time_Game_Int : unsigned(32 downto 0) ;
signal Time_Game_Yekan : unsigned(32 downto 0) ;
signal Time_Game_Dahgan : unsigned(32 downto 0) ;
signal ColorSelect: unsigned(2 downto 0) ;

signal Prescaler: unsigned(30 downto 0) := (others => '0');
signal Prescaler1: unsigned(30 downto 0) := (others => '0');
signal prescaler2: unsigned(30 downto 0) := (others => '0');
signal Prescaler3: unsigned(26 downto 0) := (others => '0');
signal Prescaler4: unsigned(30 downto 0) := (others => '0');
signal Prescaler5: unsigned(26 downto 0) := (others => '0');
signal Prescaler6: unsigned(30 downto 0) := (others => '0');
signal Prescaler7: unsigned(26 downto 0) := (others => '0');
signal Prescaler8: unsigned(30 downto 0) := (others => '0');
signal Prescaler9: unsigned(27 downto 0) := (others => '0');
signal Prescaler10: unsigned(30 downto 0) := (others => '0');
signal prescaler11: unsigned(30 downto 0) := (others => '0');
signal prescaler14: unsigned(30 downto 0) := (others => '0');

signal speed: unsigned(30 downto 0) := (others => '0');

signal Start : std_logic ;
signal start1: std_logic ;
signal start2: unsigned(2 downto 0) ;
signal start3: std_logic ;
signal start4: std_logic ;
signal start5: std_logic ;
signal start6: std_logic ;
signal start7: std_logic ;
signal start8: std_logic ;
signal start9: std_logic ;
signal start10: std_logic ;
signal start11: std_logic ;
signal start12: std_logic ;
signal start13: std_logic ;
signal start14: std_logic ;
signal start15: std_logic ;
signal start16: std_logic ;
signal start17: std_logic ;
signal start18: std_logic ;
signal start19: std_logic ;
signal start20: std_logic ;
signal start21: std_logic ;
signal start22: std_logic ;
signal start23: std_logic ;
signal start24: std_logic ;
signal start25: std_logic ;
signal start26: std_logic ;
signal start27: std_logic;
signal start28: std_logic;
signal start29: std_logic;
signal start30: std_logic;
signal start27_1: std_logic;
signal start28_1: std_logic;
signal start29_1: std_logic;
signal start30_1: std_logic;
signal start_T_1: std_logic ;
signal start_T_2: std_logic ;
signal start_T_3: std_logic ;
signal start_T_4: std_logic ;
signal start_T: std_logic ;
signal start_T_5: std_logic ;
signal start_T_6: std_logic ;
signal start_T_7: std_logic ;

signal auto : std_logic ;
signal auto1 : std_logic ;
signal auto2 : std_logic ;
signal auto3 : std_logic ;
signal auto4 : std_logic ;
signal auto5 : std_logic ;
signal auto6 : std_logic ;

signal hit : std_logic ;
signal tir_x: unsigned(10 downto 0) ;
signal tir_y: unsigned(8 downto 0) ;

signal FinishPrime : std_logic;
signal finish : std_logic ;
signal finish_1 : std_logic ;
signal finish_2 : std_logic ;

signal score : unsigned (6 downto 0) ;
signal score_yekan : unsigned (6 downto 0) ;
signal score_dahgan : unsigned (6 downto 0) ;

signal x_limit_end_water: unsigned(10 downto 0) ;  
signal x_limit_first_water: unsigned(10 downto 0) ;

signal AirplaneXPos : unsigned(10 downto 0);            
signal AirplaneYPos : unsigned(8 downto 0);           
signal AirPlane_width : unsigned(8 downto 0);           


signal length_seperate_begin : unsigned(10 downto 0);
signal length_seperate_end : unsigned(10 downto 0) ;
signal barrier_y_end : unsigned(10 downto 0) ;
signal barrier_y_first : unsigned(10 downto 0) ;
signal width_of_barrier : unsigned(10 downto 0);
signal width_of_barrier_1 : unsigned(10 downto 0);
signal width_of_barrier_2 : unsigned(10 downto 0);
signal side_of_barrier : unsigned(10 downto 0);
signal length_between_length_seperate: unsigned(10 downto 0) ;

signal ghif_L_x_s : unsigned (10 downto 0);
signal ghif_L_x_s_1 : unsigned (10 downto 0);
signal ghif_L_x_s_2 : unsigned (10 downto 0);
signal ghif_L_x_s_3 : unsigned (10 downto 0);
signal ghif_L_x_s_4 : unsigned (10 downto 0);
signal ghif_L_x_s_5 : unsigned (10 downto 0);
signal ghif_L_x_s_6 : unsigned (10 downto 0);
signal ghif_L_x_s_7 : unsigned (10 downto 0);
signal ghif_L_x_s_8 : unsigned (10 downto 0);
signal ghif_L_x_s_9 : unsigned (10 downto 0);
signal ghif_L_x_s_10 : unsigned (10 downto 0);
signal ghif_L_x_s_11 : unsigned (10 downto 0);
signal ghif_L_x_s_12 : unsigned (10 downto 0);
signal ghif_L_x_s_13 : unsigned (10 downto 0);
signal ghif_L_x_s_14 : unsigned (10 downto 0);
signal ghif_L_x_s_15 : unsigned (10 downto 0);
signal ghif_L_x_s_16 : unsigned (10 downto 0);
signal ghif_L_x_s_17 : unsigned (10 downto 0);
signal ghif_L_x_s_18 : unsigned (10 downto 0);
signal ghif_L_x_s_19 : unsigned (10 downto 0);
signal ghif_L_x_s_20 : unsigned (10 downto 0);
signal ghif_L_x_s_21 : unsigned (10 downto 0);
signal ghif_L_x_s_22 : unsigned (10 downto 0);

signal ghif_L_Y_s : unsigned (10 downto 0);
signal ghif_l_y_s_1 : unsigned (10 downto 0);
signal ghif_l_y_s_2 : unsigned (10 downto 0);
signal ghif_l_y_s_3 : unsigned (10 downto 0);
signal ghif_l_y_s_4 : unsigned (10 downto 0);
signal ghif_l_y_s_5 : unsigned (10 downto 0);
signal ghif_l_y_s_6 : unsigned (10 downto 0);
signal ghif_l_y_s_7 : unsigned (10 downto 0);
signal ghif_l_y_s_8 : unsigned (10 downto 0);
signal ghif_l_y_s_9 : unsigned (10 downto 0);
signal ghif_l_y_s_10 : unsigned (10 downto 0);
signal ghif_l_y_s_11 : unsigned (10 downto 0);
signal ghif_l_y_s_12 : unsigned (10 downto 0);
signal ghif_l_y_s_13 : unsigned (10 downto 0);
signal ghif_l_y_s_14 : unsigned (10 downto 0);
signal ghif_l_y_s_15 : unsigned (10 downto 0);
signal ghif_l_y_s_16 : unsigned (10 downto 0);
signal ghif_l_y_s_17 : unsigned (10 downto 0);
signal ghif_l_y_s_18 : unsigned (10 downto 0);
signal ghif_l_y_s_19 : unsigned (10 downto 0);
signal ghif_l_y_s_20 : unsigned (10 downto 0);
signal ghif_l_y_s_21 : unsigned (10 downto 0);
signal ghif_l_y_s_22 : unsigned (10 downto 0);

signal ghif_r_x_s : unsigned (10 downto 0);
signal ghif_r_x_s_1 : unsigned (10 downto 0);
signal ghif_r_x_s_2 : unsigned (10 downto 0);
signal ghif_r_x_s_3 : unsigned (10 downto 0);
signal ghif_r_x_s_4 : unsigned (10 downto 0);
signal ghif_r_x_s_5 : unsigned (10 downto 0);
signal ghif_r_x_s_6 : unsigned (10 downto 0);
signal ghif_r_x_s_7 : unsigned (10 downto 0);
signal ghif_r_x_s_8 : unsigned (10 downto 0);
signal ghif_r_x_s_9 : unsigned (10 downto 0);
signal ghif_r_x_s_10 : unsigned (10 downto 0);
signal ghif_r_x_s_11 : unsigned (10 downto 0);
signal ghif_r_x_s_12 : unsigned (10 downto 0);
signal ghif_r_x_s_13 : unsigned (10 downto 0);
signal ghif_r_x_s_14 : unsigned (10 downto 0);
signal ghif_r_x_s_15 : unsigned (10 downto 0);
signal ghif_r_x_s_16 : unsigned (10 downto 0);
signal ghif_r_x_s_17 : unsigned (10 downto 0);
signal ghif_r_x_s_18 : unsigned (10 downto 0);
signal ghif_r_x_s_19 : unsigned (10 downto 0);
signal ghif_r_x_s_20 : unsigned (10 downto 0);
signal ghif_r_x_s_21 : unsigned (10 downto 0);
signal ghif_r_x_s_22 : unsigned (10 downto 0);

signal ghif_L_width_s_x : unsigned (10 downto 0);

signal length_seperate : unsigned (3 downto 0) ;
signal barrier_x : unsigned (10 downto 0) ;
signal barrier_y : unsigned (8 downto 0) ;
signal barrier_width : unsigned(10 downto 0) ;
signal barrier_x_width: unsigned(1 downto 0) ;

signal length_seperate_1 : unsigned (3 downto 0) ;
signal barrier_x_1 : unsigned (10 downto 0) ;
signal barrier_y_1 : unsigned (8 downto 0) ;
signal barrier_width_1 : unsigned(10 downto 0) ;
signal barrier_x_width_1: unsigned(1 downto 0) ;

signal length_seperate_2 : unsigned (3 downto 0) ;
signal barrier_x_2 : unsigned (10 downto 0) ;
signal barrier_y_2 : unsigned (8 downto 0) ;
signal barrier_width_2 : unsigned(10 downto 0) ;
signal barrier_x_width_2: unsigned(1 downto 0) ;

signal length_seperate_3 : unsigned (3 downto 0) ;
signal barrier_x_3 : unsigned (10 downto 0) ;
signal barrier_y_3 : unsigned (8 downto 0) ;
signal barrier_width_3 : unsigned(10 downto 0) ;
signal barrier_x_width_3: unsigned(1 downto 0) ;
------------------------------------------------------------------------
------------------------------------------------------------------------
function convSEG (N : unsigned(3 downto 0)) return unsigned is
		variable ans:unsigned(6 downto 0);
begin
	Case N is
		when "0000" => ans:="1000000";	 
		when "0001" => ans:="1111001";
		when "0010" => ans:="0100100";
		when "0011" => ans:="0110000";
		when "0100" => ans:="0011001";
		when "0101" => ans:="0010010";
		when "0110" => ans:="0000010";
		when "0111" => ans:="1111000";
		when "1000" => ans:="0000000";
		when "1001" => ans:="0010000";	   
		when "1010" => ans:="0001000";
		when "1011" => ans:="0000011";
		when "1100" => ans:="1000110";
		when "1101" => ans:="0100001";
		when "1110" => ans:="0000110";
		when "1111" => ans:="0001110";				
		when others=> ans:="1111111";
	end case;	
	return ans;
end function convSEG;
------------------------------------------------------------------------
------------------------------------------------------------------------
begin

length_seperate_begin<=to_unsigned(100,11);
length_seperate_end<=to_unsigned(450,11);
barrier_y_end<=to_unsigned(10000,11);
barrier_y_first<=to_unsigned(20,11);
side_of_barrier<=to_unsigned(30,11);
length_between_length_seperate<=to_unsigned(46,11);

ghif_L_X_s<=to_unsigned(90,11);
ghif_L_X_s_1<=to_unsigned(96,11);
ghif_L_X_s_2<=to_unsigned(102,11);
ghif_L_X_s_3<=to_unsigned(108,11);
ghif_L_X_s_4<=to_unsigned(114,11);
ghif_L_X_s_5<=to_unsigned(120,11);
ghif_L_X_s_6<=to_unsigned(126,11);
ghif_L_X_s_7<=to_unsigned(132,11);
ghif_L_X_s_8<=to_unsigned(138,11);
ghif_L_X_s_9<=to_unsigned(144,11);
ghif_L_X_s_10<=to_unsigned(150,11);
ghif_L_X_s_11<=to_unsigned(156,11);
ghif_L_X_s_12<=to_unsigned(162,11);
ghif_L_X_s_13<=to_unsigned(168,11);
ghif_L_X_s_14<=to_unsigned(174,11);
ghif_L_X_s_15<=to_unsigned(180,11);
ghif_L_X_s_16<=to_unsigned(186,11);
ghif_L_X_s_17<=to_unsigned(192,11);
ghif_L_X_s_18<=to_unsigned(198,11);
ghif_L_X_s_19<=to_unsigned(204,11);
ghif_L_X_s_20<=to_unsigned(210,11);
ghif_L_X_s_21<=to_unsigned(216,11);
ghif_L_X_s_22<=to_unsigned(222,11);

ghif_R_X_s<=to_unsigned(550,11);
ghif_R_X_s_1<=to_unsigned(544,11);
ghif_r_X_s_2<=to_unsigned(538,11);
ghif_r_X_s_3<=to_unsigned(532,11);
ghif_r_X_s_4<=to_unsigned(526,11);
ghif_r_X_s_5<=to_unsigned(520,11);
ghif_r_X_s_6<=to_unsigned(514,11);
ghif_r_X_s_7<=to_unsigned(508,11);
ghif_r_X_s_8<=to_unsigned(502,11);
ghif_r_X_s_9<=to_unsigned(496,11);
ghif_r_X_s_10<=to_unsigned(490,11);
ghif_r_X_s_11<=to_unsigned(484,11);
ghif_r_X_s_12<=to_unsigned(478,11);
ghif_r_X_s_13<=to_unsigned(472,11);
ghif_r_X_s_14<=to_unsigned(466,11);
ghif_r_X_s_15<=to_unsigned(460,11);
ghif_r_X_s_16<=to_unsigned(454,11);
ghif_r_X_s_17<=to_unsigned(448,11);
ghif_r_X_s_18<=to_unsigned(442,11);
ghif_r_X_s_19<=to_unsigned(436,11);
ghif_r_X_s_20<=to_unsigned(430,11);
ghif_r_X_s_21<=to_unsigned(424,11);
ghif_r_X_s_22<=to_unsigned(418,11);

ghif_L_width_s_x<=to_unsigned(6,11);

x_limit_end_water<=to_unsigned(550,11);
x_limit_first_water<=to_unsigned(90,11);

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
start<=
			'1' when (  ( (output_ran_x>length_between_length_seperate+output_ran_x_1)  or  (output_ran_x_1>length_between_length_seperate+output_ran_x ) ) and ( (output_ran_x>length_between_length_seperate+output_ran_x_2) or (output_ran_x_2>length_between_length_seperate+output_ran_x) ) and ( (output_ran_x_2>length_between_length_seperate+output_ran_x_1) or (output_ran_x_1 >length_between_length_seperate+output_ran_x_2) ) ) AND  (output_ran_x_1 >length_seperate_begin and output_ran_x_1<length_seperate_end and output_ran_y_1>barrier_y_first   and output_ran_y_1<barrier_y_end-side_of_barrier AND output_ran_x_2 >length_seperate_begin and output_ran_x_2<length_seperate_end and output_ran_y_2>barrier_y_first   and output_ran_y_2<barrier_y_end-side_of_barrier AND output_ran_x   >length_seperate_begin and output_ran_x<length_seperate_end   and output_ran_y  >barrier_y_first   and output_ran_y<barrier_y_end-side_of_barrier ) 
			else '0' ;
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

width_of_barrier<=						
						to_unsigned(40,11) when output_ran_x_width="01"
				else  to_unsigned(60,11) when output_ran_x_width="10"
				else  to_unsigned(75,11) when output_ran_x_width="11"
				else  to_unsigned(60,11)  ;
				
width_of_barrier_1<=		
						to_unsigned(40,11) when output_ran_x_width_1="01"
				else  to_unsigned(60,11) when output_ran_x_width_1="10"
				else  to_unsigned(75,11) when output_ran_x_width_1="11"
				else  to_unsigned(60,11);

width_of_barrier_2<=	
						to_unsigned(40,11) when output_ran_x_width_2="01"
				else  to_unsigned(60,11) when output_ran_x_width_2="10"
				else  to_unsigned(75,11) when output_ran_x_width_2="11"
				else  to_unsigned(60,11) ;
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
barrier_width<=
						to_unsigned(40,11) when barrier_x_width="01"
				else  to_unsigned(60,11) when barrier_x_width="10"
				else  to_unsigned(90,11) when barrier_x_width="11"
				else  to_unsigned(60,11);

barrier_width_1<=
						to_unsigned(40,11) when barrier_x_width_1="01"
				else  to_unsigned(60,11) when barrier_x_width_1="10"
				else  to_unsigned(90,11) when barrier_x_width_1="11"
				else  to_unsigned(60,11);
				
barrier_width_2<=
						to_unsigned(40,11) when barrier_x_width_2="01"
				else  to_unsigned(60,11) when barrier_x_width_2="10"
				else  to_unsigned(90,11) when barrier_x_width_2="11"
				else  to_unsigned(60,11);
				
barrier_width_3<=
						to_unsigned(40,11) when barrier_x_width_3="01"
				else  to_unsigned(60,11) when barrier_x_width_3="10"
				else  to_unsigned(90,11) when barrier_x_width_3="11"
				else  to_unsigned(60,11);

-----------------------------------------------------------------------------------------------------				
-----------------------------------------------------------------------------------------------------				
Finish<=

			'1' when ((
							( (((airplaneYPos<output_ran_y+side_of_barrier)and (airplaneYPos>output_ran_y)) or ((airplaneYPos+airPlane_width>output_ran_y)and (airplaneYPos+airPlane_width<output_ran_y+side_of_barrier)) ) and ( (airplaneXPos>=output_ran_x AND airplaneXPos<=output_ran_x+width_of_barrier) OR (airplaneXPos+airPlane_width>=output_ran_x AND airplaneXPos+airPlane_width<=output_ran_x+width_of_barrier )) and start_t_5='0'  ) or
							
							( (((airplaneYPos<output_ran_y_1+side_of_barrier)and (airplaneYPos>output_ran_y_1)) or ((airplaneYPos+airPlane_width>output_ran_y_1)and (airplaneYPos+airPlane_width<output_ran_y_1+side_of_barrier)) ) and ( (airplaneXPos>=output_ran_x_1 AND airplaneXPos<=output_ran_x_1+width_of_barrier_1) OR (airplaneXPos+airPlane_width>=output_ran_x_1 AND airplaneXPos+airPlane_width<=output_ran_x_1+width_of_barrier_1 )) and start_t_6='0') or
							
							( (((airplaneYPos<output_ran_y_2+side_of_barrier)and (airplaneYPos>output_ran_y_2)) or ((airplaneYPos+airPlane_width>output_ran_y_2)and (airplaneYPos+airPlane_width<output_ran_y_2+side_of_barrier)) ) and ( (airplaneXPos>=output_ran_x_2 AND airplaneXPos<=output_ran_x_2+width_of_barrier_2) OR (airplaneXPos+airPlane_width>=output_ran_x_2 AND airplaneXPos+airPlane_width<=output_ran_x_2+width_of_barrier_2 ))and start_t_7='0' ) or
							
							( (((airplaneYPos<barrier_y+side_of_barrier)and (airplaneYPos>barrier_y)) or ((airplaneYPos+airPlane_width>barrier_y)and (airplaneYPos+airPlane_width<barrier_y+side_of_barrier)) ) and ( (airplaneXPos>=barrier_x AND airplaneXPos<=barrier_x+barrier_width) OR (airplaneXPos+airPlane_width>=barrier_x AND airplaneXPos+airPlane_width<=barrier_x+barrier_width )) and start_t_1='0' ) or
							
							( (((airplaneYPos<barrier_y_1+side_of_barrier)and (airplaneYPos>barrier_y_1)) or ((airplaneYPos+airPlane_width>barrier_y_1)and (airplaneYPos+airPlane_width<barrier_y_1+side_of_barrier)) ) and ( (airplaneXPos>=barrier_x_1 AND airplaneXPos<=barrier_x_1+barrier_width_1) OR (airplaneXPos+airPlane_width>=barrier_x_1 AND airplaneXPos+airPlane_width<=barrier_x_1+barrier_width_1 )) and start_t_2='0' ) or
							
							( (((airplaneYPos<barrier_y_2+side_of_barrier)and (airplaneYPos>barrier_y_2)) or ((airplaneYPos+airPlane_width>barrier_y_2)and (airplaneYPos+airPlane_width<barrier_y_2+side_of_barrier)) ) and ( (airplaneXPos>=barrier_x_2 AND airplaneXPos<=barrier_x_2+barrier_width_2) OR (airplaneXPos+airPlane_width>=barrier_x_2 AND airplaneXPos+airPlane_width<=barrier_x_2+barrier_width_2 )) and start_t_3='0' ) or
							
							( (((airplaneYPos<barrier_y_3+side_of_barrier)and (airplaneYPos>barrier_y_3)) or ((airplaneYPos+airPlane_width>barrier_y_3)and (airplaneYPos+airPlane_width<barrier_y_3+side_of_barrier)) ) and ( (airplaneXPos>=barrier_x_3 AND airplaneXPos<=barrier_x_3+barrier_width_3) OR (airplaneXPos+airPlane_width>=barrier_x_3 AND airplaneXPos+airPlane_width<=barrier_x_3+barrier_width_3 )) and start_t_4='0' ) ) 
							
							or
							
							(airplaneXPos=to_unsigned(90,11) or airplaneXPos+airPlane_width=to_unsigned(550,11))
							) 
		else	'0' ;
		
FinishPrime <= finish or finish_1 or finish_2; 
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
LEd_R<="1111111111" when finishPrime='1' else "0000000000" ;
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
score_yekan <= score rem 10;
score_dahgan <= score / 10;
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
time_Game_Int <= time_Game / ( 50000000 );
time_Game_Yekan <= time_Game_Int rem ( 10 );
time_Game_Dahgan <= time_Game_Int / ( 10 );
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------			
ColorOutput <=		
		  "001100000000" when ( scanlineX>=Tir_x and scanlineY>=Tir_y and scanlineX<=Tir_x+to_unsigned(8,11) and  scanliney<=Tir_y+to_unsigned(8,11) ) and start_t='1'
	else "000000000000"	when ( start='1'  and output_ran_x_1 >length_seperate_begin and output_ran_x_1<length_seperate_end and output_ran_y_1>barrier_y_first   and output_ran_y_1<barrier_y_end-side_of_barrier and scanlineX>=output_ran_x_1 and scanlineY>=output_ran_y_1 and scanlineX<output_ran_x_1+width_of_barrier_1 and scanlineY<output_ran_y_1+side_of_barrier) and start2(1)='0' and start_t_6='0'
	else  "111111111111" when ( scanlineX>=barrier_x and scanlineY>=barrier_y and scanlineX<barrier_x+ barrier_width and scanlineY<barrier_y+side_of_barrier) and start27='1' and start_t_1='0'
	else  "000000000000" when ( scanlineX>=barrier_x_1 and scanlineY>=barrier_y_1 and scanlineX<barrier_x_1+ barrier_width_1 and scanlineY<barrier_y_1+side_of_barrier) and start28='1' and start_t_2='0'
	else  "111100000000" when ( scanlineX>=barrier_x_2 and scanlineY>=barrier_y_2 and scanlineX<barrier_x_2+ barrier_width_2 and scanlineY<barrier_y_2+side_of_barrier) and start29='1' and start_t_3='0'
	else  "000011111111" when ( scanlineX>=barrier_x_3 and scanlineY>=barrier_y_3 and scanlineX<barrier_x_3+ barrier_width_3 and scanlineY<barrier_y_3+side_of_barrier) and start30='1' and start_t_4='0'
	else	"111111110000"	when ( start='1'  and  output_ran_x_2 >length_seperate_begin and output_ran_x_2<length_seperate_end and output_ran_y_2>barrier_y_first   and output_ran_y_2<barrier_y_end-side_of_barrier and scanlineX>=output_ran_x_2 and scanlineY>=output_ran_y_2 and scanlineX<output_ran_x_2+width_of_barrier_2 and scanlineY<output_ran_y_2+side_of_barrier) and start2(2)='0' and start_t_7='0'
	else	"000011110000"	when ( start='1'  and  output_ran_x   >length_seperate_begin and output_ran_x<length_seperate_end   and output_ran_y  >barrier_y_first   and output_ran_y<barrier_y_end-side_of_barrier   and scanlineX>=output_ran_x   and scanlineY>=output_ran_y   and scanlineX<output_ran_x+width_of_barrier     and scanlineY<output_ran_y+side_of_barrier)  and start2(0)='0' and start_t_5='0' 
	else	"111111111111" when ( scanlineX >= AirplaneXPos AND ScanlineY >= AirplaneYPos AND ScanlineX < AirplaneXPos + airPlane_width AND scanlineY < AirplaneYPos + airPlane_width )
	else	"000011110000" when scanlineX>=x_limit_end_water or scanlineX<=x_limit_first_water or (((scanlineX>=ghif_L_X_s and scanliney>=ghif_L_Y_s and scanlineX<ghif_L_X_s+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s and scanliney>=ghif_L_Y_s and scanlineX<ghif_R_X_s+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start1='0')  
		or (((scanlineX>=ghif_L_X_s_1 and scanliney>=ghif_L_Y_s_1 and scanlineX<ghif_L_X_s_1+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_1 and scanliney>=ghif_L_Y_s_1 and scanlineX<ghif_R_X_s_1+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start5='0')
		or (((scanlineX>=ghif_L_X_s_2 and scanliney>=ghif_L_Y_s_2 and scanlineX<ghif_L_X_s_2+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_2 and scanliney>=ghif_L_Y_s_2 and scanlineX<ghif_R_X_s_2+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start6='0') 	
		or (((scanlineX>=ghif_L_X_s_3 and scanliney>=ghif_L_Y_s_3 and scanlineX<ghif_L_X_s_3+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_3 and scanliney>=ghif_L_Y_s_3 and scanlineX<ghif_R_X_s_3+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start7='0') 
		or (((scanlineX>=ghif_L_X_s_4 and scanliney>=ghif_L_Y_s_4 and scanlineX<ghif_L_X_s_4+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_4 and scanliney>=ghif_L_Y_s_4 and scanlineX<ghif_R_X_s_4+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start8='0') 
		or (((scanlineX>=ghif_L_X_s_5 and scanliney>=ghif_L_Y_s_5 and scanlineX<ghif_L_X_s_5+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_5 and scanliney>=ghif_L_Y_s_5 and scanlineX<ghif_R_X_s_5+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start9='0') 
		or (((scanlineX>=ghif_L_X_s_6 and scanliney>=ghif_L_Y_s_6 and scanlineX<ghif_L_X_s_6+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_6 and scanliney>=ghif_L_Y_s_6 and scanlineX<ghif_R_X_s_6+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start10='0') 
		or (((scanlineX>=ghif_L_X_s_7 and scanliney>=ghif_L_Y_s_7 and scanlineX<ghif_L_X_s_7+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_7 and scanliney>=ghif_L_Y_s_7 and scanlineX<ghif_R_X_s_7+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start11='0') 
		or (((scanlineX>=ghif_L_X_s_8 and scanliney>=ghif_L_Y_s_8 and scanlineX<ghif_L_X_s_8+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_8 and scanliney>=ghif_L_Y_s_8 and scanlineX<ghif_R_X_s_8+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start12='0') 
		or (((scanlineX>=ghif_L_X_s_9 and scanliney>=ghif_L_Y_s_9 and scanlineX<ghif_L_X_s_9+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_9 and scanliney>=ghif_L_Y_s_9 and scanlineX<ghif_R_X_s_9+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start13='0') 
		or (((scanlineX>=ghif_L_X_s_10 and scanliney>=ghif_L_Y_s_10 and scanlineX<ghif_L_X_s_10+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_10 and scanliney>=ghif_L_Y_s_10 and scanlineX<ghif_R_X_s_10+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start14='0') 
		or (((scanlineX>=ghif_L_X_s_11 and scanliney>=ghif_L_Y_s_11 and scanlineX<ghif_L_X_s_11+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_11 and scanliney>=ghif_L_Y_s_11 and scanlineX<ghif_R_X_s_11+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start15='0') 
		or (((scanlineX>=ghif_L_X_s_12 and scanliney>=ghif_L_Y_s_12 and scanlineX<ghif_L_X_s_12+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_12 and scanliney>=ghif_L_Y_s_12 and scanlineX<ghif_R_X_s_12+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start16='0') 
		or (((scanlineX>=ghif_L_X_s_13 and scanliney>=ghif_L_Y_s_13 and scanlineX<ghif_L_X_s_13+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_13 and scanliney>=ghif_L_Y_s_13 and scanlineX<ghif_R_X_s_13+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start17='0') 
		or (((scanlineX>=ghif_L_X_s_14 and scanliney>=ghif_L_Y_s_14 and scanlineX<ghif_L_X_s_14+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_14 and scanliney>=ghif_L_Y_s_14 and scanlineX<ghif_R_X_s_14+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start18='0') 
		or (((scanlineX>=ghif_L_X_s_15 and scanliney>=ghif_L_Y_s_15 and scanlineX<ghif_L_X_s_15+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_15 and scanliney>=ghif_L_Y_s_15 and scanlineX<ghif_R_X_s_15+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start19='0') 
		or (((scanlineX>=ghif_L_X_s_16 and scanliney>=ghif_L_Y_s_16 and scanlineX<ghif_L_X_s_16+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_16 and scanliney>=ghif_L_Y_s_16 and scanlineX<ghif_R_X_s_16+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start20='0') 
		or (((scanlineX>=ghif_L_X_s_17 and scanliney>=ghif_L_Y_s_17 and scanlineX<ghif_L_X_s_17+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_17 and scanliney>=ghif_L_Y_s_17 and scanlineX<ghif_R_X_s_17+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start21='0') 
		or (((scanlineX>=ghif_L_X_s_18 and scanliney>=ghif_L_Y_s_18 and scanlineX<ghif_L_X_s_18+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_18 and scanliney>=ghif_L_Y_s_18 and scanlineX<ghif_R_X_s_18+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start22='0') 
		or (((scanlineX>=ghif_L_X_s_19 and scanliney>=ghif_L_Y_s_19 and scanlineX<ghif_L_X_s_19+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_19 and scanliney>=ghif_L_Y_s_19 and scanlineX<ghif_R_X_s_19+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start23='0') 
		or (((scanlineX>=ghif_L_X_s_20 and scanliney>=ghif_L_Y_s_20 and scanlineX<ghif_L_X_s_20+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_20 and scanliney>=ghif_L_Y_s_20 and scanlineX<ghif_R_X_s_20+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start24='0') 
		or (((scanlineX>=ghif_L_X_s_21 and scanliney>=ghif_L_Y_s_21 and scanlineX<ghif_L_X_s_21+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_21 and scanliney>=ghif_L_Y_s_21 and scanlineX<ghif_R_X_s_21+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start25='0') 
		or (((scanlineX>=ghif_L_X_s_22 and scanliney>=ghif_L_Y_s_22 and scanlineX<ghif_L_X_s_22+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11)) or(scanlineX>=ghif_R_X_s_22 and scanliney>=ghif_L_Y_s_22 and scanlineX<ghif_R_X_s_22+ghif_L_width_s_x and scanlineY<=to_unsigned(480,11))) and start26='0') 
	else  "000000001111" ;

ColorOut <= ColorOutput; 

---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
process(clk_50MHz)
begin
	if rising_edge(CLK_50MHz) then
		if(start3 = '1') or finishPrime='1' then
			Seg_0 <= convSEG(score_yekan(3 downto 0));
			Seg_1 <= convSEG(score_dahgan(3 downto 0));
			Seg_2 <= convSEG(time_Game_Yekan(3 downto 0));
			Seg_3 <= convSEG(time_Game_Dahgan(3 downto 0));
			Seg_4 <= convSEG("0000");
			Seg_5 <= convSEG("0000");
		else
			Seg_0 <= convSEG("0001");
			Seg_1 <= convSEG("0010");
			Seg_2 <= convSEG("0111");
			Seg_3 <= convSEG("0011");
			Seg_4 <= convSEG("0000");
			Seg_5 <= convSEG("0000");
		end if;
	end if;
end process;
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
process(CLK_50MHz,RESET)
function lfsr32(x : unsigned(31 downto 0)) return unsigned is
begin
return x(30 downto 0) & (x(0) xnor x(1) xnor x(21) xnor x(31));
end function;
begin

if RESET = '1' then
	Prescaler <= (others => '0');
	Prescaler1 <= (others => '0');
	prescaler2 <= (others => '0');
	prescaler11<=(others=>'0');
	prescaler14<=(others=>'0');
	
	output_ran_x<=(others=>'0') ;
	output_ran_x_width<=(others=>'0') ;
	output_ran_y<=(others=>'0') ;
	output_ran_x_1<=(others=>'0') ;
	output_ran_x_width_1<=(others=>'0') ;
	output_ran_y_1<=(others=>'0') ;
	output_ran_x_2<=(others=>'0') ;
	output_ran_x_width_2<=(others=>'0') ;
	output_ran_y_2<=(others=>'0') ;
	
	ghif_L_y_s_22<=to_unsigned(320,11)+to_unsigned(14,11);
	ghif_L_y_s_21<=to_unsigned(317,11)+to_unsigned(14,11);
	ghif_L_y_s_20<=to_unsigned(314,11)+to_unsigned(14,11);
	ghif_L_y_s_19<=to_unsigned(311,11)+to_unsigned(14,11);
	ghif_L_y_s_18<=to_unsigned(308,11)+to_unsigned(14,11);
	ghif_L_y_s_17<=to_unsigned(305,11)+to_unsigned(14,11);
	ghif_L_y_s_16<=to_unsigned(302,11)+to_unsigned(14,11);
	ghif_L_y_s_15<=to_unsigned(299,11)+to_unsigned(14,11);
	ghif_L_y_s_14<=to_unsigned(296,11)+to_unsigned(14,11);
	ghif_L_y_s_13<=to_unsigned(293,11)+to_unsigned(14,11);
	ghif_L_y_s_12<=to_unsigned(290,11)+to_unsigned(14,11);
	ghif_L_y_s_11<=to_unsigned(287,11)+to_unsigned(14,11);
	ghif_L_y_s_10<=to_unsigned(284,11)+to_unsigned(14,11);
	ghif_L_y_s_9<=to_unsigned(281,11)+to_unsigned(14,11);
	ghif_L_y_s_8<=to_unsigned(278,11)+to_unsigned(14,11);
	ghif_L_y_s_7<=to_unsigned(275,11)+to_unsigned(14,11);
	ghif_L_y_s_6<=to_unsigned(271,11)+to_unsigned(14,11);
	ghif_L_y_s_5<=to_unsigned(268,11)+to_unsigned(14,11);
	ghif_L_y_s_4<=to_unsigned(265,11)+to_unsigned(14,11);
	ghif_L_y_s_3<=to_unsigned(262,11)+to_unsigned(14,11);
	ghif_L_y_s_2<=to_unsigned(259,11)+to_unsigned(14,11);
	ghif_L_y_s_1<=to_unsigned(256,11)+to_unsigned(14,11);
	ghif_L_y_s<=to_unsigned(253,11) +to_unsigned(14,11) ;
	
	
	start1<='0';
	start2<="000";
	start3<='0';
	start5<='0';
	start6<='0';
	start7<='0';
	start8<='0';
	start9<='0';
	start10<='0';
	start11<='0';
	start12<='0';
	start13<='0';
	start14<='0';
	start15<='0';
	start16<='0';
	start17<='0';
	start18<='0';
	start19<='0';
	start20<='0';
	start21<='0';
	start22<='0';
	start23<='0';
	start24<='0';
	start25<='0';
	start26<='0';
	
	start_t<='0' ;
	start_t_1<='0';
	start_t_2<='0';
	start_t_3<='0';
	start_t_4<='0';
	start_t_5<='0';
	start_t_6<='0';
	start_t_7<='0';
	
	Tir_x<=to_unsigned(0,11) ;
	Tir_y<=to_unsigned(0,9) ;
	hit<='0';
	
	
	AirplaneYPos<=to_unsigned(280,9);
	AirplaneXPos<=to_unsigned(300,11);
	AirPlane_width<=to_unsigned(30,9);  
	
	finish_2<='0';
	
	score<=(others=>'0') ;
	
	auto<='0' ;
	auto1<='0' ;
	auto2<='0' ;
	auto3<='0';
	auto4<='0';
	auto5<='0';
	auto6<='0';

	
elsif rising_edge(CLK_50MHz) then
	if start='0'  then  
		pseudo_rand <= lfsr32(pseudo_rand);

		output_ran_x<='0'&'0'& pseudo_rand(8 downto 0);
		output_ran_x_width<=pseudo_rand(1 downto 0) ;
		output_ran_y<=to_unsigned(30,9);

		output_ran_x_1<='0'&'0'& pseudo_rand(10 downto 2); 
		output_ran_x_width_1<=pseudo_rand(9 downto 8) ;
		output_ran_y_1<=to_unsigned(100,9);

		output_ran_x_2<='0'&'0'& pseudo_rand(12 downto 4); 
		output_ran_x_width_2<=pseudo_rand(17 downto 16);
		output_ran_y_2<=to_unsigned(170,9);
	
	end if ;
---------------------------------------------------------------------------
---------------------------------------------------------------------------

	if (key_air(2) = '0' or start3='1') and FinishPrime='0' then 
		prescaler14<=prescaler14+1;
		Prescaler <= Prescaler + "00000000001";
		if prescaler="0000000000001001001001111100000"    then 
			
			if output_ran_y /= to_unsigned(480,11) then 
				output_ran_y<=output_ran_y+"000000001";
			else
				start2(0)<='1' ;
			end if;
			if output_ran_y_1 /=to_unsigned (480,11) then
				output_ran_y_1<=output_ran_y_1+"000000001";
			else
				start2(1)<='1' ;
			end if ;
			if output_ran_y_2 /=to_unsigned(480,11) then 
				output_ran_y_2<=output_ran_y_2+"000000001";
			else
				start2(2)<='1' ;
			end if;
			if ghif_L_Y_s /=to_unsigned(480,11) then 
				ghif_L_y_s<=ghif_L_y_s+"00000000001";
			else
				start1<='1' ;
			end if;
			if ghif_L_Y_s_1/=to_unsigned(480,11) then 
				ghif_L_y_s_1<=ghif_L_y_s_1+"00000000001";
			else
				start5<='1' ;
			end if;
			if ghif_L_Y_s_2/=to_unsigned(480,11) then 
				ghif_L_y_s_2<=ghif_L_y_s_2+"00000000001";
			else
				start6<='1' ;
			end if;
			if ghif_L_Y_s_3/=to_unsigned(480,11) then
				ghif_L_y_s_3<=ghif_L_y_s_3+"00000000001";
			else 
				start7<='1' ;
			end if;
			if ghif_L_Y_s_4/=to_unsigned(480,11) then 
				ghif_L_y_s_4<=ghif_L_y_s_4+"00000000001";
			else
				start8<='1' ;
			end if;
			if ghif_L_Y_s_5/=to_unsigned(480,11) then 
				ghif_L_y_s_5<=ghif_L_y_s_5+"00000000001";
			else
				start9<='1' ;
			end if;
			if ghif_L_Y_s_6/=to_unsigned(480,11) then 
				ghif_L_y_s_6<=ghif_L_y_s_6+"00000000001";
			else
				start10<='1' ;
			end if;
			if ghif_L_Y_s_7/=to_unsigned(480,11) then 
				ghif_L_y_s_7<=ghif_L_y_s_7+"00000000001";
			else
				start11<='1' ;
			end if;
			if ghif_L_Y_s_8/=to_unsigned(480,11) then 
				ghif_L_y_s_8<=ghif_L_y_s_8+"00000000001";
			else
				start12<='1' ;
			end if;
			if ghif_L_Y_s_9/=to_unsigned(480,11) then 
				ghif_L_y_s_9<=ghif_L_y_s_9+"00000000001";
			else
				start13<='1' ;
			end if;
			if ghif_L_Y_s_10/=to_unsigned(480,11) then 
				ghif_L_y_s_10<=ghif_L_y_s_10+"00000000001";
			else
				start14<='1' ;
			end if;
			if ghif_L_Y_s_11/=to_unsigned(480,11) then 
				ghif_L_y_s_11<=ghif_L_y_s_11+"00000000001";
			else
				start15<='1' ;
			end if;
			if ghif_L_Y_s_12/=to_unsigned(480,11) then 
				ghif_L_y_s_12<=ghif_L_y_s_12+"00000000001";
			else
				start16<='1' ;
			end if;
			if ghif_L_Y_s_13/=to_unsigned(480,11) then 
				ghif_L_y_s_13<=ghif_L_y_s_13+"00000000001";
			else
				start17<='1' ;
			end if;
			if ghif_L_Y_s_14/=to_unsigned(480,11) then
				ghif_L_y_s_14<=ghif_L_y_s_14+"00000000001";
			else
				start18<='1' ; 
			end if;
			if ghif_L_Y_s_15/=to_unsigned(480,11) then 
				ghif_L_y_s_15<=ghif_L_y_s_15+"00000000001";
			else
				start19<='1' ;
			end if;
			if ghif_L_Y_s_16/=to_unsigned(480,11) then 
				ghif_L_y_s_16<=ghif_L_y_s_16+"00000000001";
			else
				start20<='1' ;
			end if;
			if ghif_L_Y_s_17/=to_unsigned(480,11) then 
				ghif_L_y_s_17<=ghif_L_y_s_17+"00000000001";
			else
				start21<='1' ;
			end if;
			if ghif_L_Y_s_18/=to_unsigned(480,11) then 
				ghif_L_y_s_18<=ghif_L_y_s_18+"00000000001";
			else
				start22<='1' ;
			end if;
			if ghif_L_Y_s_19/=to_unsigned(480,11) then 
				ghif_L_y_s_19<=ghif_L_y_s_19+"00000000001";
			else
				start23<='1' ;
			end if;
			if ghif_L_Y_s_20/=to_unsigned(480,11) then 
				ghif_L_y_s_20<=ghif_L_y_s_20+"00000000001";
			else
				start24<='1' ;
			end if;
			if ghif_L_Y_s_21/=to_unsigned(480,11) then 
				ghif_L_y_s_21<=ghif_L_y_s_21+"00000000001";
			else
				start25<='1' ;
			end if;
			if ghif_L_Y_s_22/=to_unsigned(480,11) then 
				ghif_L_y_s_22<=ghif_L_y_s_22+"00000000001";
			else
				start26<='1' ;
			end if;
			start3<='1';
			prescaler<=(others=>'0');
	   end if ;
	end if ;
	
	
	if finishPrime='1' then 
		start3<='0'  ;
	end if ;
----------------------------------------------------------------------------------------------------------	
----------------------------------------------------------------------------------------------------------	
	if FinishPrime='0' and start3='1' and sw_r(0)='0' then
	
		if key_air(0)='0'   then
		prescaler1<=prescaler1 + "00000000001" ;
			if prescaler1="1100001101010000000" then 
				AirplaneXPos<=AirplaneXPos + "00000000001";
				prescaler1<=(others=>'0');
			end if ;
		end if ;
		
		if key_air(1)='0' and  sw_r(0)='0' then
		prescaler2<=prescaler2 + "00000000001" ;   
			if prescaler2="1100001101010000000" then 
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				prescaler2<=(others=>'0');
			end if ;
		end if ;
	end if ;
	
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

	if airplaneYPos>output_ran_y_2 and start3='1' and sw_R(0)='1' and auto='0'   then 
		
		
			if ( airplaneXPos>=output_ran_x_2+width_of_barrier_2/"10") and(airplaneXPos<=output_ran_x_2+width_of_barrier_2) and airplaneXPos<to_unsigned(550,11) and auto='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > output_ran_x_2 + width_of_barrier_2  then 
					auto<='1';
				end if;
			elsif ( airplaneXPos+airPlane_width<=output_ran_x_2+width_of_barrier_2/"10" ) and (airplaneXPos+airPlane_width>=output_ran_x_2) and airplaneXPos>to_unsigned(90,11) and auto='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < output_ran_x_2  then 
					auto<='1';
				end if;
			elsif( airplaneXPos>output_ran_x_2 ) and ( airplaneXPos<output_ran_x_2+width_of_barrier_2 ) and ( airplaneXPos+airPlane_width>output_ran_x_2 ) and ( airplaneXPos+airPlane_width<output_ran_x_2+width_of_barrier_2 ) and auto='0' then 
				 AirplaneXPos<=AirplaneXPos - "00000000001" ;
				 if airplaneXPos +airPlane_width < output_ran_x_2  then 
					auto<='1';
				 end if ;
			elsif (airplaneXPos+airPlane_width>output_ran_x_2+width_of_barrier_2) and (airplaneXPos<output_ran_x_2+width_of_barrier_2) and (airplaneXPos>output_ran_x_2) and auto='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > output_ran_x_2 + width_of_barrier_2  then 
					auto<='1';
				end if;
			
			elsif (airplaneXPos<output_ran_x_2) and (airplaneXPos+airPlane_width<output_ran_x_2+width_of_barrier_2) and (airplaneXPos+airPlane_width > output_ran_x_2) and auto='0' then 
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < output_ran_x_2  then 
					auto<='1';
				end if;
			
			else 
				auto<='1' ;
			end if ;
	end if ;	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if airplaneYPos+airPlane_width<output_ran_y_2 and airplaneYPos>output_ran_y_1  and start3='1' and sw_R(0)='1' and auto1='0' and auto='1'   then 
		
		
			if ( airplaneXPos>=output_ran_x_1+width_of_barrier_1/"10") and(airplaneXPos<=output_ran_x_1+width_of_barrier_1) and airplaneXPos<to_unsigned(550,11) and auto1='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > output_ran_x_1 + width_of_barrier_1  then 
					auto1<='1';
				end if;
			elsif ( airplaneXPos+airPlane_width<=output_ran_x_1+width_of_barrier_1/"10" ) and (airplaneXPos+airPlane_width>=output_ran_x_1) and airplaneXPos>to_unsigned(90,11) and auto1='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < output_ran_x_1  then 
					auto1<='1';
				end if;
			elsif( airplaneXPos>output_ran_x_1 ) and ( airplaneXPos<output_ran_x_1+width_of_barrier_1 ) and ( airplaneXPos+airPlane_width>output_ran_x_1 ) and ( airplaneXPos+airPlane_width<output_ran_x_1+width_of_barrier_1 )  and auto1='0' then 
				 AirplaneXPos<=AirplaneXPos - "00000000001" ;
				 if airplaneXPos +airPlane_width < output_ran_x_1  then 
					auto1<='1';
				 end if ;
			elsif (airplaneXPos+airPlane_width>output_ran_x_1+width_of_barrier_1) and (airplaneXPos<output_ran_x_1+width_of_barrier_1) and (airplaneXPos>output_ran_x_1) and auto1='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > output_ran_x_1 + width_of_barrier_1  then 
					auto1<='1';
				end if;
			
			elsif (airplaneXPos<output_ran_x_1) and (airplaneXPos+airPlane_width<output_ran_x_1+width_of_barrier_1) and (airplaneXPos+airPlane_width > output_ran_x_1) and auto1='0' then 
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < output_ran_x_1  then 
					auto1<='1';
				end if;
			
			else 
				auto1<='1' ;
			end if ;
	end if ;
	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if airplaneYPos+airPlane_width<output_ran_y_1 and airplaneYPos>output_ran_y  and start3='1' and sw_R(0)='1' and auto2='0' and auto1='1' and auto='1'   then 
		
		
			if ( airplaneXPos>=output_ran_x+width_of_barrier/"10") and(airplaneXPos<=output_ran_x+width_of_barrier) and airplaneXPos<to_unsigned(550,11) and auto2='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > output_ran_x + width_of_barrier  then 
					auto2<='1';
				end if;
			elsif ( airplaneXPos+airPlane_width<=output_ran_x+width_of_barrier/"10" ) and (airplaneXPos+airPlane_width>=output_ran_x) and airplaneXPos>to_unsigned(90,11) and auto2='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < output_ran_x  then 
					auto2<='1';
				end if;
			elsif(airplaneXPos>output_ran_x )and(airplaneXPos<output_ran_x+width_of_barrier)and(airplaneXPos+airPlane_width>output_ran_x)and(airplaneXPos+airPlane_width<output_ran_x+width_of_barrier)and auto2='0' then 
				 AirplaneXPos<=AirplaneXPos - "00000000001" ;
				 if airplaneXPos +airPlane_width < output_ran_x  then 
					auto2<='1';
				 end if ;
			elsif (airplaneXPos+airPlane_width>output_ran_x+width_of_barrier) and (airplaneXPos<output_ran_x+width_of_barrier) and (airplaneXPos>output_ran_x) and auto2='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > output_ran_x + width_of_barrier  then 
					auto2<='1';
				end if;
			
			elsif (airplaneXPos<output_ran_x) and (airplaneXPos+airPlane_width<output_ran_x+width_of_barrier) and (airplaneXPos+airPlane_width > output_ran_x) and auto2='0' then 
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < output_ran_x  then 
					auto2<='1';
				end if;
			
			else 
				auto2<='1' ;
			end if ;
	end if ;

------------------------------------------------------------------------------------------------------------------------------------------------


	if airplaneYPos+airPlane_width<output_ran_y and airplaneYPos>barrier_y  and start3='1' and sw_R(0)='1' and auto3='0' and auto2='1' and auto1='1' and auto='1'   then 
			
			if (airplaneXPos+airPlane_width>barrier_x) and (airplaneXPos+airPlane_width<barrier_x+barrier_width) and (barrier_x-airPlane_width<=to_unsigned(90,11)) and auto3='0' then
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x + barrier_width  then 
					auto3<='1';
				end if;
			
			elsif (airplaneXPos+airPlane_width>barrier_x) and (airplaneXPos+airPlane_width<barrier_x+barrier_width) and (barrier_x+barrier_width+airPlane_width>=to_unsigned(550,11)) and auto3='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos+airPlane_width < barrier_x then 
					auto3<='1';
				end if;
			
			elsif ( airplaneXPos>=barrier_x+barrier_width/"10") and(airplaneXPos<=barrier_x+barrier_width) and airplaneXPos<to_unsigned(550,11) and auto3='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x + barrier_width  then 
					auto3<='1';
				end if;
			elsif ( airplaneXPos+airPlane_width<=barrier_x+barrier_width/"10" ) and (airplaneXPos+airPlane_width>=barrier_x) and airplaneXPos>to_unsigned(90,11) and auto3='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < barrier_x  then 
					auto3<='1';
				end if;
			elsif( airplaneXPos>=barrier_x )and(airplaneXPos<barrier_x+barrier_width)and(airplaneXPos+airPlane_width>barrier_x)and(airplaneXPos+airPlane_width<barrier_x+barrier_width)and auto3='0' then 
				 AirplaneXPos<=AirplaneXPos - "00000000001" ;
				 if airplaneXPos +airPlane_width < barrier_x  then 
					auto3<='1';
				 end if ;
			elsif (airplaneXPos+airPlane_width>=barrier_x+barrier_width) and (airplaneXPos<barrier_x+barrier_width) and (airplaneXPos>barrier_x) and auto3='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x + barrier_width  then 
					auto3<='1';
				end if;
			
			elsif (airplaneXPos<barrier_x) and (airplaneXPos+airPlane_width<barrier_x+barrier_width) and (airplaneXPos+airPlane_width > barrier_x) and auto3='0' then 
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < barrier_x  then 
					auto3<='1';
				end if;
			else 
				auto3<='1' ;
			end if ;
	end if ;
	
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if airplaneYPos+airPlane_width<barrier_y and airplaneYPos>barrier_y_1  and start3='1' and sw_R(0)='1' and auto4='0' and auto3='1' and auto2='1' and auto1='1' and auto='1'   then 
	
			if (airplaneXPos+airPlane_width>barrier_x_1) and (airplaneXPos+airPlane_width<barrier_x_1+barrier_width_1) and (barrier_x_1-airPlane_width<=to_unsigned(90,11)) and auto4='0' then
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_1 + barrier_width_1  then 
					auto4<='1';
				end if;
			
			elsif (airplaneXPos+airPlane_width>barrier_x_1) and (airplaneXPos+airPlane_width<barrier_x_1+barrier_width_1) and (barrier_x_1+barrier_width_1+airPlane_width>=to_unsigned(550,11)) and auto4='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos+airPlane_width < barrier_x_1 then 
					auto4<='1';
				end if;
			elsif ( airplaneXPos>=barrier_x_1+barrier_width_1/"10") and(airplaneXPos<=barrier_x_1+barrier_width_1) and airplaneXPos<to_unsigned(550,11) and auto4='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_1 + barrier_width_1  then 
					auto4<='1';
				end if;
			elsif ( airplaneXPos+airPlane_width<=barrier_x_1+barrier_width_1/"10" ) and (airplaneXPos+airPlane_width>=barrier_x_1) and airplaneXPos>to_unsigned(90,11) and auto4='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < barrier_x_1  then 
					auto4<='1';
				end if;
			elsif( airplaneXPos>=barrier_x_1 )and(airplaneXPos<barrier_x_1+barrier_width_1)and(airplaneXPos+airPlane_width>barrier_x_1)and(airplaneXPos+airPlane_width<barrier_x_1+barrier_width_1)and auto4='0' then 
				 AirplaneXPos<=AirplaneXPos - "00000000001" ;
				 if airplaneXPos +airPlane_width < barrier_x_1  then 
					auto4<='1';
				 end if ;
			elsif (airplaneXPos+airPlane_width>=barrier_x_1+barrier_width_1) and (airplaneXPos<barrier_x_1+barrier_width_1) and (airplaneXPos>barrier_x_1) and auto4='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_1 + barrier_width_1  then 
					auto4<='1';
				end if;
			
			elsif (airplaneXPos<barrier_x_1) and (airplaneXPos+airPlane_width<barrier_x_1+barrier_width_1) and (airplaneXPos+airPlane_width > barrier_x_1) and auto4='0' then 
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < barrier_x_1  then 
					auto4<='1';
				end if;
			
			else 
				auto4<='1' ;
			end if ;
	end if ;
	
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if airplaneYPos+airPlane_width<barrier_y_1 and airplaneYPos>barrier_y_2  and start3='1' and sw_R(0)='1' and auto5='0' and auto4='1' and auto3='1' and auto2='1' and auto1='1' and auto='1'   then 
		
			if (airplaneXPos+airPlane_width>barrier_x_2) and (airplaneXPos+airPlane_width<barrier_x_2+barrier_width_2) and (barrier_x_2-airPlane_width<=to_unsigned(90,11)) and auto5='0' then
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_2 + barrier_width_2  then 
					auto5<='1';
				end if;
			
			elsif (airplaneXPos+airPlane_width>barrier_x_2) and (airplaneXPos+airPlane_width<barrier_x_2+barrier_width_2) and (barrier_x_2+barrier_width_2+airPlane_width>=to_unsigned(550,11)) and auto5='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos+airPlane_width < barrier_x_2 then 
					auto5<='1';
				end if;
				
			elsif ( airplaneXPos>=barrier_x_2+barrier_width_2/"10") and(airplaneXPos<=barrier_x_2+barrier_width_2) and airplaneXPos<to_unsigned(550,11) and auto5='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_2 + barrier_width_2  then 
					auto5<='1';
				end if;
			elsif ( airplaneXPos+airPlane_width<=barrier_x_2+barrier_width_2/"10" ) and (airplaneXPos+airPlane_width>=barrier_x_2) and airplaneXPos>to_unsigned(90,11) and auto5='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < barrier_x_2  then 
					auto5<='1';
				end if;
			elsif( airplaneXPos>=barrier_x_2 )and(airplaneXPos<barrier_x_2+barrier_width_2)and(airplaneXPos+airPlane_width>barrier_x_2)and(airplaneXPos+airPlane_width<barrier_x_2+barrier_width_2)and auto5='0' then 
				 AirplaneXPos<=AirplaneXPos - "00000000001" ;
				 if airplaneXPos +airPlane_width < barrier_x_2  then 
					auto5<='1';
				 end if ;
			elsif (airplaneXPos+airPlane_width>=barrier_x_2+barrier_width_2) and (airplaneXPos<barrier_x_2+barrier_width_2) and (airplaneXPos>barrier_x_2) and auto5='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_2 + barrier_width_2  then 
					auto5<='1';
				end if;
			elsif (airplaneXPos<barrier_x_2) and (airplaneXPos+airPlane_width<barrier_x_2+barrier_width_2) and (airplaneXPos+airPlane_width > barrier_x_2) and auto5='0' then 
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < barrier_x_2  then 
					auto5<='1';
				end if;
			else 
				auto5<='1' ;
			end if ;
	end if ;
		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if airplaneYPos+airPlane_width<barrier_y_2 and airplaneYPos>barrier_y_3  and start3='1' and sw_R(0)='1' and auto6='0' and auto5='1' and auto4='1' and auto3='1' and auto2='1' and auto1='1' and auto='1'   then 

			if (airplaneXPos+airPlane_width>barrier_x_3) and (airplaneXPos+airPlane_width<barrier_x_3+barrier_width_3) and (barrier_x_3-airPlane_width<=to_unsigned(90,11)) and auto6='0' then
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_3 + barrier_width_3  then 
					auto6<='1';
				end if;
			elsif (airplaneXPos+airPlane_width>barrier_x_3) and (airplaneXPos+airPlane_width<barrier_x_3+barrier_width_3) and (barrier_x_3+barrier_width_3+airPlane_width>=to_unsigned(550,11)) and auto6='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos+airPlane_width < barrier_x_3 then 
					auto6<='1';
				end if;
			elsif ( airplaneXPos>=barrier_x_3+barrier_width_3/"10") and(airplaneXPos<=barrier_x_3+barrier_width_3) and airplaneXPos<to_unsigned(550,11) and auto6='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_3 + barrier_width_3  then 
					auto6<='1';
				end if;
			elsif ( airplaneXPos+airPlane_width<=barrier_x_3+barrier_width_3/"10" ) and (airplaneXPos+airPlane_width>=barrier_x_3) and airplaneXPos>to_unsigned(90,11) and auto6='0' then
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < barrier_x_3  then 
					auto6<='1';
				end if;
			elsif( airplaneXPos>=barrier_x_3 )and(airplaneXPos<barrier_x_3+barrier_width_3)and(airplaneXPos+airPlane_width>barrier_x_3)and(airplaneXPos+airPlane_width<barrier_x_3+barrier_width_3)and auto6='0' then 
				 AirplaneXPos<=AirplaneXPos - "00000000001" ;
				 if airplaneXPos +airPlane_width < barrier_x_3  then 
					auto6<='1';
				 end if ;
			elsif (airplaneXPos+airPlane_width>=barrier_x_3+barrier_width_3) and (airplaneXPos<barrier_x_3+barrier_width_3) and (airplaneXPos>barrier_x_3) and auto6='0' then 
				AirplaneXPos<=AirplaneXPos + "00000000001" ;
				if airplaneXPos > barrier_x_3 + barrier_width_3  then 
					auto6<='1';
				end if;
			elsif (airplaneXPos<barrier_x_3) and (airplaneXPos+airPlane_width<barrier_x_3+barrier_width_3) and (airplaneXPos+airPlane_width > barrier_x_3) and auto6='0' then 
				AirplaneXPos<=AirplaneXPos - "00000000001" ;
				if airplaneXPos +airPlane_width < barrier_x_3  then 
					auto6<='1';
				end if;
			else 
				auto6<='1' ;
			end if ;
	end if ;
	
	if auto6='1' and (airplaneYPos+airPlane_width <barrier_y_3) then 
		auto3<='0';
		auto4<='0';
		auto5<='0';
		auto6<='0';
	end if ;
		
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
	
	hit<='0';
	
	if key_air(3)='0' and finishPrime='0' and start3='1' and start_t='0' and sw_r(1)='1' and sw_r(0)='0'  then 
		Tir_x<=airplaneXPos+to_unsigned(10,11) ;
		Tir_y<=airplaneYPos-to_unsigned(8,9) ;
		start_T<='1' ;
		hit<='0' ;
	end if ;
				
	if start_T='1'  then 
		
		prescaler11<=prescaler11+1;
				
		if prescaler11="11000011010100000"  then 
			Tir_y<=tir_y-1;
			if tir_y="000000000" then 
				start_t<='0' ;
			end if ;
			if ( (tir_y<barrier_y+side_of_barrier and tir_y>barrier_y) and ((tir_x<barrier_x+barrier_width and tir_x>barrier_x) or (tir_x+to_unsigned(8,11)>barrier_x and tir_x+to_unsigned(8,11)<barrier_x+barrier_width)) and start_t_1='0' ) OR ( (tir_y<barrier_y_1+side_of_barrier and tir_y>barrier_y_1) and ((tir_x<barrier_x_1+barrier_width_1 and tir_x>barrier_x_1) or (tir_x+to_unsigned(8,11)>barrier_x_1 and tir_x+to_unsigned(8,11)<barrier_x_1+barrier_width_1)) and start_t_2='0' ) OR ( (tir_y<barrier_y_2+side_of_barrier and tir_y>barrier_y_2) and ((tir_x<barrier_x_2+barrier_width_2 and tir_x>barrier_x_2) or (tir_x+to_unsigned(8,11)>barrier_x_2 and tir_x+to_unsigned(8,11)<barrier_x_2+barrier_width_2))and start_t_3='0' )OR ( (tir_y<barrier_y_3+side_of_barrier and tir_y>barrier_y_3) and ((tir_x<barrier_x_3+barrier_width_3 and tir_x>barrier_x_3) or (tir_x+to_unsigned(8,11)>barrier_x_3 and tir_x+to_unsigned(8,11)<barrier_x_3+barrier_width_3)) and start_t_4='0' )OR ( (tir_y<output_ran_y+side_of_barrier and tir_y>output_ran_y) and ((tir_x<output_ran_x+width_of_barrier and tir_x>output_ran_x) or (tir_x+to_unsigned(8,11)>output_ran_x and tir_x+to_unsigned(8,11)<width_of_barrier+output_ran_x)) and start_t_5='0' ) OR  ((tir_y<output_ran_y_1+side_of_barrier and tir_y>output_ran_y_1) and ((tir_x<output_ran_x_1+width_of_barrier_1 and tir_x>output_ran_x_1) or (tir_x+to_unsigned(8,11)>output_ran_x_1 and tir_x+to_unsigned(8,11)<width_of_barrier_1+output_ran_x_1)) and start_t_6='0' ) OR  ((tir_y<output_ran_y_2+side_of_barrier and tir_y>output_ran_y_2) and ((tir_x<output_ran_x_2+width_of_barrier_2 and tir_x>output_ran_x_2) or (tir_x+to_unsigned(8,11)>output_ran_x_2 and tir_x+to_unsigned(8,11)<width_of_barrier_2+output_ran_x_2)) and start_t_7='0' )  then hit<='1' ; start_t<='0';  --Add the first three barriers 
			end if;
			
			if ( (tir_y<barrier_y+side_of_barrier and tir_y>barrier_y) and ((tir_x<barrier_x+barrier_width and tir_x>barrier_x) or (tir_x+to_unsigned(8,11)>barrier_x and tir_x+to_unsigned(8,11)<barrier_x+barrier_width)) ) then start_t_1 <='1' ; 
			end if ;
			
			if ( (tir_y<barrier_y_1+side_of_barrier and tir_y>barrier_y_1) and ((tir_x<barrier_x_1+barrier_width_1 and tir_x>barrier_x_1) or (tir_x+to_unsigned(8,11)>barrier_x_1 and tir_x+to_unsigned(8,11)<barrier_x_1+barrier_width_1)) ) then start_t_2<='1' ; 
			end if ;
			
			if ( (tir_y<barrier_y_2+side_of_barrier and tir_y>barrier_y_2) and ((tir_x<barrier_x_2+barrier_width_2 and tir_x>barrier_x_2) or (tir_x+to_unsigned(8,11)>barrier_x_2 and tir_x+to_unsigned(8,11)<barrier_x_2+barrier_width_2)) ) then start_t_3<='1' ;
			end if ;
			
			if ( (tir_y<barrier_y_3+side_of_barrier and tir_y>barrier_y_3) and ((tir_x<barrier_x_3+barrier_width_3 and tir_x>barrier_x_3) or (tir_x+to_unsigned(8,11)>barrier_x_3 and tir_x+to_unsigned(8,11)<barrier_x_3+barrier_width_3)) )  then start_t_4<='1' ;
			end if ;
			
			if ( (tir_y<output_ran_y+side_of_barrier and tir_y>output_ran_y) and ((tir_x<output_ran_x+width_of_barrier and tir_x>output_ran_x) or (tir_x+to_unsigned(8,11)>output_ran_x and tir_x+to_unsigned(8,11)<width_of_barrier+output_ran_x)) ) then start_t_5<='1' ;
			end if ;
			
			if ( (tir_y<output_ran_y_1+side_of_barrier and tir_y>output_ran_y_1) and ((tir_x<output_ran_x_1+width_of_barrier_1 and tir_x>output_ran_x_1) or (tir_x+to_unsigned(8,11)>output_ran_x_1 and tir_x+to_unsigned(8,11)<width_of_barrier_1+output_ran_x_1)) ) then start_t_6<='1' ;
			end if ;
			
			if ( (tir_y<output_ran_y_2+side_of_barrier and tir_y>output_ran_y_2) and ((tir_x<output_ran_x_2+width_of_barrier_2 and tir_x>output_ran_x_2) or (tir_x+to_unsigned(8,11)>output_ran_x_2 and tir_x+to_unsigned(8,11)<width_of_barrier_2+output_ran_x_2))) then start_t_7<='1' ;
			end if ;
			
			prescaler11<=(others=>'0');
		end if ;
	
	end if ;


	if barrier_y=to_unsigned(479,9)  then 
		start_t_1<='0' ;
	end if ;
			
	if barrier_y_1=to_unsigned(479,9)  then 
		start_t_2<='0' ;
	end if ;
	
	if barrier_y_2=to_unsigned(479,9)  then 
		start_t_3<='0' ;
	end if ;
	
	if barrier_y_3=to_unsigned(479,9)  then 
		start_t_4<='0' ;
	end if ;
	
	if output_ran_y= to_unsigned(479,9) then 
		start_t_5<='1' ;
	end if ;
	
	if output_ran_y_1= to_unsigned(479,9) then 
		start_t_6<='1' ;
	end if ;
	
	if output_ran_y_2= to_unsigned(479,9) then 
		start_t_7<='1' ;
	end if ;
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
	if time_Game = "111011100110101100101000000000" then
		prescaler14<=(others=>'0');
	elsif time_game = "01110111001101011001010000000000" then
		prescaler14<=(others=>'0');
	end if;
	
	
	if prescaler14="0000000000001001001001111100000" and  speed="0000000000001001001001111100000"  and sw_R(1)='0'   then
		
		if  ( (output_ran_y=airplaneYPos+airPlane_width) or  (output_ran_y_1=airplaneYPos+airPlane_width) or (output_ran_y_2=airplaneYPos+airPlane_width) or (barrier_y+barrier_width=airplaneYPos+airPlane_width) or  (			 barrier_y_1+barrier_width_1=airplaneYPos+airPlane_width) or (barrier_y_2+barrier_width_2=airplaneYPos+airPlane_width) or (barrier_y_3+barrier_width_3=airplaneYPos+airPlane_width) )   then 
			score<=score+1; 
		end if ;
		prescaler14<=(others=>'0');
	end if ;

------------------------------------------------------------------------------------------------------------
	
	if prescaler14="0000000000000110000110101000000" and speed="0000000000000110000110101000000" and sw_R(1)='0'   then
		
		if  ( (output_ran_y=airplaneYPos+airPlane_width) or  (output_ran_y_1=airplaneYPos+airPlane_width) or (output_ran_y_2=airplaneYPos+airPlane_width) or (barrier_y+barrier_width=airplaneYPos+airPlane_width) or  (			 barrier_y_1+barrier_width_1=airplaneYPos+airPlane_width) or (barrier_y_2+barrier_width_2=airplaneYPos+airPlane_width) or (barrier_y_3+barrier_width_3=airplaneYPos+airPlane_width) )   then 
			score<=score+1; 
		end if ;
		prescaler14<=(others=>'0');
	end if ;
		
------------------------------------------------------------------------------------------------------------
		
	if prescaler14="0000000000000100100100111110000" and speed="0000000000000100100100111110000"  and sw_R(1)='0'      then
		
		if  ( (output_ran_y=airplaneYPos+airPlane_width) or  (output_ran_y_1=airplaneYPos+airPlane_width) or (output_ran_y_2=airplaneYPos+airPlane_width) or (barrier_y+barrier_width=airplaneYPos+airPlane_width) or  (			 barrier_y_1+barrier_width_1=airplaneYPos+airPlane_width) or (barrier_y_2+barrier_width_2=airplaneYPos+airPlane_width) or (barrier_y_3+barrier_width_3=airplaneYPos+airPlane_width) )   then 
			score<=score+1; 
		end if ;
		prescaler14<=(others=>'0');
	end if ;
	
	
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
if hit='1' and sw_r(1)='1' then 
	score<=score+1;
end if ;
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
	if  score=to_unsigned(60,7) and sw_r(1)='0' then      
		finish_2<='1' ;
	end if ;
	
	if  score=to_unsigned(20,7) and sw_r(1)='1' then      
		finish_2<='1' ;
	end if ;
	
end if;
end process;
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
process(clk_50MHz,RESET)
function lfsr33(x : unsigned(31 downto 0)) return unsigned is
begin
return x(30 downto 0) & (x(0) xnor x(1) xnor x(21) xnor x(31));
end function;

begin
if reset='1' then 
	barrier_x<=(others=>'0');
	length_seperate<=(others=>'0');
	Prescaler3 <= (others =>'0') ;
	prescaler4<=(others=>'0') ;
	barrier_y<=(others=>'0') ;
	start27<='0';
	
	barrier_x_1<=(others=>'0');
	length_seperate_1<=(others=>'0');
	Prescaler5 <= (others =>'0') ;
	prescaler6<=(others=>'0') ;
	barrier_y_1<=(others=>'0') ;
	start28<='0';
	
	barrier_x_2<=(others=>'0');
	length_seperate_2<=(others=>'0');
	Prescaler7 <= (others =>'0') ;
	prescaler8<=(others=>'0') ;
	barrier_y_2<=(others=>'0') ;
	start29<='0';
	
	barrier_x_3<=(others=>'0');
	length_seperate_3<=(others=>'0');
	Prescaler9 <= (others =>'0') ;
	prescaler10<=(others=>'0') ;
	barrier_y_3<=(others=>'0') ;
	start30<='0';
	
	start27_1<='0';
	start28_1<='0';
	start29_1<='0';
	start30_1<='0';
	speed<=(others=>'0');

elsif rising_edge (clk_50MHz) then 
	
	pseudo_rand_1  <= lfsr33(pseudo_rand_1);
	length_seperate<= pseudo_rand_1(3 downto 0);
	length_seperate_1<= pseudo_rand_1(6 downto 3);
	length_seperate_2<= pseudo_rand_1(5 downto 2);
	length_seperate_3<= pseudo_rand_1(4 downto 1);
	
	if start27='0' and start3='1' and finishPrime='0' then 
		prescaler3<=prescaler3+"00000000001" ;
		if (prescaler3="10001111000011010001100000" OR start27_1='1' ) and start3='1' then 
			barrier_x_width<=pseudo_rand_1(9 downto 8) ;
			barrier_y<=to_unsigned(510,9);
			case length_seperate is 
				when to_unsigned(0,4) => barrier_x <=to_unsigned(91,11);
				when to_unsigned(1,4) => barrier_x <= to_unsigned(113,11);
				when to_unsigned(2,4) => barrier_x  <= to_unsigned(136,11);
				when to_unsigned(3,4) => barrier_x  <= to_unsigned(159,11);
				when to_unsigned(4,4) => barrier_x  <= to_unsigned(182,11);
				when to_unsigned(5,4) => barrier_x  <= to_unsigned(205,11);
				when to_unsigned(6,4) => barrier_x  <= to_unsigned(440,11);
				when to_unsigned(7,4) => barrier_x  <= to_unsigned(251,11);
				when to_unsigned(8,4) => barrier_x  <= to_unsigned(274,11);
				when to_unsigned(9,4) => barrier_x  <= to_unsigned(460,11);
				when to_unsigned(10,4)=> barrier_x  <= to_unsigned(320,11);
				when to_unsigned(11,4)=> barrier_x  <= to_unsigned(343,11);
				when to_unsigned(12,4)=> barrier_x  <= to_unsigned(366,11);
				when to_unsigned(13,4)=> barrier_x  <= to_unsigned(389,11);
				when to_unsigned(14,4)=> barrier_x  <= to_unsigned(412,11);
				when to_unsigned(15,4)=> barrier_x  <= to_unsigned(435,11);	
			end case ;
			prescaler3<=(others=>'0');
			start27<='1';
		end if ;
	end if;
	
	if start27='1' and finishPrime='0' then 
		Prescaler4 <= Prescaler4 + "00000000001";
		if prescaler4=speed and FinishPrime='0' then 
			barrier_y<=barrier_y+"000000001";
			prescaler4<=(others=>'0');
		end if ;
	end if;
	
	if start27='1' and barrier_y=to_unsigned(480,9) then 
		barrier_y<=to_unsigned(510,9);
		prescaler3<=(others=>'0');
		start27<='0';
		start27_1<='1';
	end if;

--------------------------------------------------------------------------------------
	
	if start28='0' and start3='1' and finishPrime='0' then 
		prescaler5<=prescaler5+"00000000001" ;
		if (prescaler5="100011110000110100011000000" or start28_1='1') and start3='1' then 
			barrier_x_width_1<=pseudo_rand_1(11 downto 10) ;
			barrier_y_1<=to_unsigned(510,9);
			case length_seperate_1 is 
				when to_unsigned(0,4) => barrier_x_1 <=to_unsigned(412,11);
				when to_unsigned(1,4) => barrier_x_1 <= to_unsigned(113,11);
				when to_unsigned(2,4) => barrier_x_1  <= to_unsigned(136,11);
				when to_unsigned(3,4) => barrier_x_1  <= to_unsigned(343,11);
				when to_unsigned(4,4) => barrier_x_1  <= to_unsigned(182,11);
				when to_unsigned(5,4) => barrier_x_1  <= to_unsigned(460,11);
				when to_unsigned(6,4) => barrier_x_1  <= to_unsigned(228,11);
				when to_unsigned(7,4) => barrier_x_1  <= to_unsigned(251,11);
				when to_unsigned(8,4) => barrier_x_1  <= to_unsigned(440,11);
				when to_unsigned(9,4) => barrier_x_1  <= to_unsigned(205,11);
				when to_unsigned(10,4)=> barrier_x_1  <= to_unsigned(320,11);
				when to_unsigned(11,4)=> barrier_x_1  <= to_unsigned(159,11);
				when to_unsigned(12,4)=> barrier_x_1  <= to_unsigned(366,11);
				when to_unsigned(13,4)=> barrier_x_1  <= to_unsigned(389,11);
				when to_unsigned(14,4)=> barrier_x_1  <= to_unsigned(91,11);
				when to_unsigned(15,4)=> barrier_x_1  <= to_unsigned(435,11);
			end case ;
			prescaler5<=(others=>'0');
			start28<='1';
		end if ;
	end if;
	
	if start28='1' and finishPrime='0' then 
		Prescaler6 <= Prescaler6 + "00000000001";
		if prescaler6=speed and FinishPrime='0' then 
			barrier_y_1<=barrier_y_1+"000000001";
			prescaler6<=(others=>'0');
		end if ;
	end if;
	
	if start28='1' and barrier_y_1=to_unsigned(480,9) then 
		barrier_y_1<=to_unsigned(510,9);
		prescaler5<=(others=>'0');
		start28<='0';
		start28_1<='1' ;
	end if;
	
-----------------------------------------------------------------------------------------

	if start29='0' and start3='1' and finishPrime='0' then 
		prescaler7<=prescaler7+"00000000001" ;
		if (prescaler7="110101101001001110100100000" or start29_1='1' ) and start3='1' then 
			barrier_x_width_2<=pseudo_rand_1(6) & pseudo_rand_1(2)  ;
			barrier_y_2<=to_unsigned(510,9);
			case length_seperate_2 is 
				when to_unsigned(0,4) => barrier_x_2 <=to_unsigned(412,11);
				when to_unsigned(1,4) => barrier_x_2 <= to_unsigned(389,11);
				when to_unsigned(2,4) => barrier_x_2  <= to_unsigned(228,11);
				when to_unsigned(3,4) => barrier_x_2  <= to_unsigned(343,11);
				when to_unsigned(4,4) => barrier_x_2  <= to_unsigned(182,11);
				when to_unsigned(5,4) => barrier_x_2  <= to_unsigned(297,11);
				when to_unsigned(6,4) => barrier_x_2  <= to_unsigned(136,11);
				when to_unsigned(7,4) => barrier_x_2  <= to_unsigned(460,11);
				when to_unsigned(8,4) => barrier_x_2  <= to_unsigned(274,11);
				when to_unsigned(9,4) => barrier_x_2  <= to_unsigned(205,11);
				when to_unsigned(10,4)=> barrier_x_2  <= to_unsigned(320,11);
				when to_unsigned(11,4)=> barrier_x_2  <= to_unsigned(450,11);
				when to_unsigned(12,4)=> barrier_x_2  <= to_unsigned(366,11);
				when to_unsigned(13,4)=> barrier_x_2  <= to_unsigned(113,11);
				when to_unsigned(14,4)=> barrier_x_2  <= to_unsigned(91,11);
				when to_unsigned(15,4)=> barrier_x_2  <= to_unsigned(435,11);
			end case ;
			prescaler7<=(others=>'0');
			start29<='1';
		end if ;
	end if;
	
	if start29='1' and finishPrime='0' then 
		prescaler8 <= prescaler8 + "00000000001";
		if prescaler8=speed and FinishPrime='0' then 
			barrier_y_2<=barrier_y_2+"000000001";
			prescaler8<=(others=>'0');
		end if ;
	end if;
	
	if start29='1' and barrier_y_2=to_unsigned(480,9) then 
		barrier_y_2<=to_unsigned(510,9);
		prescaler7<=(others=>'0');
		start29<='0';
		start29_1<='1';
	end if;
----------------------------------------------------------------------------------
	if start30='0' and start3='1' and finishPrime='0' then 
		prescaler9<=prescaler9+"00000000001" ;
		if (prescaler9="1000111100001101000110000000" or start30_1='1') and start3='1' then 
			barrier_x_width_3<=pseudo_rand_1(1) & pseudo_rand_1(4)  ;
			barrier_y_3<=to_unsigned(510,9);
			case length_seperate_3 is 
				when to_unsigned(0,4) => barrier_x_3 <=to_unsigned(412,11);
				when to_unsigned(1,4) => barrier_x_3 <= to_unsigned(389,11);
				when to_unsigned(2,4) => barrier_x_3  <= to_unsigned(228,11);
				when to_unsigned(3,4) => barrier_x_3  <= to_unsigned(343,11);
				when to_unsigned(4,4) => barrier_x_3  <= to_unsigned(182,11);
				when to_unsigned(5,4) => barrier_x_3  <= to_unsigned(448,11);
				when to_unsigned(6,4) => barrier_x_3  <= to_unsigned(136,11);
				when to_unsigned(7,4) => barrier_x_3  <= to_unsigned(251,11);
				when to_unsigned(8,4) => barrier_x_3  <= to_unsigned(274,11);
				when to_unsigned(9,4) => barrier_x_3  <= to_unsigned(460,11);
				when to_unsigned(10,4)=> barrier_x_3  <= to_unsigned(320,11);
				when to_unsigned(11,4)=> barrier_x_3  <= to_unsigned(159,11);
				when to_unsigned(12,4)=> barrier_x_3  <= to_unsigned(366,11);
				when to_unsigned(13,4)=> barrier_x_3  <= to_unsigned(113,11);
				when to_unsigned(14,4)=> barrier_x_3  <= to_unsigned(91,11);
				when to_unsigned(15,4)=> barrier_x_3  <= to_unsigned(435,11);		
			end case ;
			prescaler9<=(others=>'0');
			start30<='1';
		end if ;
	end if;
	
	if start30='1' and finishPrime='0' then 
		prescaler10 <= prescaler10 + "00000000001";
		if prescaler10=speed and FinishPrime='0' then 
			barrier_y_3<=barrier_y_3+"000000001";
			prescaler10<=(others=>'0');
		end if ;
	end if;
	
	if start30='1' and barrier_y_3=to_unsigned(480,9) then 
		barrier_y_3<=to_unsigned(510,9);
		prescaler9<=(others=>'0');
		start30<='0';
		start30_1<='1';
	end if;
	
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
	if time_Game <= "111011100110101100101000000000" then
		speed <= "0000000000001001001001111100000";
		
	elsif time_game <= "01110111001101011001010000000000" and time_Game > "111011100110101100101000000000" then
		speed <= "0000000000000110000110101000000";
		
	elsif time_Game > "01110111001101011001010000000000" then
		speed <= "0000000000000100100100111110000";
		
	end if;
	
	if time_Game = "111011100110101100101000000000" then
		prescaler4<=(others=>'0');
		prescaler6<=(others=>'0');
		prescaler8<=(others=>'0');
		prescaler10<=(others=>'0');
	elsif time_game = "01110111001101011001010000000000" then
		prescaler4<=(others=>'0');
		prescaler6<=(others=>'0');
		prescaler8<=(others=>'0');
		prescaler10<=(others=>'0');
	end if;
	
end if ;
end process;
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
process(clk_50MHz,RESET)
begin

	if reset='1' then 
		Time_Game<=(others=>'0');
		finish_1<='0';
	elsif rising_edge (clk_50MHz) then
		
	if start3='1' and FinishPrime='0' then
		time_Game<=time_Game+1;
		if time_Game="10110010110100000101111000000000" then 
			Finish_1<='1';
		end if ;
	end if ;
	
end if;
end process;
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
end Behavioral;