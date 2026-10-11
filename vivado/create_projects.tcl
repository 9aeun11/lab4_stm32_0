set root [file normalize [file dirname [info script]]]
foreach name {mult_4bit bcd_conv} {
    set dir [file normalize [file join $root $name]]
    create_project $name $dir -part xc7s75fgga484-1 -force
    set_property target_language Verilog [current_project]
    add_files -norecurse -fileset sources_1 [file join $dir src "$name.v"]
    set_property top $name [get_filesets sources_1]
    add_files -norecurse -fileset constrs_1 [file join $dir constraints pins.xdc]
    add_files -norecurse -fileset sim_1 [file join $dir sim tb.sv]
    set_property file_type SystemVerilog [get_files [file join $dir sim tb.sv]]
    set_property top tb [get_filesets sim_1]
    set_property xsim.simulate.runtime all [get_filesets sim_1]
    update_compile_order -fileset sources_1
    update_compile_order -fileset sim_1
    close_project
    puts "CREATED_PROJECT $name"
}
