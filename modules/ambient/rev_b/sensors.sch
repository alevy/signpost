EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:lab11_adc
LIBS:lab11_battery_chargers
LIBS:lab11_buffers
LIBS:lab11_comparators
LIBS:lab11_connectors
LIBS:lab11_diodes
LIBS:lab11_ldo
LIBS:lab11_level_shifters
LIBS:lab11_mcu
LIBS:lab11_memory
LIBS:lab11_microphones
LIBS:lab11_nucleum
LIBS:lab11_opamps
LIBS:lab11_receptacles
LIBS:lab11_rlc
LIBS:lab11_switches
LIBS:lab11_transistors
LIBS:lab11_voltage_references
LIBS:lab11_sensors
LIBS:lab11_crystals
LIBS:ambient-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ISL29035 U5
U 1 1 57E99A0E
P 3850 2050
F 0 "U5" H 3700 2300 60  0000 C CNN
F 1 "ISL29035" H 3850 1800 60  0000 C CNN
F 2 "lab11-ic:L6_1.5x1.6mm" H 3900 2450 60  0001 C CNN
F 3 "" H 3650 2350 60  0001 C CNN
	1    3850 2050
	1    0    0    -1  
$EndComp
$Comp
L Si7021 U7
U 1 1 57E99AE2
P 6650 2000
F 0 "U7" H 6450 2200 60  0000 C CNN
F 1 "Si7021" H 6650 1850 60  0000 C CNN
F 2 "lab11-ic:DFN_3x3mm_1mm" H 6650 2500 60  0001 C CNN
F 3 "" H 6450 2250 60  0001 C CNN
F 4 "Digikey" H 6700 2600 60  0001 C CNN "Vendor 1"
F 5 "336-3140-5-ND" H 6650 2400 60  0001 C CNN "Vendor 1 Part Number"
	1    6650 2000
	1    0    0    -1  
$EndComp
$Comp
L TSL2561 U8
U 1 1 57E99B39
P 6700 4150
F 0 "U8" H 6400 4350 60  0000 C CNN
F 1 "TSL2561" H 6650 3850 60  0000 C CNN
F 2 "lab11-ic:DFN2" H 6550 4450 60  0001 C CNN
F 3 "" H 6300 4350 60  0001 C CNN
	1    6700 4150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 57E99DBC
P 6100 2050
F 0 "#PWR021" H 6100 1800 50  0001 C CNN
F 1 "GND" H 6100 1900 50  0000 C CNN
F 2 "" H 6100 2050 50  0000 C CNN
F 3 "" H 6100 2050 50  0000 C CNN
	1    6100 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR022
U 1 1 57E99EB4
P 6050 4350
F 0 "#PWR022" H 6050 4100 50  0001 C CNN
F 1 "GND" H 6050 4200 50  0000 C CNN
F 2 "" H 6050 4350 50  0000 C CNN
F 3 "" H 6050 4350 50  0000 C CNN
	1    6050 4350
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR023
U 1 1 57E99F26
P 6150 3350
F 0 "#PWR023" H 6150 3200 50  0001 C CNN
F 1 "+3.3V" H 6150 3490 50  0000 C CNN
F 2 "" H 6150 3350 50  0000 C CNN
F 3 "" H 6150 3350 50  0000 C CNN
	1    6150 3350
	1    0    0    -1  
$EndComp
$Comp
L C_0.1u_0402_10V_10%_JB C14
U 1 1 57E99FBE
P 6300 3500
F 0 "C14" H 6325 3600 50  0000 L CNN
F 1 "C_0.1u_0402_10V_10%_JB" H 5850 4250 50  0001 L CNN
F 2 "Capacitors_SMD:C_0402" H 6350 4000 50  0001 C CNN
F 3 "" H 6325 3600 50  0000 C CNN
F 4 "0.1uF" H 6425 3400 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 6325 4075 60  0001 C CNN "Vendor 1"
F 6 "445-10894-1-ND" H 6325 4150 60  0001 C CNN "Vendor 1 Part Number"
	1    6300 3500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR024
