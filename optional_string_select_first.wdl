version 1.0

# this workflow lints cleanly with miniwdl check, but fails at runtime

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