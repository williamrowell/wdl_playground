version 1.0

import "structs.wdl"

workflow wf {
  input {
    Mystruct mystruct
  }
  call t1 {
    input:
      mystruct = mystruct
  }
  output {
    String out = t1.out
  }
}

task t1 {
  input {
    Mystruct mystruct
  }
  command <<<
    echo ~{read_string(write_json(mystruct))} > out
  >>>
  output {
    String out = read_string("out")
  }
}