U 1 1 57E9A0E4
P 6300 3700
F 0 "#PWR024" H 6300 3450 50  0001 C CNN
F 1 "GND" H 6300 3550 50  0000 C CNN
F 2 "" H 6300 3700 50  0000 C CNN
F 3 "" H 6300 3700 50  0000 C CNN
	1    6300 3700
	1    0    0    -1  
$EndComp
Text GLabel 7400 4050 2    60   Input ~ 0
SDA
Text GLabel 7400 4350 2    60   Input ~ 0
SCL
Text HLabel 7400 4200 2    60   Input ~ 0
TSL_INT
Text GLabel 6100 1900 0    60   Input ~ 0
SDA
Text GLabel 7150 1900 2    60   Input ~ 0
SCL
$Comp
L +3.3V #PWR025
U 1 1 57E9AC3D
P 7600 1950
F 0 "#PWR025" H 7600 1800 50  0001 C CNN
F 1 "+3.3V" H 7600 2090 50  0000 C CNN
F 2 "" H 7600 1950 50  0000 C CNN
F 3 "" H 7600 1950 50  0000 C CNN
	1    7600 1950
	1    0    0    -1  
$EndComp
$Comp
L C_0.1u_0402_10V_10%_JB C15
U 1 1 57E9AC92
P 7600 2200
F 0 "C15" H 7625 2300 50  0000 L CNN
F 1 "C_0.1u_0402_10V_10%_JB" H 7150 2950 50  0001 L CNN
F 2 "Capacitors_SMD:C_0402" H 7650 2700 50  0001 C CNN
F 3 "" H 7625 2300 50  0000 C CNN
F 4 "0.1uF" H 7725 2100 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 7625 2775 60  0001 C CNN "Vendor 1"
F 6 "445-10894-1-ND" H 7625 2850 60  0001 C CNN "Vendor 1 Part Number"
	1    7600 2200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR026
U 1 1 57E9ACD8
P 7600 2400
F 0 "#PWR026" H 7600 2150 50  0001 C CNN
F 1 "GND" H 7600 2250 50  0000 C CNN
F 2 "" H 7600 2400 50  0000 C CNN
F 3 "" H 7600 2400 50  0000 C CNN
	1    7600 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR027
U 1 1 57E9B1A6
P 3250 2200
F 0 "#PWR027" H 3250 1950 50  0001 C CNN
F 1 "GND" H 3250 2050 50  0000 C CNN
F 2 "" H 3250 2200 50  0000 C CNN
F 3 "" H 3250 2200 50  0000 C CNN
	1    3250 2200
	1    0    0    -1  
$EndComp
$Comp
L C_0.1u_0402_10V_10%_JB C11
U 1 1 57E9B20D
P 3250 1700
F 0 "C11" H 3150 1800 50  0000 L CNN
F 1 "C_0.1u_0402_10V_10%_JB" H 2800 2450 50  0001 L CNN
F 2 "Capacitors_SMD:C_0402" H 3300 2200 50  0001 C CNN
F 3 "" H 3275 1800 50  0000 C CNN
F 4 "0.1uF" H 3100 1600 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 3275 2275 60  0001 C CNN "Vendor 1"
F 6 "445-10894-1-ND" H 3275 2350 60  0001 C CNN "Vendor 1 Part Number"
	1    3250 1700
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR028
U 1 1 57E9B285
P 3250 1500
F 0 "#PWR028" H 3250 1350 50  0001 C CNN
F 1 "+3.3V" H 3250 1640 50  0000 C CNN
F 2 "" H 3250 1500 50  0000 C CNN
F 3 "" H 3250 1500 50  0000 C CNN
	1    3250 1500
	1    0    0    -1  
