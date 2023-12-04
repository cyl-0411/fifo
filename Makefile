SBT = sbt
TEST_DIR = ./tb
IVERILOG = iverilog
IVERILOG_FLAGS = -o $(TEST_DIR)/wave 
IVERILOG_FILES = $(shell find -name "*.v" -o -name "*.sv" )
VVP = vvp 
VVP_FLAGS = -n -lxt2
VVP_FILE = $(TEST_DIR)/wave
run:
	$(SBT) run

test:
	$(IVERILOG) $(IVERILOG_FLAGS) $(IVERILOG_FILES)


wave:
	$(IVERILOG) $(IVERILOG_FLAGS) $(IVERILOG_FILES)
	$(VVP) $(VVP_FLAGS) $(VVP_FILE)
	$(shell mv *.vcd $(TEST_DIR))
	gtkwave $(TEST_DIR)/*.vcd

clean:
	rm ./tb/wave*

.PHONY: default test clean wave