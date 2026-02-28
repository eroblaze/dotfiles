# +-----------------------------------------------------------------------+
# |                          WORKFLOW COMMANDS                            |
# +-----------------------------------------------------------------------+
# | (Default) make / make all: Compiles sol.cpp. Builds PCH if needed.     |
# | make test      : Compiles and runs automated tests against io/*.in/out.|
# |                  Uses custom 'output' script or 'diff' for verification|
# | make run       : Compiles and runs the program interactively.          |
# | make bench     : Accurate performance timing via io/bench.input.       |
# | make stress    : Automated stress testing (sol vs brute vs gen).       |
# | make clean     : Deletes binaries, timing logs, and temporary IO files.|
# | make veryclean : Full reset. Deletes everything including PCH cache.   |
# | make rebuild   : Alias for veryclean followed by all.                  |
# | make pch       : Manually builds/refreshes the Precompiled Header.     |
# | make debug-pch : Diagnostic tool to verify PCH is working correctly.   |
# +-----------------------------------------------------------------------+
# | PLATFORM AUTO-DETECTION:                                              |
# | The Makefile automatically detects if you are on a Phone (Termux) or  |
# | Desktop (Linux/macOS) and switches compilers and headers accordingly: |
# | - Desktop: Uses g++ and <bits/stdc++.h> (.gch)                        |
# | - Phone  : Uses clang++ and PCH.h (.pch)                               |
# +-----------------------------------------------------------------------+

# +-----------------------------------------------------------------------+
# |                         GENERAL CONFIGURATION                         |
# +-----------------------------------------------------------------------+

PROBLEM_NAME := sol
DEBUG        := true

# +-----------------------------------------------------------------------+
# |                          PLATFORM DETECTION                           |
# +-----------------------------------------------------------------------+

# Set PLATFORM to 'auto', 'desktop', or 'phone'
PLATFORM := auto

ifeq ($(PLATFORM),auto)
		# Use the Make built-in 'findstring' to search for "Android" in the kernel info.
		# This is more robust than shell piping inside a Makefile.
		IS_PHONE := $(if $(findstring Android,$(shell uname -a)),true,false)
else ifeq ($(PLATFORM),phone)
    IS_PHONE := true
else
    IS_PHONE := false
endif

# +-----------------------------------------------------------------------+
# |                       DYNAMIC ROOT DETECTION                          |
# +-----------------------------------------------------------------------+

# Set the marker file based on the detected platform
ifeq ($(IS_PHONE),true)
    ROOT_MARKER := PCH.h
else
    ROOT_MARKER := .clang-format
endif

# Recursively search up the directory tree (starting from the PWD) to find the appropriate marker
_REL_ROOT := $(shell \
    p="."; \
    while true; do \
        if [ -f "$$p/$(ROOT_MARKER)" ]; then echo "$$p"; break; fi; \
        if [ "$$(cd "$$p" && pwd)" = "/" ]; then break; fi; \
        p="$$p/.."; \
    done \
)

# Conditional Fallback logic
ifeq ($(_REL_ROOT),)
    ifeq ($(IS_PHONE),true)
        # On Phone: Throw an error and stop execution
        $(error "[ERROR] Could not find $(ROOT_MARKER) in the PWD or any parent directory. ROOT_DIR not found.")
    else
        # On Laptop: Alert the user and fallback to current directory
        $(info [WARN] Could not find $(ROOT_MARKER) in any parent directory. Defaulting to PWD as root.)
        _REL_ROOT := .
    endif
endif

# Convert to an absolute path to prevent Clang "file not found" errors
# when dealing with deeply nested ../../../ directories.
ROOT_DIR := $(abspath $(_REL_ROOT))

# Print out the resolved root directory path
$(info [ROOT_DIR] $(ROOT_DIR))

# +-----------------------------------------------------------------------+
# |                       DIRECTORY & BUILD TARGETS                       |
# +-----------------------------------------------------------------------+

