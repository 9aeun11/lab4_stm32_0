set root [file normalize [file dirname [info script]]]
foreach name {mult_4bit bcd_conv} {
    set dir [file join $root $name]
    open_project [file join $dir "$name.xpr"]
    launch_runs impl_1 -to_step write_bitstream -jobs 2
    wait_on_run impl_1
    set run [get_runs impl_1]
    set status [get_property STATUS $run]
    puts "IMPLEMENTATION_STATUS $name $status"
    set bit [file join $dir "$name.runs" impl_1 "$name.bit"]
    if {![file exists $bit]} { error "Bitstream missing: $bit" }
    file copy -force $bit [file join $dir "$name.bit"]
    puts "BITSTREAM_READY $name"
    close_project
}
