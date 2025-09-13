extends Control

@export var license_text_label : Label
@export var do_i_use_non_godot_licenses := false
@export_file("*.txt") var non_godot_thirdparty_license_file

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !license_text_label:
		print_debug("License text label is not set!")
		return
	
	load_non_godot_license_text()
	
	godot_license_text()
	
	copyright_info()
	
	license_info()


func add_to_text(text_to_add: String):
	license_text_label.text = str(license_text_label.text, text_to_add)

func load_non_godot_license_text():
	if non_godot_thirdparty_license_file == null and do_i_use_non_godot_licenses:
		add_to_text("Non Godot License file doesn't exist!\n\n")
	elif non_godot_thirdparty_license_file and do_i_use_non_godot_licenses:
		var file = FileAccess.open(non_godot_thirdparty_license_file, FileAccess.READ)
		
		add_to_text(file.get_as_text())

func godot_license_text():
	add_to_text(str("\n=========================\n", "GODOT_COPYRIGHT","\n=========================\n\n"))
	
	add_to_text(str(Engine.get_license_text(), "\n"))
	
	
func license_info():
	var license_text = Engine.get_license_info()
	
	for license in license_text:
		add_to_text(str(license_text.get(license)))


func copyright_info():
	var copyright_text_dict = Engine.get_copyright_info()
	
	for copyright_part in copyright_text_dict.size():
		add_to_text(str("Name: ", copyright_text_dict.get(copyright_part).name,"\n"))
		
		var parts_array : Array = copyright_text_dict.get(copyright_part).parts
		
		for part in parts_array.size():
			var file_array : Array = parts_array.get(part).files
			add_to_text(str("Files: "))
			
			for file in file_array.size():
				add_to_text(str(file_array.get(file), "\n"))
				
			var copyright_array : Array = parts_array.get(part).copyright
			add_to_text(str("Copyright: "))
			
			for copyright in copyright_array.size():
				add_to_text(str(copyright_array.get(copyright), "\n"))
				
			add_to_text(str("License: ", parts_array.get(part).license, "\n", "\n", "\n"))
