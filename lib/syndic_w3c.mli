module Error : module type of Syndic_error

type error =
  {
    line    : int;    (** Within the source code of the validated document,
                          refers to the line where the error was
                          detected. *)
    column  : int;    (** Within the source code of the validated document,
                          refers to the line where the column was
                          detected. *)
    text    : string; (** The actual error message. *)
    element : string; (** Element in the feed where the message was
                          triggered. *)
    parent  : string; (** In the feed, parent of the element. *)
    value   : string; (** If applicable the value of the element, attribute
                          or content which triggered the message. *)
  }

val url : [< `String of string | `Uri of Uri.t ] -> Uri.t
(** Generate url to go to W3C Feed Validator API. *)

val to_error : error -> Xmlm.pos * string

val parse : ?xmlbase: Uri.t -> Xmlm.input -> error list
(** [parse i] takes [i] and returns a list of error, result of
    {{:http://validator.w3.org/feed/docs/soap} W3C Feed Validator}. *)