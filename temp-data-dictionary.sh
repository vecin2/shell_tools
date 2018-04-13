path=$1
path=pedro.jesus.juan.jose.francisco; 
arr=(${path//\./ }); 
echo ${arr[*]}; for i in ${arr[@]}; do echo $i; done
last_word=${path##*.}
echo $last_word
