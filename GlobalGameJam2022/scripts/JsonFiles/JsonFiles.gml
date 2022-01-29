function loadStringJson(file) {
	//if !isHtml
	{
		if !file_exists(file+".json")
		{
			show_message("Error: File "+file+" does not exist.");
			exit;
		}
		var JsonFile = file_text_open_read(file+".json");
		var data = "";

		// Read through the Json file and save the text in the Data variable
		while (!file_text_eof(JsonFile)) {
		    data += file_text_read_string(JsonFile);
		    file_text_readln(JsonFile);
		}

		// Close the Json file
		file_text_close(JsonFile);
		addJsonData(file,json_parse(data));
	}
}

function addJsonData(str,data){
	if str=="pathfinding" global.pathfindingScripts=data;
	else global.langScript=addToStruct(global.langScript,data);
}