version 1.0

# this workflow lints and runs successfully

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
      echo "Hello, ~{name}!"
    else
      echo "Hello, world!"
    fi
  >>>
  output {
    File out = stdout()
  }
}