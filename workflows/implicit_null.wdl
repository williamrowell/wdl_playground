version 1.0

struct MyStruct {
  String? myoptionalstr
}

workflow wf {
  input {
    MyStruct mystruct
  }

  call opt_check_if_defined as check_in_task_defined {
    input:
      myinput = "defined_input"
  }

  call opt_check_if_defined as check_in_task_undefined {
    input:
      myinput = mystruct.myoptionalstr
  }


  call opt_no_check as no_check_defined {
    input:
      myinput = "defined_input"
  }

  call opt_no_check as no_check_undefined {
    input:
      myinput = mystruct.myoptionalstr
  }

  call opt_no_check as no_check_condtional_in_call_undefined {
    input:
      myinput = if defined(mystruct.myoptionalstr) then mystruct.myoptionalstr else "UNSET"
  }

  call opt_no_check as no_check_select_first_in_call_undefined {
    input:
      myinput = select_first([mystruct.myoptionalstr, "UNSET"])
  }

  output {
    String check_in_task_defined_output                   = check_in_task_defined.out
    String check_in_task_undefined_output                 = check_in_task_undefined.out
    String no_check_defined_output                        = no_check_defined.out
    String no_check_undefined_output                      = no_check_undefined.out
    String no_check_condtional_in_call_undefined_output   = no_check_condtional_in_call_undefined.out
    String no_check_select_first_in_call_undefined_output = no_check_select_first_in_call_undefined.out
  }
}

task opt_check_if_defined {
  input {
    String? myinput
  }

  command <<<
    set -e
    echo "Input was ~{if defined(myinput) then myinput else 'undefined'}"
  >>>

  output {
    String out = read_string(stdout())
  }

  runtime {
		docker: "ubuntu:jammy"
		cpu: 1
		memory: "2 GiB"
	}
}

task opt_no_check {
  input {
    String? myinput
  }

  command <<<
    set -e
    echo "Input was ~{myinput}"
  >>>

  output {
    String out = read_string(stdout())
  }

  runtime {
		docker: "ubuntu:jammy"
		cpu: 1
		memory: "2 GiB"
	}
}
