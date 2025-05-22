extends Node

enum ORBS {FIRE, NATURE, DEATH, HOLY}

var orbs_collected: int = 0
var is_dead := false

var fire_orbs := 3
var nature_orbs := 1
var death_orbs := 1
var holy_orbs := 0

var selected_orb: int
