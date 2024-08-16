# +--------------------+
# |                    |
# |   GENERAL CONFIG   |
# |                    |
# +--------------------+

PROBLEM_NAME := ${PROBLEM_NAME}
DEBUG := true
LANG := cpp

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

CXX := g++
CXXFLAGS := -std=c++20 -O2 -Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op
DEBUG_CXXFLAGS = -DERO_LOCAL -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC
# CXXFLAGS := -std=c++20 -O2 -Wall -Wextra -pedantic -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -Wno-unused-result -Wno-sign-conversion
# DEBUG_CXXFLAGS := -fsanitize=address -fsanitize=undefined -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow -fno-sanitize-recover=all -fstack-protector-all -D_FORTIFY_SOURCE=2
# DEBUG_CXXFLAGS += -DERO_DEBUG -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC

PRECOMPILE_HEADERS := bits/stdc++.h
#PRECOMPILE_HEADERS := bits/extc++.h


# +-------------------+
# |                   |
# |   GENERAL RULES   |
# |                   |
# +-------------------+

all: $(TARGET)
.PHONY: all

clean:
	-rm -rf $(CLEAN_TARGETS)
.PHONY: clean

veryclean:
	-rm -rf $(CLEAN_TARGETS) *.res
.PHONY: veryclean

rebuild: clean all
.PHONY: rebuild

# +---------------------+
# |                     |
# |   C++ COMPILATION   |
# |                     |
# +---------------------+

ifeq ($(DEBUG),true)
CXXFLAGS += $(DEBUG_CXXFLAGS)
endif

PCH := .precompiled_headers
CLEAN_TARGETS += $(PCH)

# Create the precompiled_headers dir if not found
$(PCH)/%.gch:
	rm -f $@
	mkdir -p $(dir $@)
	$(LINK.cpp) -x c++-header "$$(echo '#include<$*>' | $(LINK.cpp) -H -E -x c++ - 2>&1 >/dev/null | head -1 | cut -d ' ' -f2)" -o $@
.PRECIOUS: $(PCH)/%.gch

%: %.cpp # Cancel the builtin rule
# End creation

%: %.cpp $(patsubst %,$(PCH)/%.gch,$(PRECOMPILE_HEADERS))
	$(LINK.cpp) -isystem $(PCH) $< $(LOADLIBES) $(LDLIBS) -o $@
.PRECIOUS: %


# +-----------------------+
# |                       |
# |   RUNNING / TESTING   |
# |                       |
# +-----------------------+

export TIME=\n  real\t%es\n  mem\t%MKB\n

run: $(TARGET)
	\time $(EXECUTE)
ifeq ($(DEBUG),true)
	@echo "Built with DEBUG flags enabled, code may be slower than normal"
endif
.PHONY: run

%.res: $(TARGET) %.in
	\time $(EXECUTE) < $*.in > $*.res
ifeq ($(DEBUG),true)
	@echo "Built with DEBUG flags enabled, code may be slower than normal"
endif
.PRECIOUS: %.res

%.out: % # Cancel the builtin rule

__test_%: %.res %.out
	# diff -c --label=$*.res --label=$*.out $*.res $*.out
	output $*.res $*.out
.PHONY: __test_%

CASES := $(sort $(basename $(wildcard *.in)))
TESTS := $(sort $(basename $(wildcard *.out)))

runs: $(patsubst %,%.res,$(CASES))
.PHONY: run

solve: runs
.PHONY: solve

test: $(patsubst %,__test_%,$(TESTS))
.PHONY: test