$EndComp
Text GLabel 4400 1900 2    60   Input ~ 0
SDA
Text GLabel 4400 2050 2    60   Input ~ 0
SCL
Text HLabel 4400 2200 2    60   Input ~ 0
ISL29035_INT
$Comp
L GND #PWR029
U 1 1 57E9C883
P 3850 4750
F 0 "#PWR029" H 3850 4500 50  0001 C CNN
F 1 "GND" H 3850 4600 50  0000 C CNN
F 2 "" H 3850 4750 50  0000 C CNN
F 3 "" H 3850 4750 50  0000 C CNN
	1    3850 4750
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR030
U 1 1 57E9CCBD
P 3850 2850
F 0 "#PWR030" H 3850 2700 50  0001 C CNN
F 1 "+3.3V" H 3850 2990 50  0000 C CNN
F 2 "" H 3850 2850 50  0000 C CNN
F 3 "" H 3850 2850 50  0000 C CNN
	1    3850 2850
	1    0    0    -1  
$EndComp
$Comp
L C_0.1u_0402_10V_10%_JB C12
U 1 1 57E9CD80
P 3950 3000
F 0 "C12" H 3975 3100 50  0000 L CNN
F 1 "C_0.1u_0402_10V_10%_JB" H 3500 3750 50  0001 L CNN
F 2 "Capacitors_SMD:C_0402" H 4000 3500 50  0001 C CNN
F 3 "" H 3975 3100 50  0000 C CNN
F 4 "0.1uF" H 4075 2900 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 3975 3575 60  0001 C CNN "Vendor 1"
F 6 "445-10894-1-ND" H 3975 3650 60  0001 C CNN "Vendor 1 Part Number"
	1    3950 3000
	1    0    0    -1  
$EndComp
$Comp
L C_10u_0603_10V_10%_JB C13
U 1 1 57E9CE6A
P 4300 3000
F 0 "C13" H 4325 3100 50  0000 L CNN
F 1 "C_10u_0603_10V_10%_JB" H 3850 3600 50  0001 L CNN
F 2 "Capacitors_SMD:C_0603" H 4350 3350 50  0001 C CNN
F 3 "" H 4325 3100 50  0000 C CNN
F 4 "10uF" H 4425 2900 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 4325 3425 60  0001 C CNN "Vendor 1"
F 6 "445-11201-1-ND" H 4325 3500 60  0001 C CNN "Vendor 1 Part Number"
	1    4300 3000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR031
U 1 1 57E9CF4F
P 4150 3200
F 0 "#PWR031" H 4150 2950 50  0001 C CNN
F 1 "GND" H 4150 3050 50  0000 C CNN
F 2 "" H 4150 3200 50  0000 C CNN
F 3 "" H 4150 3200 50  0000 C CNN
	1    4150 3200
	1    0    0    -1  
$EndComp
Text GLabel 3150 3850 0    60   Input ~ 0
SDA
Text GLabel 3150 3700 0    60   Input ~ 0
SCL
Text HLabel 4400 4000 2    60   Input ~ 0
LPS_INT1
Text HLabel 4400 4150 2    60   Input ~ 0
LPS_INT2
$Comp
L +3.3V #PWR032
U 1 1 57E9E73A
P 2700 4000
F 0 "#PWR032" H 2700 3850 50  0001 C CNN
F 1 "+3.3V" H 2700 4140 50  0000 C CNN
F 2 "" H 2700 4000 50  0000 C CNN
F 3 "" H 2700 4000 50  0000 C CNN
	1    2700 4000
	1    0    0    -1  
$EndComp
$Comp
L LPS25HB U1
U 1 1 57FF4756
P 2400 6050
F 0 "U1" H 2150 6300 60  0000 C CNN
F 1 "LPS25HB" H 2350 5700 60  0000 C CNN
F 2 "lab11-ic:HLGA-10L_2.5x2.5mm" H 2400 6650 60  0001 C CNN
F 3 "" H 1550 6300 60  0001 C CNN
F 4 "Digikey" H 2400 6450 60  0001 C CNN "Vendor 1"
F 5 "497-15070-1-ND" H 2450 6550 60  0001 C CNN "Vendor 1 Part Number"
	1    2400 6050
	1    0    0    -1  