# Subdirectory for all sample inputs, outputs, results, and benchmarks
IO_DIR       := io

# Subdirectory for stress testing files
STRESS_DIR   := stress

# Directory where the PCH files will be stored
PCH_DIR      := $(ROOT_DIR)/.pch

# Build Targets
TARGET        := $(PROBLEM_NAME)
EXECUTE       := ./$(TARGET)
CLEAN_TARGETS := $(TARGET)

# +-----------------------------------------------------------------------+
# |                           COMPILER CONFIG                             |
# +-----------------------------------------------------------------------+

# Compiler and PCH Logic Mapping
ifeq ($(IS_PHONE),true)
    # --- PHONE (Termux/Clang) CONFIG ---
    CXX          := clang++
    PCH_HEADER   := $(ROOT_DIR)/PCH.h
    PCH_FILE     := $(PCH_DIR)/PCH.h.pch
    # Clang requires -include-pch pointing to the specific file
    PCH_USE_FLAGS := -include-pch $(PCH_FILE) -I$(ROOT_DIR)
else
    # --- DESKTOP (GCC) CONFIG ---
    # Switch: true to use bits/stdc++.h, false to use custom PCH.h
    USE_BITS_STD := true
    ifeq ($(USE_BITS_STD),true)
        PCH_HEADER := bits/stdc++.h
    else
        PCH_HEADER := PCH.h
    endif
    CXX          := g++
    PCH_FILE     := $(PCH_DIR)/$(PCH_HEADER).gch
    # GCC searches directory for .gch files matching the include
    PCH_USE_FLAGS := -isystem $(PCH_DIR)
endif

# +-----------------------------------------------------------------------+
# |                      COMPILER & DEPENDENCY LOGIC                      |
# +-----------------------------------------------------------------------+

# Compiler and flags
# Added -MMD -MP to generate .d dependency files automatically
CXXFLAGS := -std=c++23 -O2 -Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -MMD -MP

# Competitive Programming Debug Flags
DEBUG_CXXFLAGS := -DERO_LOCAL -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -fsanitize=address

ifeq ($(DEBUG),true)
    CXXFLAGS += $(DEBUG_CXXFLAGS)
endif

# +-----------------------------------------------------------------------+
# |               PERFORMANCE TOOLS & FORMAT DEFINITIONS                  |
# +-----------------------------------------------------------------------+

# Detect Time Command:
# GNU Time is required for the -f flag. We prefer /usr/bin/time.
ifneq ($(wildcard /usr/bin/time),)
    TIME_CMD := /usr/bin/time
else
    TIME_CMD := time
endif

# Format string for the time command
TIME_FMT := '\n[PERFORMANCE STATS]\n  Algorithm (User):\t%Us\n  System (I/O):\t\t%Ss\n  Wall Clock:\t\t%es\n  Memory:\t\t%M KB\n'

# Awk command to convert KB to MB
MEM_CHECK := awk '{if($$1=="Memory:") printf "  Memory:\t\t%.2f MB\n", $$2/1024; else print $$0}'

# +-----------------------------------------------------------------------+
# |                            GENERAL RULES                              |
# +-----------------------------------------------------------------------+

# Default target is 'all' so that running 'make' compiles the solution.
# Note: 'all' depends on the PCH, so it will still be built/checked automatically.
.PHONY: default
default: all

all: $(TARGET)

rebuild: veryclean all

# +-----------------------------------------------------------------------+
# |                        PCH COMPILATION RULES                          |
# +-----------------------------------------------------------------------+

# Logic for building PCH based on detected platform
ifeq ($(IS_PHONE),true)
# Dynamic rule for Phone (Direct file compilation)
$(PCH_FILE): $(PCH_HEADER)
	@rm -f $@
	@mkdir -p $(dir $@)
	@echo "[PCH-PHONE] Precompiling $<..."
	@$(CXX) $(CXXFLAGS) -x c++-header $< -o $@
	@echo "[PCH] Created $@"
