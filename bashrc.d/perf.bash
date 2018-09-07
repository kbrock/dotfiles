
# determine the query count of an html file
# it is off by 12
function qcount() { sed -E "s/\"formatted_command/\\`echo -e '\n\r'`&/g" $1 |wc -l ; }

alias profile='beer mini_profiler --storage Redis --storage-options db=2 --collapse Rendering'
