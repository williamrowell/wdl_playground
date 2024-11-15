version 1.0

workflow wf {
  input {
    String? name
  }
  output {
    String workflow_name = "hello" + if defined(name) then "~{" " + name}" else ""
  }
}