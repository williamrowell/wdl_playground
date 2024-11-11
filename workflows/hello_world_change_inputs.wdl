version 1.0

workflow wf {
  input {
    String? name
  }

  # experimenting with different ways to overwrite the input

  String tname = if defined(name) then select_first([name]) else "world"

  call t {
    input:
      name = tname
  }
  output {
    File out = t.out
  }
}

task t {
  input {
    String name
  }
  command <<<
    echo "Hello, ~{name}!"
  >>>
  output {
    File out = stdout()
  }
}