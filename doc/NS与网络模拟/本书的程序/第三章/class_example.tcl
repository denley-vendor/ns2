Class Bagel				;# ������Bagel
Bagel instproc init {args} {	;# Bagel��ĳ�ʹ������
  $self set toasted 0  
  eval $self next $args
}
Bagel instproc toast {} {		;# ����Bagel��ĳ�Ա����toast
  $self instvar toasted
  incr toasted
  if {$toasted>1} then {
    error "something's burning!"		
  }
  return {}
}
Class SpreadableBagel -superclass Bagel	;# SpreadableBagel�̳�����Bagel

SpreadableBagel sBagel		;# ����SpreadableBagel��Ķ���sBagel
SpreadableBagel instproc init {args} {	;# SpreadableBagel�ĳ�ʹ������
  $self set toppings {}
  eval $self next $args				;# ���ø���ĳ�ʹ������
}
sBagel set toasted			;# ����Bagel�ı���toasted

sBagel toast		;# ʵ�ʵ��ø���Bagel��toast����
sBagel toast		;# ʵ�ʵ��ø���Bagel��toast����

SpreadableBagel info superclass		;# �鿴������Ϣ

SpreadableBagel info heritage		;# �鿴�̳�����Ϣ

Bagel instproc taste {} {			;#	Bagel������taste����
  $self instvar toasted
  if {$toasted == 0} then {
    return raw!
  } elseif {$toasted == 1} then {
    return toasty
  } else {
    return burnt!
  }
}
SpreadableBagel instproc spread {args} {	;# SpreadableBagel������spead����
  $self instvar toppings
  set toppings [concat $toppings $args]
  return $toppings
}
SpreadableBagel instproc taste {} {		;# SpreadableBagel������taste����
  $self instvar toppings
  set t [$self next]					;# $self next ���ø���Bagel��taste����
  foreach i $toppings {
    lappend t $i					;# �ڱ���$t������$i��ֵ
  }
  return $t
}
Class Sesame		;# ������Sesame

Sesame instproc taste {} {
  concat [$self next] "sesame"
}
Class Onion

Onion instproc taste {} {
  concat [$self next] "onion"
}
Class SesameOnionBagel -superclass {Sesame Onion SpreadableBagel}	

SesameOnionBagel info heritage	;# �鿴SesameOnionBagel��ļ̳�����Ϣ

SesameOnionBagel abagel -spread butter	;# ����spead����������SpreadableBagel��

abagel taste

