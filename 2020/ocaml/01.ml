
let input = 
  let ic = open_in "../inputs/day01.txt" in
  let rec per lst =
    try
      per (lst @ [int_of_string (input_line ic)])
    with
      End_of_file -> lst
  in 
    let ans = per [] in close_in ic; ans

let part_one = 
  let rec per lst = match lst with
    | [] -> 0
    | h::t -> 
      (let ans = (List.fold_left (fun a x -> if (x + h = 2020) then x * h else a) 0 t) in
      if ans = 0 then per t else ans)
  in per input

let print_list f lst = 
  print_string "[";
  let rec per lst = 
    match lst with
    | [] -> ()
    | h::t -> f h; print_string "; "; per t
  in per lst; print_string "]"

let part_two = 
  let rec outer lst = match lst with
    | [] -> None
    | h::t -> 
      (let ans = middle h t in match ans with
        | None -> (match t with | [] -> None | h::t -> middle h t)
        | Some n -> Some n)
  and middle x lst = match lst with
    | [] -> None
    | h::t -> 
      (let ans = inner x h t in match ans with
        | None -> (match t with | [] -> None | h::t -> inner x h t)
        | Some n -> Some n)
  and inner x y lst = match lst with 
    | [] -> None
    | h::t -> 
      let ans = x + y + h in 
      if ans = 2020 then Some (x * y * h) else inner x y t
  in outer input 

let () = 
  print_int part_one; print_string "\n"; print_int (match part_two with | None -> 0 | Some n -> n)