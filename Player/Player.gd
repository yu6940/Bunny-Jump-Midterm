extends KinematicBody2D

var motion = Vector2(0,0)
 
export var GRAVITY = 60
export var SPEED = 500
export var JUMP = 700
export var jump_count = 0 #ค่าเริ่มต้น
func _physics_process(delta): #ทำงานเมื่อมีระบบฟิสิกส์
	apply_GRAVITY()
	JUMP()
	WATK()
	
	move_and_slide(motion, Vector2(0,-1)) 
	update_animation()
	
func update_animation():
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	elif motion.x < 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	elif motion.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
		
	else:
		$AnimatedSprite.play("idle")
	

func is_dead():
	
	if motion.y > 2500:
		return true
		
	return false
	
func apply_GRAVITY():
	if is_on_floor():#ยืนบนfloorและเป็นการให้กดค้างแล้วกระโดดทั้งเดียว ไม่บินขึ้น
		print("I'm floor")
		
	else:
		motion.y += GRAVITY #(แบบย่อ) motion.y = motion.y + GRAVITY(ตัวเต็ม) 
	
func WATK():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = +SPEED
	else:
		motion.x = 0
		
		
func JUMP():
	if jump_count < 1 : #เป็นการทำให้กระโดดได้มากกว่า 1 ครั้ง
	
		if Input.is_action_just_pressed("jump"): 
			motion.y = -JUMP
			jump_count = jump_count + 1
			$AudioStreamPlayer.play()
	if is_on_floor():#จะกระโดดอีกครั้ง เมื่ออยู่บนพื้นเท่านั้น 
		jump_count = 0
		
		
	#else:
		#motion.y = 700 #ไม่จำเป็นต้องใสelse่ เพราะมีmotion.yข้างบนแล้ว
	
	
