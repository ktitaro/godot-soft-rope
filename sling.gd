extends Node

const Chain=preload("res://chain.tscn")

@export var target_a: Node2D
@export var target_b: Node2D

func build_sling():
	var m1=target_a.get_node("./Shape/Pin")
	var m2=target_b.get_node("./Shape/Pin")
	var ang=self._get_angle(m1,m2)
	var seg=self._get_segments(m1,m2)
	var prev=target_a
	for i in seg:
		var pin=prev.get_node("./Shape/Pin")
		var pt1=m1.global_position
		var pt2=m2.global_position
		var dx=(pt1.x-pt2.x)*(i/seg)
		var dy=(pt1.y-pt2.y)*(i/seg)
		var pos=pt1-Vector2(dx,dy)
		var ch=Chain.instantiate()
		ch.global_position=pos
		ch.rotation=ang
		self.add_child(ch)
		pin.node_b=ch.get_path()
		pin.node_a=prev.get_path()
		prev=ch
	var pin=prev.get_node("./Shape/Pin")
	pin.node_b=target_b.get_path()
	pin.node_a=prev.get_path()

func _get_angle(m1,m2):
	var p1=m1.global_position
	var p2=m2.global_position
	return ((p2-p1).angle()-PI/2)

func _get_length(m1,m2):
	var p1=m1.global_position
	var p2=m2.global_position
	return p1.distance_to(p2)

func _get_seg_length():
	var ch=Chain.instantiate()
	var sp=ch.get_node("./Shape")
	return sp.shape.height/2

func _get_segments(m1,m2):
	var len=self._get_length(m1,m2)
	var seg=self._get_seg_length()
	return round(len/seg)
