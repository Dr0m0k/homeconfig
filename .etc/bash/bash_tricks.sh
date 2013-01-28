function jump() {
	DIR=$1
	DEST=$PWD
	while [ ! -d "$DEST/$DIR" ] ; do
		ABS_DEST=$(cd "$DEST" && pwd)
		if [[ "$DEST" == "/" ]]; then
			return 1
		fi
		DEST=$(cd "$DEST/.." && pwd)
	done
	cd $(echo $PWD | sed "s#$DEST#&/$DIR#")
}

function git_root() {
	DIR='.git'
	DEST=$PWD
	while [ ! -d "$DEST/$DIR" ] ; do
		ABS_DEST=$(cd "$DEST" && pwd)
		if [[ "$DEST" == "/" ]]; then
			return 1
		fi
		DEST=$(cd "$DEST/.." && pwd)
	done
	cd "$DEST"
}
