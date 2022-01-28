tool
extends Control

var ball_direction:Vector2
var ball_speed:float
var enemy_speed: float = 5
var enemy_score = 0
var player_score = 0

func _ready():
	restart()

func restart():
	$player.rect_position.x = rect_size.x/2
	$player.rect_position.y = rect_size.y*0.9
	$player.rect_size.x = rect_size.x/10
	
	$enemy.rect_position.x = rect_size.x/2
	$enemy.rect_position.y = rect_size.y*0.1
	$enemy.rect_size.x = rect_size.x/10
	
	$ball.rect_position = rect_size/2
	
	$Button.text = "start " + str(player_score) + ":" + str(enemy_score)
	$Button.visible = true
	ball_direction = Vector2.ZERO

func _process(delta):
	$enemy.rect_position.x = move_toward($enemy.rect_position.x, $ball.rect_position.x + $ball.rect_size.x/2 - $enemy.rect_size.x/2, enemy_speed)
	$enemy.rect_position.x = clamp($enemy.rect_position.x, 0, rect_size.x - $enemy.rect_size.x)
	
	$player.rect_position.x = get_local_mouse_position().x - $player.rect_size.x/2
	$player.rect_position.x = clamp($player.rect_position.x, 0, rect_size.x - $player.rect_size.x)
	
	$ball.rect_position+=ball_direction*ball_speed
	
	if $ball.rect_position.x <= 0:
		ball_direction.x *= -1
	if $ball.rect_position.x + $ball.rect_size.x >= rect_size.x:
		ball_direction.x *= -1
	
	
	if $ball.rect_position.y >= $player.rect_position.y + $player.rect_size.y:
		enemy_score+=1
		restart()
	
	if $ball.rect_position.y <= $enemy.rect_position.y:
		player_score+=1
		restart()
	
	if $ball.rect_position.y + $ball.rect_size.y >= $player.rect_position.y:
		if $ball.rect_position.x + $ball.rect_size.x >= $player.rect_position.x and $ball.rect_position.x <= $player.rect_position.x + $player.rect_size.x:
			$ball.rect_position.y = $player.rect_position.y - $ball.rect_size.y - 1
			
			var ball_pos = $ball.rect_position.x + $ball.rect_size.x/2
			var player_pos = $player.rect_position.x + $player.rect_size.x
			var test = (player_pos - ball_pos)/$player.rect_size.x
			test = lerp(75, -75, test)
			#OS.alert(str(test))
			ball_direction = Vector2.UP.rotated(deg2rad(test)).normalized()
			ball_speed*=1.1
	
	if $ball.rect_position.y <= $enemy.rect_position.y + $enemy.rect_size.y:
		if $ball.rect_position.x + $ball.rect_size.x >= $enemy.rect_position.x and $ball.rect_position.x <= $enemy.rect_position.x + $enemy.rect_size.x:
			ball_direction.y *= -1
			ball_speed*=1.1
	



func _on_Button_pressed():
	ball_direction = Vector2(randf(), randf())
	ball_direction = ball_direction.normalized()
	ball_speed = 3
	$ball.rect_position = rect_size/2
	$Button.visible = false
