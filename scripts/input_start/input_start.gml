function input_start(_restart = false)
{
	if _restart
	{
		ds_map_clear(global.input_map)
		global.key_map = {}
		file_delete(working_directory + "input.dat")
	}
	var _exists = file_exists(working_directory + "input.dat")
	
	var _inputsKeyboard = {}
	struct_set(_inputsKeyboard, "left", [vk_left])
	struct_set(_inputsKeyboard, "down", [vk_down])
	struct_set(_inputsKeyboard, "up", [vk_up])
	struct_set(_inputsKeyboard, "right", [vk_right])
	struct_set(_inputsKeyboard, "jump", [ord("Z")])
	struct_set(_inputsKeyboard, "grab", [ord("X")])
	struct_set(_inputsKeyboard, "taunt", [ord("C")])
	struct_set(_inputsKeyboard, "attack", [vk_shift])
	struct_set(_inputsKeyboard, "start", [vk_escape, vk_enter])
	struct_set(_inputsKeyboard, "superjump", [])
	struct_set(_inputsKeyboard, "groundpound", [])
	struct_set(_inputsKeyboard, "menu_left", [vk_left])
	struct_set(_inputsKeyboard, "menu_down", [vk_down])
	struct_set(_inputsKeyboard, "menu_up", [vk_up])
	struct_set(_inputsKeyboard, "menu_right", [vk_right])
	struct_set(_inputsKeyboard, "menu_confirm", [ord("Z")])
	struct_set(_inputsKeyboard, "menu_back", [ord("X")])
	struct_set(_inputsKeyboard, "menu_clear", [ord("C")])
	
	var _inputsGamepad = {}
	struct_set(_inputsGamepad, "left", [gp_padl, "joystickL_left"])
	struct_set(_inputsGamepad, "down", [gp_padd, "joystickL_down"])
	struct_set(_inputsGamepad, "up", [gp_padu, "joystickL_up"])
	struct_set(_inputsGamepad, "right", [gp_padr, "joystickL_right"])
	struct_set(_inputsGamepad, "jump", [gp_face1])
	struct_set(_inputsGamepad, "grab", [gp_face3])
	struct_set(_inputsGamepad, "taunt", [gp_face4])
	struct_set(_inputsGamepad, "attack", [gp_shoulderr, gp_shoulderrb])
	struct_set(_inputsGamepad, "start", [gp_start])
	struct_set(_inputsGamepad, "superjump", [])
	struct_set(_inputsGamepad, "groundpound", [])
	struct_set(_inputsGamepad, "menu_left", [gp_padl, "joystickL_left"])
	struct_set(_inputsGamepad, "menu_down", [gp_padd, "joystickL_down"])
	struct_set(_inputsGamepad, "menu_up", [gp_padu, "joystickL_up"])
	struct_set(_inputsGamepad, "menu_right", [gp_padr, "joystickL_right"])
	struct_set(_inputsGamepad, "menu_confirm", [gp_face1])
	struct_set(_inputsGamepad, "menu_back", [gp_face3])
	struct_set(_inputsGamepad, "menu_clear", [gp_face4])
	
	var _struct_names = struct_get_names(_inputsKeyboard)
	var _struct_size = array_length(_struct_names) 
	
	
	for (var i = 0; i < _struct_size; i++)
	{
		var _struct = _struct_names[i]
		if !_exists
		{
			var _struct_value_key = struct_get(_inputsKeyboard, _struct)
			var _struct_value_pad = struct_get(_inputsGamepad, _struct)
			struct_set(global.key_map, $"{_struct}_key", _struct_value_key)
			struct_set(global.key_map, $"{_struct}_pad", _struct_value_pad)
			var q = json_stringify(global.key_map, true)
			var _file = file_text_open_write(working_directory + "input.dat");
			file_text_write_string(_file, q);
			file_text_close(_file);
			var p = loadString(working_directory + "input.dat")
		}
		else
		{
			var p = loadString(working_directory + "input.dat")
			global.key_map = json_parse(p);
			var _struct_value_key = struct_get(global.key_map, $"{_struct}_key")
			var _struct_value_pad = struct_get(global.key_map, $"{_struct}_pad")
		}
		
		var _input =
		{}
		with _input
		{
			key_input_array = _struct_value_key
			pad_input_array = _struct_value_pad
			is_pressed = false
			is_held = false
			
			update = function()
			{
				self.is_pressed = self.pressed()
				self.is_held = self.held()
			}
			
			pressed = function()
			{
				for (var i = 0; i < array_length(self.key_input_array); i++)
				{
					if keyboard_check_pressed(self.key_input_array[i])
						return true;
				}
				
				for (var i = 0; i < array_length(self.pad_input_array); i++)
				{
					var _bt = self.pad_input_array[i]
					if is_string(_bt)
					{
						var _gp = gamepad_find_axis_string(_bt)
						if _gp == -4
							return false
						else
						{
							if !_gp.invert
							{
								if gamepad_axis_value(global.player_gamepad_current, _gp.stick) >= global.gamepad_deadzones.press && ds_map_find_value(global.gamepad_axis_pressed, _gp.stick) == false
								{
									ds_map_set(global.gamepad_axis_pressed, _gp.stick, true)
									return true
								}
							}
								
							else if _gp.invert
							{
								if gamepad_axis_value(global.player_gamepad_current, _gp.stick) <= -global.gamepad_deadzones.press && ds_map_find_value(global.gamepad_axis_pressed, _gp.stick) == false
								{
									ds_map_set(global.gamepad_axis_pressed, _gp.stick, true)
									return true
								}
							}
						}
					}
					else
					{
						if gamepad_button_check_pressed(global.player_gamepad_current, _bt)
							return true
					}
				}
				return false;
			}
			held = function()
			{
				for (var i = 0; i < array_length(self.key_input_array); i++)
				{
					if keyboard_check(self.key_input_array[i])
						return true;
				}
				
				for (var i = 0; i < array_length(self.pad_input_array); i++)
				{
					var _bt = self.pad_input_array[i]
					if is_string(_bt)
					{
						var _gp = gamepad_find_axis_string(_bt)
						if _gp == -4
							return false
						else
						{
							if !_gp.invert
								return gamepad_axis_value(global.player_gamepad_current, _gp.stick) >= gamepad_find_axis_deadzone(_gp.stick)
							else if _gp.invert
								return gamepad_axis_value(global.player_gamepad_current, _gp.stick) <= -gamepad_find_axis_deadzone(_gp.stick)
						}
					}
					else
					{
						if gamepad_button_check(global.player_gamepad_current, _bt)
							return true
					}
				}
				return false;
			}
		}
		ds_map_add(global.input_map, $"{_struct}", _input)
	}
}