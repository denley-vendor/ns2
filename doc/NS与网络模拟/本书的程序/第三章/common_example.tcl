puts stdout "Hello World!"

# This is a remark.
set a 3	;# a <- 3

set var1 5;  set var2 10
unset var1 var2

set a 100;	 puts $a.00

set a 3;	set b 5
puts "$a + $b = [ set a [expr $a + $b ] ]"

if { $x >= 0 } {
	puts "abs(x) = $x"
} else {
	puts "abs(x) = [expr -$x]"
}

if { $day == 1 } {
	puts "Monday"
} elseif { $day == 2 } {
	puts "Tuesday"
} elseif { $day == 3 } {
	puts "Wednesday"
} else {
	puts "Other days"
}

switch -exact -- $day {
	1 { puts "Monday" }
	2 { puts "Tuesday" }
	default { puts "Other days" }
}

switch -glob -- $var \
-* {puts "var is a less than 0"} \
default { puts "b is not a negative" }

switch -regexp -- $var {
	^s.*n	-
	[abc].oo$	{ body1 }
	default	{ body2 }
}

set i 0;	while $i<5 { incr i }
set i 0;	while { $i< 5 } { incr i }

set n 10;	set result 1
while { $n > 1 } {
	set result [ expr $result * $n ]
	set n [ expr $n -1 ]
}

set i 0 
foreach value { 1 3 5 7 9 11 } {
	set i [expr $i + $value]
}

foreach var [ list $a $b xxx ] {
	puts "var = $var"
}

set k 0
for { set i 1 } { $i < 11 } { incr i } {
	set k [ expr $k + $i ]
}
set k

proc p1 { a b {c 1} } {
	set x [ expr ($a + $b) * $c ]; puts "x = $x"
	return x
}
p1 1 2

proc variousParams { a { b foo } args } {
	foreach param { a b args } {
		puts "$param = [ set $param ]"
	}
}
variousParams 33 44 32 11

set a 10; set b 0
	proc p { a } {
		set b 3
		if { a >= 0 } {
			return $b 
	} else {
		return [expr 0-$b]
	}
}
p -2
p $b

set result 1
proc p { n } {
	global result
	set result $n
}

proc factorial { n } {
	puts stderr "n=$n"
	if {$n <= 1} {
		return 1
	}
	return [expr $n * [factorial [set n [expr $n -1 ]] ] ]
}
puts [factorial 5]

for { set i 0 } { $i < 5 } { incr i } {
	set arr($i) [ expr $i * $i * $i ] 
}
set arr(3)


