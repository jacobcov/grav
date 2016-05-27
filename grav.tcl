package require Rappture

# open the XML file containing the run parameters
set driver [Rappture::library [lindex $argv 0]]

#Variables
set npts [$driver get input.integer(points).current]
set accel [$driver get input.number(accel).current]
set xpos 0
set ypos [$driver get input.number(ypos).current]
set xvel [$driver get input.number(xvel).current]
set yvel [$driver get input.number(yvel).current]
set tmax [expr {2 * double($yvel) / double($accel)}]
set dt [expr {double($tmax) / double($npts)}]
set x $xpos
set y $ypos
set t 0

#Calculation Loop
while {$y >= 0 || $t <= $tmax} {
	set x [expr {$xpos + $xvel*$t}]
	set y [expr {$ypos + $yvel*$t-(.5)*$accel*$t*$t}]
	if {$y < 0} { break }
	$driver put -append yes output.curve(ty).component.xy "$t $y\n"
	$driver put -append yes output.curve(tx).component.xy "$t $x\n"
        $driver put -append yes output.curve(xy).component.xy "$x $y\n"
#	puts "$t $y"
	set t [expr {$t + $dt}]
}



# save the updated XML describing the run...
Rappture::result $driver
exit 0
