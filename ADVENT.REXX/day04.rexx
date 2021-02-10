/* REXX */

range = "158126-624574"


o = check('112233')
say   o
o = check('123444')
say   o
o = check('111122')
say   o


Call validPasses range, 1
call validPasses range, 2



exit

validPasses:
  parse arg r,part
  say "range:"r
  say "cehck for part "part
  parse var r low'-'high
  valids. = ''
  vcount = 0
  say "Finding passes from "low" to "high
  do p = low to high
    lowest = 0
    posval = 1
    do i = 1 to 6
      if substr(p,i,1) >= lowest then do
        lowest = substr(p,i,1)
      end
      else do
        posval = 0
        leave
      end
    end
    if posval = 1 then do
      posval = 0
      prev = substr(p,1,1)
      do i = 2 to 6
        if substr(p,i,1) = prev then do
          posval = 1
          leave
        end
        else do
          prev = substr(p,i,1)
        end
      end
      if posval = 1 then do
        if part = 1 then do
          vcount = vcount + 1
          valids.vcount = p
        end
      end
      if part =2 then do
        x = check(p)
        if x = 1 then do
          vcount = vcount + 1
          valids.vcount = p
        end
      end
    end
  end
  say "There are "vcount" valid passes"
  return 0


check:
  parse arg passwd
  pl= translate(passwd,'ABCDEFGHIJ','0123456789')
  curr = substr(pl,1,1)
  len = 1
  r = ''
  do i = 2 to 6
    if substr(pl,i,1) = curr then do
      len = len + 1
      if i = 6 then do
        r = r || len || 'x' || curr
      end
    end
    else do
      r = r || len || 'x' || curr
      len = 1
      curr = substr(pl,i,1)
    end
  end
  if pos('2',r) > 0 then
    res = 1
  else
    res = 0
  return res