$EndComp
$Comp
L LPS35HW U3
U 1 1 57FF47C7
P 6250 5850
F 0 "U3" H 6000 6100 60  0000 C CNN
F 1 "LPS35HW" H 6200 5500 60  0000 C CNN
F 2 "lab11-ic:CCLGA-10L_3.5x3.5mm" H 6250 6450 60  0001 C CNN
F 3 "" H 5400 6100 60  0001 C CNN
F 4 "Digikey" H 6250 6250 60  0001 C CNN "Vendor 1"
F 5 "497-16706-1-ND" H 6300 6350 60  0001 C CNN "Vendor 1 Part Number"
	1    6250 5850
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR033
U 1 1 57FF4D30
P 1200 5850
F 0 "#PWR033" H 1200 5700 50  0001 C CNN
F 1 "+3.3V" H 1200 5990 50  0000 C CNN
F 2 "" H 1200 5850 50  0000 C CNN
F 3 "" H 1200 5850 50  0000 C CNN
	1    1200 5850
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR034
U 1 1 57FF4E62
P 5150 5650
F 0 "#PWR034" H 5150 5500 50  0001 C CNN
F 1 "+3.3V" H 5150 5790 50  0000 C CNN
F 2 "" H 5150 5650 50  0000 C CNN
F 3 "" H 5150 5650 50  0000 C CNN
	1    5150 5650
	1    0    0    -1  
$EndComp
$Comp
L C_0.1u_0402_10V_10%_JB C17
U 1 1 57FF50DE
P 1550 6050
F 0 "C17" H 1575 6150 50  0000 L CNN
F 1 "C_0.1u_0402_10V_10%_JB" H 1100 6800 50  0001 L CNN
F 2 "Capacitors_SMD:C_0402" H 1600 6550 50  0001 C CNN
F 3 "" H 1575 6150 50  0000 C CNN
F 4 "0.1uF" H 1675 5950 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 1575 6625 60  0001 C CNN "Vendor 1"
F 6 "445-10894-1-ND" H 1575 6700 60  0001 C CNN "Vendor 1 Part Number"
	1    1550 6050
	1    0    0    -1  
$EndComp
$Comp
L C_0.1u_0402_10V_10%_JB C18
U 1 1 57FF51DA
P 5150 5850
F 0 "C18" H 5175 5950 50  0000 L CNN
F 1 "C_0.1u_0402_10V_10%_JB" H 4700 6600 50  0001 L CNN
F 2 "Capacitors_SMD:C_0402" H 5200 6350 50  0001 C CNN
F 3 "" H 5175 5950 50  0000 C CNN
F 4 "0.1uF" H 5275 5750 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 5175 6425 60  0001 C CNN "Vendor 1"
F 6 "445-10894-1-ND" H 5175 6500 60  0001 C CNN "Vendor 1 Part Number"
	1    5150 5850
	1    0    0    -1  
$EndComp
$Comp
L C_10u_0603_10V_10%_JB C19
U 1 1 57FF5230
P 5400 5850
F 0 "C19" H 5425 5950 50  0000 L CNN
F 1 "C_10u_0603_10V_10%_JB" H 4950 6450 50  0001 L CNN
F 2 "Capacitors_SMD:C_0603" H 5450 6200 50  0001 C CNN
F 3 "" H 5425 5950 50  0000 C CNN
F 4 "10uF" H 5525 5750 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 5425 6275 60  0001 C CNN "Vendor 1"
F 6 "445-11201-1-ND" H 5425 6350 60  0001 C CNN "Vendor 1 Part Number"
	1    5400 5850
	1    0    0    -1  
$EndComp
$Comp
L C_10u_0603_10V_10%_JB C16
U 1 1 57FF528E
P 1200 6050
F 0 "C16" H 1225 6150 50  0000 L CNN
F 1 "C_10u_0603_10V_10%_JB" H 750 6650 50  0001 L CNN
F 2 "Capacitors_SMD:C_0603" H 1250 6400 50  0001 C CNN
F 3 "" H 1225 6150 50  0000 C CNN
F 4 "10uF" H 1325 5950 60  0000 C CNN "Capacitance"
F 5 "Digikey" H 1225 6475 60  0001 C CNN "Vendor 1"
F 6 "445-11201-1-ND" H 1225 6550 60  0001 C CNN "Vendor 1 Part Number"
	1    1200 6050
	1    0    0    -1  
