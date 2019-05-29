NAME=Create From Stream File
BIN_LIB=CRTFRMSTMF
DBGVIEW=*SOURCE
TGTRLS=V7R3M0

#----------

all: crtfrmstmf.rpgle crtfrmstmf.pnlgrp crtfrmstmf.cmd
	@echo "Built all"

#----------

%.rpgle:
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('QSOURCE/$*.rpgle') TEXT('$(NAME)') REPLACE(*YES) DBGVIEW($(DBGVIEW)) TGTRLS($(TGTRLS))"

%.pnlgrp:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QSOURCE) MBR($*) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('QSOURCE/$*.pnlgrp') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QSOURCE.file/$*.mbr') MBROPT(*REPLACE)"
	system "CRTPNLGRP PNLGRP($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QSOURCE) SRCMBR($*) REPLACE(*YES) TEXT('$(NAME)')"	
	-system -qi "DLTF FILE($(BIN_LIB)/QCMDSRC)"
	
%.cmd:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QSOURCE) MBR($*) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('QSOURCE/$*.cmd') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QSOURCE.file/$*.mbr') MBROPT(*REPLACE)"
	system "CRTCMD CMD($(BIN_LIB)/$*) PGM($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QSOURCE) SRCMBR($*) TEXT('$(NAME)') HLPPNLGRP($(BIN_LIB)/$*) HLPID(*CMD)"
	-system -qi "DLTF FILE($(BIN_LIB)/QSOURCE)"
	
clean:
	system "CLRLIB $(BIN_LIB)"