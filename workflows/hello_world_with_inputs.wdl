version 1.0

workflow wf {
  input {
    String? name
  }
  call t {
    input:
      name = name
  }
  output {
    File out = t.out
  }
}

task t {
  input {
    String name = "world"
  }
  command <<<
    echo "Hello, ~{name}!"
  >>>
  output {
    File out = stdout()
  }
}