else
# Dynamic rule to precompile any header to .gch (Desktop/GCC)
$(PCH_FILE):
	@rm -f $@
	@mkdir -p $(dir $@)
	@echo "[PCH-DESKTOP] Precompiling $(PCH_HEADER)..."
	@$(CXX) $(CXXFLAGS) -x c++-header "$$(echo '#include<$(PCH_HEADER)>' | $(CXX) $(CXXFLAGS) -H -E -x c++ - 2>&1 >/dev/null | head -1 | cut -d ' ' -f2)" -o $@
	@echo "[PCH] Created $@"
endif

.PRECIOUS: $(PCH_FILE)

# Named target to create all PCH files manually
.PHONY: pch
pch: $(PCH_FILE)

# +-----------------------------------------------------------------------+
# |                       EXECUTABLE BUILD LOGIC                          |
# +-----------------------------------------------------------------------+

%: %.cpp # Cancel the builtin rule

# Compile executable using PCH.
# This rule ensures that running 'make' or 'make all' triggers 'pch' first.
$(TARGET): $(PROBLEM_NAME).cpp $(PCH_FILE)
	@echo "[BUILD] Compiling $(PROBLEM_NAME).cpp with $(CXX)..."
	@$(CXX) $(CXXFLAGS) $(PCH_USE_FLAGS) $< -o $@
	@echo "[BUILD] Created executable: $(TARGET)"
.PRECIOUS: %

# Load dependency files if they exist (automates recompilation on header changes)
-include *.d

# +-----------------------------------------------------------------------+
# |                        DIAGNOSTICS & RUNNING                          |
# +-----------------------------------------------------------------------+

# debug-pch: Verifies if the compiler is actually hitting the .gch/.pch file.
debug-pch: $(PCH_FILE)
	@echo "=== PCH Debug Check ($(PLATFORM)) ==="
	@echo "[INFO] Platform Phone: $(IS_PHONE)"
	@echo "[INFO] Compiler: $(CXX)"
	@echo "[INFO] Compiling $(PROBLEM_NAME).cpp with -H to show headers..."
	@$(CXX) $(CXXFLAGS) -H $(PCH_USE_FLAGS) $(PROBLEM_NAME).cpp -o /dev/null 2>&1 | grep -E '\.(gch|pch)' || echo "[WARN] No PCH file detected in header chain"
	@echo "---"
	@echo "Look for '! $(PCH_FILE)' above to confirm usage."

# 'run' is for quick, interactive execution where timing is not the focus.
run: $(TARGET)
	@echo "[RUN] Executing $(TARGET)..."
	@$(EXECUTE)

ifeq ($(DEBUG),true)
	@echo "[INFO] Built with DEBUG flags enabled, code may be slower than normal"
endif
.PHONY: run

# +-----------------------------------------------------------------------+
# |                         TESTING & BENCHMARKING                        |
# +-----------------------------------------------------------------------+

# ------------------------------------------------------------------------------------
# -- Performance Metrics for Competitive Programming --
# KEY METRIC: "Algorithm (User)" + "System (I/O)" must be under the time limit.
# ------------------------------------------------------------------------------------

# 'bench' is for accurate timing using a dedicated input file (bench.input).
.PHONY: bench
bench: $(TARGET)
	@# Ensure the bench.input file exists before trying to run.
	@if [ ! -f $(IO_DIR)/bench.input ]; then \
			echo "[ERROR] $(IO_DIR)/bench.input not found. Please create it."; \
			exit 1; \
		fi
	@echo "[BENCH] Running $(TARGET) with $(IO_DIR)/bench.input..."
	@$(TIME_CMD) -f $(TIME_FMT) $(EXECUTE) < $(IO_DIR)/bench.input 2>&1 | $(MEM_CHECK)

