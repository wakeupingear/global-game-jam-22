function getLevel(yPos){
	if yPos<204 return level.Heaven;
	if yPos<412 return level.Purgatory;
	return level.Hell;
}