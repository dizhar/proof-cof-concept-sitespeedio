set -e

COMMAND=$1
FILEPATH="$2"
SITE="$3"

[[ "$COMMAND" == "" ]] && echo "COMMAND (1st parameter) cannot be empty" && exit 1

CONFIG_PATH=${3:-""}

IMAGE="pageintegrity.azurecr.io/pi-core/pi-qa-sitespeed"
VOLUME="~/sitespeed-result"

docker pull $IMAGE


function run(){
	  		docker run --rm  \
			-v ~/sitespeed-result:/sitespeed-result \
			$IMAGE \
			--config "$FILEPATH" "$SITE"
}


function local(){
		docker run --rm  \
			-v ~/sitespeed-result:/sitespeed-result \
			-v `pwd`/$(basename $(dirname "${FILEPATH%/*}")):/base:ro $IMAGE --config "$FILEPATH" "$SITE"
}


case $COMMAND in 
	"run" 	) 
	    [[ "$FILEPATH" == "" ]] && echo "SITE (2rd parameter) cannot be empty" && exit 1
		[[ "$SITE" == "" 	]] && echo "SITE (3rd parameter) cannot be empty" && exit 1
		run
		;;

	"local" 	) 
	    [[ "$FILEPATH" == "" ]] && echo "SITE (2rd parameter) cannot be empty" && exit 1
		[[ "$SITE" == "" 	]] && echo "SITE (3rd parameter) cannot be empty" && exit 1
		local
		;;

	* 	) 
		echo "Command '$COMMAND' is invalid"
esac
