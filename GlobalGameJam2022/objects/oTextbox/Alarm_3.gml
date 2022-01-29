/// @description until loop
if diagCondition(whileCondition,whileArgs)
{
	whileCondition="";
	whileArgs=[];
	alarm[0]=-1;
	event_perform(ev_alarm,0);
}
else 
{
	alarm[3]=1;
	alarm[0]++;
}