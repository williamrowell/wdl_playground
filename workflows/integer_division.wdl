version 1.0

workflow wf {
  input {
    Int a
    Int b
  }
  output {
    Int result = a / b
  }
}