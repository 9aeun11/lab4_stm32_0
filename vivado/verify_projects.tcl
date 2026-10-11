set root [file normalize [file dirname [info script]]]
foreach name {mult_4bit bcd_conv} {
    open_project [file join $root $name "$name.xpr"]
    puts "VERIFY_PROJECT $name"
    puts "DESIGN_TOP [get_property top [get_filesets sources_1]]"
    puts "SIM_TOP [get_property top [get_filesets sim_1]]"
    launch_simulation -simset sim_1 -mode behavioral
    run all
    close_sim
    close_project
}
