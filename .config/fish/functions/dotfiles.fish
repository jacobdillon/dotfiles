function dotfiles
	/usr/bin/env git --git-dir=$HOME/src/dotfiles --work-tree=$HOME $argv;
end