$EndComp
Text GLabel 2950 6000 2    60   Input ~ 0
SDA
Text GLabel 2950 5900 2    60   Input ~ 0
SCL
$Comp
L GND #PWR035
U 1 1 57FF5FED
P 1400 6300
F 0 "#PWR035" H 1400 6050 50  0001 C CNN
F 1 "GND" H 1400 6150 50  0000 C CNN
F 2 "" H 1400 6300 50  0000 C CNN
F 3 "" H 1400 6300 50  0000 C CNN
	1    1400 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 4350 6050 4350
Wire Wire Line
	6150 4050 6150 3350
Wire Wire Line
	6150 3350 6300 3350
Wire Wire Line
	6300 3650 6300 3700
Wire Wire Line
	6150 4200 6050 4200
Wire Wire Line
	6050 4200 6050 4350
Wire Wire Line
	7200 4050 7400 4050
Wire Wire Line
	7200 4350 7400 4350
Wire Wire Line
	7200 4200 7400 4200
Wire Wire Line
	7050 1900 7150 1900
Wire Wire Line
	6100 1900 6200 1900
Wire Wire Line
	6200 2050 6100 2050
Wire Wire Line
	7050 2050 7600 2050
Wire Wire Line
	7600 2050 7600 1950
Wire Wire Line
	7600 2350 7600 2400
Wire Wire Line
	3450 2050 3250 2050
Wire Wire Line
	3250 1850 3250 2200
Wire Wire Line
	3450 1900 3450 1550
Wire Wire Line
	3450 1550 3250 1550
Wire Wire Line
	3250 1550 3250 1500
Connection ~ 3250 2050
Wire Wire Line
	4300 2200 4400 2200
Wire Wire Line
	4300 2050 4400 2050
Wire Wire Line
	4300 1900 4400 1900
Wire Wire Line
	3650 4650 3650 4750
Wire Wire Line
	3850 4750 3850 4650
Connection ~ 3850 4750
Wire Wire Line
	3750 4650 3750 4750
Wire Wire Line
	3850 3400 4050 3400
Connection ~ 3950 3400
Wire Wire Line
	3850 3400 3850 2850
Wire Wire Line
	3850 2850 4300 2850
Connection ~ 3950 2850
Wire Wire Line
	4150 3150 4150 3200
Wire Wire Line
	3950 3150 4300 3150
Connection ~ 4150 3150
Wire Wire Line
	3300 3850 3150 3850
Wire Wire Line
	3150 3700 3300 3700
Wire Wire Line
	4300 4150 4400 4150
Wire Wire Line
	4300 4000 4400 4000
Wire Wire Line
	3300 4000 2700 4000
Connection ~ 3650 4750
Wire Wire Line
	2850 5900 2950 5900
Wire Wire Line
	2850 6000 2950 6000
Wire Wire Line
	1200 5900 1900 5900
Connection ~ 1550 5900
Wire Wire Line
	1200 5850 1200 5900
Wire Wire Line
	1200 6200 1200 6300
Wire Wire Line
	1200 6300 1550 6300
Wire Wire Line
	1550 6300 1550 6200
Connection ~ 1400 6300
Wire Wire Line
	1900 6100 1900 6300
Connection ~ 1900 6200
Wire Wire Line
	1900 6300 1400 6300
Text HLabel 2950 6300 2    60   Input ~ 0
LPS25HB_INT
Wire Wire Line
	2850 6300 2950 6300
