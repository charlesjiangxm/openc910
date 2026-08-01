# AGENTS.md

This file provides guidance to the AI agent when working with code in this repository.

## Overview

This is the **XuanTie / OpenC910** RISC-V core: **Verilog RTL IP plus a simulation harness**, not a software project. There is no `npm`/`cargo`/`pytest` — every "build" is an RTL simulation driven by `make` in `smart_run/`.

- `C910_RTL_FACTORY/gen_rtl/` — the shipped Verilog RTL (the silicon IP). Treat as read-only; do not refactor casually.
- `smart_run/` — simulation environment (testbench, test cases, Makefile flows). All `make` commands run from here.
- `doc/` — datasheet + user/integration manuals (PDFs).

## Environment setup (csh, order matters)

The login shell is `tcsh`; setup scripts are `.csh` using `setenv`. Before any `make`:

1. `cd C910_RTL_FACTORY && source setup/setup.csh` — sets `CODE_BASE_PATH`. Must run from inside `C910_RTL_FACTORY/` (it strips `/setup` off `pwd`).
2. Edit `smart_run/setup/example_setup.csh` to point `TOOL_EXTENSION` at your installed toolchain, then `source` it. `make buildcase`/`runcase` warn and fail to compile C/asm cases if `TOOL_EXTENSION` is unset.

The toolchain is the **T-Head XuanTie** `riscv64-unknown-elf-` GCC. A stock upstream riscv-gnu toolchain will **not** work — cases compile with `-march=rv64imafdcxtheadc` (the `xtheadc` custom extension) and `-mabi=lp64d`.

## Build & run (from `smart_run/`)

- `work/` is the build output dir but is **not committed** — create it first: `mkdir -p work`. Every target does `cd ./work && …` and fails if it's missing.
- Default simulator is **iverilog** (`SIM=iverilog`). Other options: `SIM=vcs`, `SIM=nc` (irun), `SIM=verilator` (requires **Verilator ≥ 4.215**).
- `make help` lists targets/arguments. `make showcase` prints the valid `CASE=` values.
- Valid cases are `CASE_LIST` in `smart_run/setup/smart_cfg.mk` — **do not invent case names**; only listed ones have build rules.
- `make runcase CASE=<name>` — compile RTL + build the case + run, in one command. `make compile` / `make buildcase CASE=<name>` do the stages separately.

### Verilator is a three-step flow

Unlike iverilog/vcs, Verilator is split: `make compile SIM=verilator` → `make buildVerilator` (compiles emitted C++ via `logical/tb/Makefile_obj`, copied into `work/`) → `make runVerilator` (runs `obj_dir/Vtop`). `runcase … SIM=verilator` chains compile→build→run.

### There is no test runner

No unit-test framework exists. `make regress` runs every case in `CASE_LIST` and writes per-case reports to `smart_run/tests/regress/regress_result/` plus a summary to `tests/regress/regress_report`. "Passing" = inspecting those reports / sim output, not running a `test` script.

`smart_run/impl/mem_icg_test/` is a separate memory-ICG flow: edit its filelist, then `source run_mem_icg_test` from that directory.

## RTL / Verilog conventions

- Module instantiation uses **named `#()` parameter style** (`inst #(.P(v)) u (...);`). This is enforced for tool compliance — do not switch to positional `#(v)` or `defparam`.
- What gets compiled is controlled by **filelists** (`.fl`) under `smart_run/logical/filelists/` and `C910_RTL_FACTORY/gen_rtl/filelists/`. They are **per-simulator and not interchangeable**: iverilog uses `sim.fl`+`tb.fl` (well, `-f ... -c ...`), vcs/nc use `sim.fl`, verilator uses `sim_verilator.fl`+`tb_verilator.fl`. When adding an RTL file, update the relevant filelist or it won't be in the build.

## Repo etiquette

- Default branch is `main`; changes land via PR (commit subjects often reference the PR number, e.g. `… (#37)`). Keep commit subjects short and descriptive; no conventional-commit prefix is used.
- Apache-2.0; T-Head/XuanTie copyright headers are on source files — preserve them when editing.
