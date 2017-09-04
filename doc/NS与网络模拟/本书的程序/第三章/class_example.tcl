Class Bagel				;# 定义类Bagel
Bagel instproc init {args} {	;# Bagel类的初使化函数
  $self set toasted 0  
  eval $self next $args
}
Bagel instproc toast {} {		;# 定义Bagel类的成员函数toast
  $self instvar toasted
  incr toasted
  if {$toasted>1} then {
    error "something's burning!"		
  }
  return {}
}
Class SpreadableBagel -superclass Bagel	;# SpreadableBagel继承于类Bagel

SpreadableBagel sBagel		;# 生成SpreadableBagel类的对象sBagel
SpreadableBagel instproc init {args} {	;# SpreadableBagel的初使化函数
  $self set toppings {}
  eval $self next $args				;# 调用父类的初使化函数
}
sBagel set toasted			;# 父类Bagel的变量toasted

sBagel toast		;# 实际调用父类Bagel的toast函数
sBagel toast		;# 实际调用父类Bagel的toast函数

SpreadableBagel info superclass		;# 查看父类信息

SpreadableBagel info heritage		;# 查看继承树信息

Bagel instproc taste {} {			;#	Bagel类增加taste函数
  $self instvar toasted
  if {$toasted == 0} then {
    return raw!
  } elseif {$toasted == 1} then {
    return toasty
  } else {
    return burnt!
  }
}
SpreadableBagel instproc spread {args} {	;# SpreadableBagel类增加spead函数
  $self instvar toppings
  set toppings [concat $toppings $args]
  return $toppings
}
SpreadableBagel instproc taste {} {		;# SpreadableBagel类增加taste函数
  $self instvar toppings
  set t [$self next]					;# $self next 调用父类Bagel的taste函数
  foreach i $toppings {
    lappend t $i					;# 在变量$t后增加$i的值
  }
  return $t
}
Class Sesame		;# 定义类Sesame

Sesame instproc taste {} {
  concat [$self next] "sesame"
}
Class Onion

Onion instproc taste {} {
  concat [$self next] "onion"
}
Class SesameOnionBagel -superclass {Sesame Onion SpreadableBagel}	

SesameOnionBagel info heritage	;# 查看SesameOnionBagel类的继承树信息

SesameOnionBagel abagel -spread butter	;# 调用spead函数，来自SpreadableBagel类

abagel taste

