version 1.0

# this workflow lints cleanly with `miniwdl check`, `womtool validate`, and `wdlTools check`, but fails at runtime
# 2024-11-07 15:57:17.895 wdl.w:wf.t:call-t task t (optional_string_select_first.wdl Ln 10 Col 1) failed :: dir: ".//miniwdl_test_output/optional_string_select_first.dummy/20241107_155714_wf/call-t", error: "EvalError", message: "select_first() given empty or all-null array; prevent this or append a default value", pos: {"source": ".//optional_string_select_first.wdl", "line": 16, "column": 22}

workflow wf {
  call t
  output {
    File out = t.out
  }
}

task t {
  input {
    String? name
  }
  command <<<
    if ~{defined(name)}; then
      echo "Hello, ~{select_first([name])}!"
    else
      echo "Hello, world!"
    fi
  >>>
  output {
    File out = stdout()
  }
}