#!/usr/bin/env bash

# get cromwell and womtool
wget -O bin/cromwell-87.jar \
  https://github.com/broadinstitute/cromwell/releases/download/87/cromwell-87.jar
wget -O bin/womtool-87.jar \
  https://github.com/broadinstitute/cromwell/releases/download/87/womtool-87.jar

# get wdltools
wget -O bin/wdlTools-0.17.17.jar \
  https://github.com/dnanexus/wdlTools/releases/download/0.17.17/wdlTools-0.17.17.jar

# get miniwdl
curl -LsSf https://astral.sh/uv/install.sh | sh
uv venv
source .venv/bin/activate
uv pip install miniwdl