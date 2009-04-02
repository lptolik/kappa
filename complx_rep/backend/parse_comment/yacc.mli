type token =
  | Comment
  | Percent
  | Sharp
  | Single_rule
  | Double_rule
  | EOL
  | EOF
  | Direct
  | Bi
  | Flag
  | NextLine
  | IDENT of ( string )

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> commented_line list
