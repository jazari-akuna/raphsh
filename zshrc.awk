BEGIN{
	act=0;
}

/# Add wisely/ {
	act=1;
}

/git/ {
	if(act==1)
	{
		sub(/git/,"git zsh-syntax-highlighting",$1);
		act=0;
	}
}
{print}