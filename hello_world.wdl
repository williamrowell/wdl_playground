version 1.0

workflow wf {
  call t
  output {
    File out = t.out
  }
}

task t {
  command <<<
    echo "Hello, world!"
  >>>
  output {
    File out = stdout()
  }
}