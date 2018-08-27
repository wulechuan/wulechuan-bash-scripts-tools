if [ -d ~/$wlcLocalMachineFolderNameOfBashScriptsForDockers ]; then
	echo
	echo
	echo -e 'rm -rf ~/'$wlcLocalMachineFolderNameOfBashScriptsForDockers
	rm -rf ~/$wlcLocalMachineFolderNameOfBashScriptsForDockers
fi

deploy-by-copying  '_local-machine-wulechuan'  'Local Machine (wulechuan)'