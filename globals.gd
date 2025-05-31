extends Node

enum ORBS {FIRE, NATURE, DEATH, HOLY}

var orbs_collected: int = 0
var is_dead := false

var fire_orbs := 1
var nature_orbs := 1
var death_orbs := 1
var holy_orbs := 2

var fire_firts := false
var nature_firts := false
var holy_firts := false
var death_firts := false

var selected_orb: int
