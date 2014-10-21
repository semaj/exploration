import List

main : Element
main =  asText <| msort l

l = [7, 1, 2, 6, 3, 9, 8, 5, 4, 0]

msort : [comparable] -> [comparable]
msort l = 
  let half =  floor (toFloat (length l) / 2)
      left = take half l
      right = drop half l
  in
  if (length l == 0 || length l == 1) then l
  else mergin (msort left) (msort right)
  
mergin : [comparable] -> [comparable] -> [comparable]
mergin l r = 
  if | isEmpty l -> r
     | isEmpty r -> l
     | head l < head r -> head l :: (mergin (tail l) r)
     | otherwise -> head r :: (mergin l (tail r))

