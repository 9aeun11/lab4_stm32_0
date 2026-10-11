set root [file normalize [file dirname [info script]]]
if {[llength $argv] != 1} {
    error "Usage: verify_one.tcl mult_4bit|bcd_conv"
}
set name [lindex $argv 0]
if {$name ni {mult_4bit bcd_conv}} {
    error "Unknown FPGA lab: $name"
}

open_project [file join $root $name "$name.xpr"]
set design_top [get_property top [get_filesets sources_1]]
set sim_top [get_property top [get_filesets sim_1]]
puts "VERIFY_PROJECT $name"
puts "DESIGN_TOP $design_top"
puts "SIM_TOP $sim_top"
if {$design_top ne $name || $sim_top ne "tb"} {
    error "Unexpected top module for $name"
}
launch_simulation -simset sim_1 -mode behavioral
run all
close_sim
close_project
