IF NOT EXIST %1 goto :eof
PUSHD %1
CD ..
REN %~n1 %~n1.tmp
POPD
