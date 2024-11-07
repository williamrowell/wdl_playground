MINIWDL_CFG=./miniwdl.cfg
MINIWDL_CALL_CACHE=./miniwdl_call_cache
MINIWDL_SINGULARITY_CACHE=./miniwdl_singularity_cache
MINIWDL_OUTPUT=./miniwdl_test_output

check:
	miniwdl check --strict $(wdl).wdl \
	&& java -jar $$HOME/bin/womtool-86.jar validate $(wdl).wdl \
	&& java -jar $$HOME/bin/wdlTools-0.17.17.jar check $(wdl).wdl --verbose \
	&& echo "Workflow is valid" \
	|| echo "Workflow is invalid"

template:
	mkdir -p inputs/templates
	miniwdl input_template $(wdl).wdl > inputs/templates/$(wdl).inputs.json \
	&& cp inputs/templates/$(wdl).inputs.json inputs/$(wdl).dummy.inputs.json

run:
	for i in inputs/$(wdl).*.inputs.json; do \
	miniwdl run --verbose \
	--dir $(MINIWDL_OUTPUT)/$$(basename $$i .inputs.json)/ \
	--cfg $(MINIWDL_CFG) \
	--input $$i \
	$(wdl).wdl; \
	done \
	&& echo "All tests passed" \
	|| echo "At least one test failed"