$Comp
L R_100K_0402_0.5%,25ppm/c,0.063W R11
U 1 1 57FF8BA5
P 9600 3300
F 0 "R11" H 9600 3375 50  0000 C CNN
F 1 "R_100K_0402_0.5%,25ppm/c,0.063W" H 9625 4000 50  0001 C CNN
F 2 "Resistors_SMD:R_0402" H 9600 3850 50  0001 C CNN
F 3 "http://www.susumu.co.jp/product_pdf/all-list/e_11.pdf" H 9700 3925 50  0001 C CNN
F 4 "100K" H 9625 3225 60  0000 C CNN "Resistance"
F 5 "Digikey" H 9625 3775 60  0001 C CNN "Vendor 1"
F 6 "RR05P100KDCT-ND	" H 9625 3675 60  0001 C CNN "Vendor 1 Part Number"
	1    9600 3300
	1    0    0    -1  
$EndComp
$Comp
L R_100K_0402_0.5%,25ppm/c,0.063W R12
U 1 1 57FF8C61
P 9600 3950
F 0 "R12" H 9600 4025 50  0000 C CNN
F 1 "R_100K_0402_0.5%,25ppm/c,0.063W" H 9625 4650 50  0001 C CNN
F 2 "Resistors_SMD:R_0402" H 9600 4500 50  0001 C CNN
F 3 "http://www.susumu.co.jp/product_pdf/all-list/e_11.pdf" H 9700 4575 50  0001 C CNN
F 4 "100K" H 9625 3875 60  0000 C CNN "Resistance"
F 5 "Digikey" H 9625 4425 60  0001 C CNN "Vendor 1"
F 6 "RR05P100KDCT-ND	" H 9625 4325 60  0001 C CNN "Vendor 1 Part Number"
	1    9600 3950
	1    0    0    -1  
$EndComp
Text Label 3250 6100 0    60   ~ 0
LPS25_SA0
Wire Wire Line
	2850 6100 3800 6100
Text Label 3250 6200 0    60   ~ 0
LPS25_CS
Wire Wire Line
	2850 6200 3800 6200
$Comp
L +3.3V #PWR036
U 1 1 57FF94D7
P 9400 3850
F 0 "#PWR036" H 9400 3700 50  0001 C CNN
F 1 "+3.3V" H 9400 3990 50  0000 C CNN
F 2 "" H 9400 3850 50  0000 C CNN
F 3 "" H 9400 3850 50  0000 C CNN
	1    9400 3850
	1    0    0    -1  
$EndComp
Text Label 9850 3300 0    60   ~ 0
LPS25_SA0
Text Label 9850 3950 0    60   ~ 0
LPS25_CS
Wire Wire Line
	9800 3950 10300 3950
Wire Wire Line
	9800 3300 10350 3300
$Comp
L R_100K_0402_0.5%,25ppm/c,0.063W R9
U 1 1 57FFA353
P 9550 5000
F 0 "R9" H 9550 5075 50  0000 C CNN
F 1 "R_100K_0402_0.5%,25ppm/c,0.063W" H 9575 5700 50  0001 C CNN
F 2 "Resistors_SMD:R_0402" H 9550 5550 50  0001 C CNN
F 3 "http://www.susumu.co.jp/product_pdf/all-list/e_11.pdf" H 9650 5625 50  0001 C CNN
F 4 "100K" H 9575 4925 60  0000 C CNN "Resistance"
F 5 "Digikey" H 9575 5475 60  0001 C CNN "Vendor 1"
F 6 "RR05P100KDCT-ND	" H 9575 5375 60  0001 C CNN "Vendor 1 Part Number"
	1    9550 5000
	1    0    0    -1  
