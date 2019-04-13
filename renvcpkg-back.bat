IF NOT EXIST %1.tmp goto :eof
PUSHD %1.tmp
CD ..
REN %~n1.tmp %~n1
POPD
