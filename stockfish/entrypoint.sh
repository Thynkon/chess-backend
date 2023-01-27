#! /bin/bash

socat "TCP-LISTEN:${STOCKFISH_PORT},reuseaddr,fork" "EXEC:/stockfish/stockfish"
