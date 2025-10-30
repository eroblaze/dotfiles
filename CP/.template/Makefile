# +--------------------+
# |   GENERAL CONFIG   |
# +--------------------+

PROBLEM_NAME := ${PROBLEM_NAME}
DEBUG := true
LANG := cpp

# Root directory of your project (one level up from this Makefile location)
ROOT_DIR := ..

# Switch: true to use bits/stdc++.h, false to use custom PCH.h
USE_BITS_STD := true

# Directory where the PCH files will be stored
PCH_DIR := $(ROOT_DIR)/.pch

# Precompiled headers to generate
ifeq ($(USE_BITS_STD),true)
PRECOMPILE_HEADERS := bits/stdc++.h
else
PRECOMPILE_HEADERS := PCH.h
endif

# Language-specific config
ifeq ($(LANG),cpp)
TARGET := $(PROBLEM_NAME)
EXECUTE := ./$(TARGET)
CLEAN_TARGETS := $(TARGET)
else ifeq ($(LANG),python)
TARGET := $(PROBLEM_NAME).py
EXECUTE := python3 ./$(TARGET)
CLEAN_TARGETS :=
else
$(error "Unknown language; please set TARGET, EXECUTE, and CLEAN_TARGETS manually")
endif

# Compiler and flags
CXX := g++
CXXFLAGS := -std=c++23 -O2 -Wall -Wextra -Wshadow -Wconversion -Wfloat-equal
DEBUG_CXXFLAGS := -DERO_LOCAL -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -fsanitize=address

ifeq ($(DEBUG),true)
CXXFLAGS += $(DEBUG_CXXFLAGS)
endif

# +-------------------+
# |   GENERAL RULES   |
# +-------------------+

.PHONY: default
default: pch

clean:
	-rm -rf $(CLEAN_TARGETS) 
.PHONY: clean

veryclean: clean
	-rm -rf $(PCH_DIR) *.res
.PHONY: veryclean

rebuild: veryclean all
.PHONY: rebuild

# +---------------------+
# |   PCH COMPILATION   |
# +---------------------+

# Dynamic rule to precompile any header to .gch
$(PCH_DIR)/%.gch:
	@rm -f $@
	@mkdir -p $(dir $@)
	@echo "[PCH] Precompiling $*..."
	@$(CXX) $(CXXFLAGS) -x c++-header "$$(echo '#include<$*>' | $(CXX) $(CXXFLAGS) -H -E -x c++ - 2>&1 >/dev/null | head -1 | cut -d ' ' -f2)" -o $@
	@echo "[PCH] Created $@"
.PRECIOUS: $(PCH_DIR)/%.gch

# Named target to create all PCH files
.PHONY: pch
pch: $(patsubst %,$(PCH_DIR)/%.gch,$(PRECOMPILE_HEADERS))

# +---------------------+
# |  EXECUTABLE BUILD   |
# +---------------------+

all: $(TARGET)
.PHONY: all

%: %.cpp # Cancel the builtin rule

# Compile executable using PCH
$(TARGET): $(PROBLEM_NAME).cpp $(patsubst %,$(PCH_DIR)/%.gch,$(PRECOMPILE_HEADERS))
	@echo "[BUILD] Compiling $(PROBLEM_NAME).cpp with PCH..."
	@$(CXX) $(CXXFLAGS) -isystem $(PCH_DIR) $< -o $@
	@echo "[BUILD] Created executable: $(TARGET)"
.PRECIOUS: %

# +-----------------------+
# | DEBUG / VERIFY PCH    |
# +-----------------------+

debug-pch: $(patsubst %,$(PCH_DIR)/%.gch,$(PRECOMPILE_HEADERS))
	@echo "=== PCH Debug Check (implicit) ==="
	@echo "[INFO] Compiling $(PROBLEM_NAME).cpp with -H to show headers..."
	@$(CXX) $(CXXFLAGS) -H -isystem $(PCH_DIR) $(PROBLEM_NAME).cpp -o /dev/null 2>&1 | grep '\.gch' || echo "[WARN] No .gch file detected in header chain"
	@echo "==="
	@echo "Look for a line like '! $(PCH_DIR)/bits/stdc++.h.gch' above."

# +-----------------------+
# |   RUNNING / TESTING   |
# +-----------------------+

# 'run' is for quick, interactive execution where timing is not the focus.
run: $(TARGET)
	@echo "[RUN] Executing $(TARGET)..."
	@$(EXECUTE)

ifeq ($(DEBUG),true)
	@echo "[INFO] Built with DEBUG flags enabled, code may be slower than normal"
endif
.PHONY: run

# ------------------------------------------------------------------------------------
# -- Performance Metrics for Competitive Programming --
# KEY METRIC: "Algorithm (User)" + "System (I/O)" must be under the time limit.
# ------------------------------------------------------------------------------------

# 'bench' is for accurate timing using a dedicated input file (bench.input).
.PHONY: bench
bench: $(TARGET)
	@# Ensure the bench.input file exists before trying to run.
	@if [ ! -f bench.input ]; then \
			echo "[ERROR] bench.input not found. Please create it."; \
			exit 1; \
		fi
		@echo "[BENCH] Running $(TARGET) with bench.input..."
		@/usr/bin/time -f '\n[PERFORMANCE STATS]\n  Algorithm (User):\t%Us\n  System (I/O):\t\t%Ss\n  Wall Clock:\t\t%es\n  Memory:\t\t%M KB\n' \
			$(EXECUTE) < bench.input 2>&1 | \
			awk '{if($$1=="Memory:") printf "  Memory:\t\t%.2f MB\n", $$2/1024; else print $$0}'

ifeq ($(DEBUG),true)
	@echo "[INFO] Built with DEBUG flags enabled, code may be slower than normal"
endif

# Runs with input, captures output to .res and timing to .time
%.res: $(TARGET) %.in
	@(echo "[RUN] Running with $<...") && \
		( (/usr/bin/time -f '\n[PERFORMANCE STATS]\n  Algorithm (User):\t%Us\n  System (I/O):\t\t%Ss\n  Wall Clock:\t\t%es\n  Memory:\t\t%M KB\n' \
			$(EXECUTE) < $*.in > $*.res) 2>&1 | \
			awk '{if($$1=="Memory:") printf "  Memory:\t\t%.2f MB\n", $$2/1024; else print $$0}' > $*.time )

ifeq ($(DEBUG),true)
	@echo "[INFO] Built with DEBUG flags enabled, code may be slower than normal"
endif
.PRECIOUS: %.res

%.out: % # Cancel builtin rule

__test_%: %.res %.out
	output $*.res $*.out
.PHONY: __test_%

CASES := $(sort $(basename $(wildcard *.in)))
TESTS := $(sort $(basename $(wildcard *.out)))

runs: $(patsubst %,%.res,$(CASES))
.PHONY: runs

solve: runs
.PHONY: solve

test: $(patsubst %,__test_%,$(TESTS))
.PHONY: test
