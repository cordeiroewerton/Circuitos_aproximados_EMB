set_db / .library {PDK_path}

read_hdl -sv {../RTL/add16se_2TN.v ../RTL/FIR.sv}

elaborate

set_db syn_generic_effort medium

syn_generic

report_area

report_power

set_db timing_report_unconstrained true

report_timing
