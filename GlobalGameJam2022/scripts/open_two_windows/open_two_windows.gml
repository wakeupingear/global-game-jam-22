function open_two_windows() {
	//Only let the first one create new windows
	if (parameter_count() == 3) {
		//these are apparently necessary for running in the vm, but not in the release build
		var args = "-game " + parameter_string(2);
	}else{
		//in the release build, we don't need any parameters
		var args = "";
	}
	var exe = get_program_pathname();
	execute_shell(exe, args);
}
