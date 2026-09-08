function read_input(_input, _press = false)
{
	var _return = false
	var _key_board = $"{_input}"
	var _map = ds_map_find_value(global.input_map, _key_board)
	if obj_shell.isOpen
	{
		return false;
	}
	if _press
		_return = _map.is_pressed
	else
		_return = _map.is_held
	return _return
	
}