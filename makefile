NAME=Create From Stream File
BIN_LIB=CRTFRMSTMF
DBGVIEW=*SOURCE
TGTRLS=V7R3M0

#----------

all: $(BIN_LIB).lib crtfrmstmf.rpgle crtfrmstmf.pnlgrp crtfrmstmf.cmd
	@echo "Built all"

#----------

%.rpgle:
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('QSOURCE/$*.rpgle') TEXT('$(NAME)') REPLACE(*YES) DBGVIEW($(DBGVIEW)) TGTRLS($(TGTRLS)) TGTCCSID(*JOB)"

%.pnlgrp:
	system "CPYFRMSTMF FROMSTMF('QSOURCE/$*.pnlgrp') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QSOURCE.file/$*.mbr') MBROPT(*REPLACE)"
	system "CRTPNLGRP PNLGRP($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QSOURCE) SRCMBR($*) REPLACE(*YES) TEXT('$(NAME)')"	
	
%.cmd:
	system "CRTCMD CMD($(BIN_LIB)/$*) PGM($(BIN_LIB)/$*) SRCSTMF('QSOURCE/$*.cmd') TEXT('$(NAME)') HLPPNLGRP($(BIN_LIB)/$*) HLPID(*CMD)"
	
%.lib:
	-system -qi "CRTLIB LIB($(BIN_LIB)) TEXT('$(NAME)')"
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QSOURCE) MBR($*) RCDLEN(112)"

clean:
	system "CLRLIB LIB($(BIN_LIB))"

erase:
	-system -qi "DLTLIB LIB($(BIN_LIB))"	
