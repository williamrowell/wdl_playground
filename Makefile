MINIWDL_CFG=./miniwdl.cfg
MINIWDL_CALL_CACHE=./miniwdl_call_cache
MINIWDL_SINGULARITY_CACHE=./miniwdl_singularity_cache
MINIWDL_OUTPUT=./miniwdl_test_output

WOMTOOL_PATH=$$HOME/bin/womtool-86.jar
WDLTOOLS_PATH=$$HOME/bin/wdlTools-0.17.17.jar

ifndef VERBOSE
.SILENT:
endif

list-tasks:
	@echo list all tasks in workflows/$(wdl).wdl
	miniwdl check workflows/$(wdl).wdl \
	| grep task \
	| sed 's/^[[:blank:]]*//' \
	| cut -d' ' -f2 \
	| sort --unique

find-wdl-task:
	@echo find wdl with task $(task)
	find workflows -name '*.wdl' -exec grep -wl 'task $(task)' '{}' \; | xargs -I {} basename {} .wdl

check:
	miniwdl check --strict workflows/$(wdl).wdl &> /dev/null  \
	|| echo "Workflow failed miniwdl check." \
	&&	java -jar $(WOMTOOL_PATH) validate workflows/$(wdl).wdl &> /dev/null \
	|| echo "Workflow failed womtool validate." \
	&& java -jar $(WDLTOOLS_PATH) check workflows/$(wdl).wdl &> /dev/null \
	|| echo "Workflow failed wdlTools check." \
	&& echo "All checks passed"

check-miniwdl:
	miniwdl check --strict workflows/$(wdl).wdl

check-womtool:
	java -jar $(WOMTOOL_PATH) validate workflows/$(wdl).wdl

check-wdlTools:
	java -jar $(WDLTOOLS_PATH) check workflows/$(wdl).wdl --verbose

template:
	mkdir -p inputs/templates
	miniwdl input_template workflows/$(wdl).wdl > inputs/templates/$(wdl).inputs.json \
	&& cp inputs/templates/$(wdl).inputs.json inputs/$(wdl).dummy.inputs.json

run:
	@echo run tests for workflows/$(wdl).wdl
	for i in inputs/$(wdl).*.inputs.json; do \
	miniwdl run --verbose \
	--dir $(MINIWDL_OUTPUT)/$$(basename $$i .inputs.json)/ \
	--cfg $(MINIWDL_CFG) \
	--input $$i \
	workflows/$(wdl).wdl; \
	done \
	&& echo "All tests passed" \
	|| echo "At least one test failed"
