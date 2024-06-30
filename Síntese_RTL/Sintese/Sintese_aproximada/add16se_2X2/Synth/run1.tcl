set_db / .library {../PVT_1_80V_range/D_CELLS_HD_LPMOS_typ_1_80V_25C.lib}

read_hdl -sv {../RTL/add16se_2X2.v ../RTL/FIR.sv}

elaborate

set_db syn_generic_effort medium

syn_generic

report_area

report_power

set_db timing_report_unconstrained true

report_timing
