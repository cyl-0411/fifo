SBT = sbt
DIR = $(shell pwd)
TEST_DIR = ./tb
IVERILOG = iverilog
IVERILOG_FLAGS = -g2005-sv -o $(TEST_DIR)/wave 
IVERILOG_FILES = $(shell find . -name "*.v")
IVERILOG_FILES += $(shell find . -name "*.sv" )
VVP = vvp 
VVP_FLAGS = -n -lxt2 
VVP_FILE = $(TEST_DIR)/wave

TIME = $(shell date +%Y%m%d)
run:
	$(SBT) run

test:
	$(IVERILOG) $(IVERILOG_FLAGS) $(IVERILOG_FILES)


wave:
	@$(IVERILOG) $(IVERILOG_FLAGS) $(IVERILOG_FILES)
	@$(VVP) $(VVP_FLAGS) $(VVP_FILE) 
	@mv *.vcd $(TEST_DIR)

clean:
	rm ./tb/wave* ./tb/*.vcd ./xt2

git:
	git add .
	git commit -m "$(TIME)"

.PHONY: default test clean wave