$EndComp
$Comp
L R_100K_0402_0.5%,25ppm/c,0.063W R10
U 1 1 57FFA35C
P 9550 4750
F 0 "R10" H 9550 4825 50  0000 C CNN
F 1 "R_100K_0402_0.5%,25ppm/c,0.063W" H 9575 5450 50  0001 C CNN
F 2 "Resistors_SMD:R_0402" H 9550 5300 50  0001 C CNN
F 3 "http://www.susumu.co.jp/product_pdf/all-list/e_11.pdf" H 9650 5375 50  0001 C CNN
F 4 "100K" H 9575 4675 60  0000 C CNN "Resistance"
F 5 "Digikey" H 9575 5225 60  0001 C CNN "Vendor 1"
F 6 "RR05P100KDCT-ND	" H 9575 5125 60  0001 C CNN "Vendor 1 Part Number"
	1    9550 4750
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR037
U 1 1 57FFA36B
P 9350 4700
F 0 "#PWR037" H 9350 4550 50  0001 C CNN
F 1 "+3.3V" H 9350 4840 50  0000 C CNN
F 2 "" H 9350 4700 50  0000 C CNN
F 3 "" H 9350 4700 50  0000 C CNN
	1    9350 4700
	1    0    0    -1  
$EndComp
Text Label 9850 5000 0    60   ~ 0
LPS35_SA0
Text Label 9800 4750 0    60   ~ 0
LPS35_CS
Wire Wire Line
	9750 4750 10250 4750
Text GLabel 6800 5700 2    60   Input ~ 0
SCL
Text GLabel 6800 5800 2    60   Input ~ 0
SDA
Wire Wire Line
	6700 5800 6800 5800
Wire Wire Line
	6700 5700 6800 5700
Text Label 7100 5900 0    60   ~ 0
LPS35_SA0
Text Label 7100 6000 0    60   ~ 0
LPS35_CS
Wire Wire Line
	6700 5900 7600 5900
Wire Wire Line
	6700 6000 7600 6000
Text HLabel 6800 6100 2    60   Input ~ 0
LPS35_INT
Wire Wire Line
	6700 6100 6800 6100
Wire Wire Line
	5150 5700 5750 5700
Connection ~ 5400 5700
Wire Wire Line
	5150 5700 5150 5650
Wire Wire Line
	5750 5700 5750 5800
Wire Wire Line
	1900 5900 1900 6000
$Comp
L GND #PWR038
U 1 1 57FFC45A
P 5300 6100
F 0 "#PWR038" H 5300 5850 50  0001 C CNN
F 1 "GND" H 5300 5950 50  0000 C CNN
F 2 "" H 5300 6100 50  0000 C CNN
F 3 "" H 5300 6100 50  0000 C CNN
	1    5300 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 6000 5150 6100
Wire Wire Line
	5150 6100 5750 6100
Wire Wire Line
	5400 6100 5400 6000
Connection ~ 5300 6100
Wire Wire Line
	5750 6100 5750 5900
Connection ~ 5750 6000
Connection ~ 5400 6100
Wire Wire Line
	9750 5000 10350 5000
Wire Wire Line
	9350 4700 9350 5000
Connection ~ 9350 4750
Wire Wire Line
	9400 3850 9400 3950
$Comp
L GND #PWR039
U 1 1 580154DB
P 9400 3450
F 0 "#PWR039" H 9400 3200 50  0001 C CNN
F 1 "GND" H 9400 3300 50  0000 C CNN
F 2 "" H 9400 3450 50  0000 C CNN
F 3 "" H 9400 3450 50  0000 C CNN
	1    9400 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 3300 9400 3450
$Comp
L LPS331AP U6
U 1 1 57E99A91
P 3800 4000
F 0 "U6" H 3550 4450 60  0000 C CNN
F 1 "LPS331AP" V 3450 3600 60  0000 C CNN
F 2 "lab11-ic:HCLGA-16L" H 3600 4700 60  0001 C CNN
F 3 "" H 3500 4550 60  0001 C CNN
	1    3800 4000
	1    0    0    -1  
$EndComp
Connection ~ 3750 4750
Wire Wire Line
	3950 4750 3950 4650
Wire Wire Line
	3650 4750 4050 4750
Wire Wire Line
	4050 4750 4050 4650
Connection ~ 3950 4750
Wire Wire Line
	3300 4150 2750 4150
Wire Wire Line
	2750 4150 2750 4000
Connection ~ 2750 4000
$EndSCHEMATC
