// functions
func printText(text_arg: String) -> String {
  let text_var = "Hello, " + text_arg + "!"
  return text_var
}
print(printText(text_arg: "World"))