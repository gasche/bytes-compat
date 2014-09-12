include String

let empty = ""
let of_string = copy
let to_string = copy

let sub_string = sub
let blit_string = blit

(* these are trivially safe and could be made into an identity
   function, but given that OCaml signatures distinguish between "val"
   and "external", I thought it best to reuse upstream's choice to
   avoid any potential copmatibility hurdles (not that I know
   of any) *)
external unsafe_to_string : t -> string = "%identity"
external unsafe_of_string : string -> t = "%identity"

let extend s left right =
  (* length of the final string *)
  let dstlen = left + length s + right in
  (* length of the included portion of the input string *)
  let srclen = min 0 left + length s + min 0 right in
  let t = create dstlen in
  if srclen > 0 then blit s (max 0 (-left)) t (max 0 left) srclen;
  t

let init len f =
  let s = create len in
  for i = 0 to len - 1 do
    set s i (f i);
  done;
  s

let cat = (^)
