package require Rappture

# open the XML file containing the run parameters
set driver [Rappture::library [lindex $argv 0]]

set npts [$driver get input.integer(points).current]
set accel [$driver get input.number(accel).current]
set xpos 0
#set accel 9.8
#set npts 10
#set ypos 0
#set xvel 5
#set yvel 5
set ypos [$driver get input.number(ypos).current]
set xvel [$driver get input.number(xvel).current]
set yvel [$driver get input.number(yvel).current]
set tmax [expr {2 * double($yvel) / double($accel)}]
set dt [expr {double($tmax) / double($npts)}]
set x $xpos
set y $ypos
set t 0


# generate a line curve
#$driver put output.curve(ty).about.label "Trajectory"
#$driver put output.curve(ty).about.description \
    "This is the trajectory of the projectile."
#$driver put output.curve(ty).xaxis.label "T"
#$driver put output.curve(ty).xaxis.description "Time."
#$driver put output.curve(ty).xaxis.units "s"
#$driver put output.curve(ty).yaxis.label "Y"
#$driver put output.curve(ty).yaxis.description "Vertical Position."
#$driver put output.curve(ty).yaxis.units "m"

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

#$driver put output.string(yes).current $tmax

#for {set t 0} {$t < $tmax} {set t expr{$t+$dt}} {
#    $driver put -append yes output.curve(single).component.xy "$x $y \n"
#        set x $xpos+$xvel*$t
#        set y $ypos+$yvel*$t-(.5)*$accel*$t*$t
#}
 
#puts $tmax
#puts $dt
#puts $x
#puts $y


# save the updated XML describing the run...
Rappture::result $driver
exit 0
