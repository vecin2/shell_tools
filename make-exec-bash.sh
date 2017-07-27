#!/bin/bash

if [ $# -ne 2 ]; then
	echo number of parameter passed is $# but
	echo Usage:
  echo "	filename -not including extension"
	echo "  file content - no include first line"
	exit 1 
fi
FILE_NAME=$1
FILE_CONTENT=$2
printf "#!/bin/bash\n\n $FILE_CONTENT" > $FILE_NAME.sh
chmod +x $FILE_NAME.sh