ifeq ($(DEBUG),true)
	@echo "[INFO] Built with DEBUG flags enabled, code may be slower than normal"
endif

# Runs with input, captures output to .res and timing to .time inside io/
$(IO_DIR)/%.res: $(TARGET) $(IO_DIR)/%.in
	@(echo "[RUN] Running with $(IO_DIR)/$*.in...") && \
		( ($(TIME_CMD) -f $(TIME_FMT) $(EXECUTE) < $(IO_DIR)/$*.in > $(IO_DIR)/$*.res) 2>&1 | $(MEM_CHECK) > $(IO_DIR)/$*.time )
.PRECIOUS: $(IO_DIR)/%.res

%.out: % # Cancel builtin rule

# Logic:
# 1. Try to use 'output' command. Pass/Fail depends on its exit code.
# 2. If 'output' missing, use 'diff -w'. Pass/Fail depends on exit code.
__test_%: $(IO_DIR)/%.res $(IO_DIR)/%.out
	@if command -v output >/dev/null 2>&1; then \
		if output $(IO_DIR)/$*.res $(IO_DIR)/$*.out; then \
			echo "✅ Case $* Passed"; \
		else \
			echo "❌ Case $* Failed"; \
			exit 1; \
		fi \
	else \
		if diff -w $(IO_DIR)/$*.res $(IO_DIR)/$*.out >/dev/null; then \
			echo "✅ Case $* Passed"; \
		else \
			echo "❌ Case $* Failed"; \
			diff -w $(IO_DIR)/$*.res $(IO_DIR)/$*.out; \
			exit 1; \
		fi \
	fi
.PHONY: __test_%

# File discovery logic for cases and tests
CASES := $(sort $(basename $(notdir $(wildcard $(IO_DIR)/*.in))))
TESTS := $(sort $(basename $(notdir $(wildcard $(IO_DIR)/*.out))))

test: $(TARGET) $(patsubst %,__test_%,$(TESTS))
.PHONY: test

# +-----------------------------------------------------------------------+
# |                            STRESS TESTING                             |
# +-----------------------------------------------------------------------+

# Compile the brute force solution (uses PCH for speed on phone)
$(STRESS_DIR)/brute: $(STRESS_DIR)/brute.cpp $(PCH_FILE)
	@echo "[STRESS] Compiling brute-force solution..."
	@$(CXX) $(CXXFLAGS) $(PCH_USE_FLAGS) $< -o $@

# Compile the random input generator (uses PCH for speed on phone)
$(STRESS_DIR)/gen: $(STRESS_DIR)/gen.cpp $(PCH_FILE)
	@echo "[STRESS] Compiling input generator..."
	@$(CXX) $(CXXFLAGS) $(PCH_USE_FLAGS) $< -o $@

# 'stress' command: 
# 1. Ensures main solution, brute, and gen are compiled.
# 2. Makes the script executable and runs it.
stress: all $(STRESS_DIR)/brute $(STRESS_DIR)/gen
	@echo "[STRESS] Starting stress test loop..."
	@chmod +x $(STRESS_DIR)/stress.sh
	@cd $(STRESS_DIR) && ./stress.sh
.PHONY: stress

# +-----------------------------------------------------------------------+
# |                                CLEANUP                                |
# +-----------------------------------------------------------------------+

# clean: Removes executable, dependency files, and temporary test/stress files.
clean:
	-rm -rf $(CLEAN_TARGETS) *.res *.time *.d
	-rm -f $(IO_DIR)/*.res $(IO_DIR)/*.time
	-rm -f $(STRESS_DIR)/brute $(STRESS_DIR)/gen $(STRESS_DIR)/gen_input $(STRESS_DIR)/sol_output $(STRESS_DIR)/brute_output
.PHONY: clean

# veryclean: Full reset including the Precompiled Header folder.
veryclean: clean
	-rm -rf $(PCH_DIR)
.PHONY: veryclean
