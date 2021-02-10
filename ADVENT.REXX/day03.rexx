/* REXX */                                                              00010000
                                                                        00020000
/* DAY 3 - Crossed Wires */                                             00030000
/* Not finished */                                                      00031010
/* comment from github */
l1 = "R75,D30,R83,U83,L12,D49,R71,U7,L72"                               00050000
l2 = "U62,R66,U55,R34,D71,R55,D58,R83"                                  00060000
                                                                        00070000
                                                                        00073005
p1. = ''                                                                00074005
p2. = ''                                                                00075005
                                                                        00076005
p1c = 0                                                                 00077005
p2c = 0                                                                 00078005
p1c = parsePath(l1,1)                                                   00080006
trace i                                                                 00080108
say p1c                                                                 00080209
do ii = 1 to p1c                                                        00081005
  say p1.ii                                                             00082005
end                                                                     00083005
                                                                        00090000
exit                                                                    00100000
                                                                        00110000
parsePath:                                                              00120000
  parse arg path pathnum                                                00130005
  p = translate(path, ' ', ',')                                         00140000
  curx = 0                                                              00150001
  cury = 0                                                              00160001
  p1c = 0                                                               00161006
  p2c = 0                                                               00162006
  do i = 1 to words(p)                                                  00170001
    a = word(p,i)                                                       00171003
    d = substr(a,1,1)                                                   00172003
    l = substr(a,2)                                                     00173003
    do j = 1 to l                                                       00174004
      if d = 'R' then curx = curx + 1                                   00174104
      if d = 'L' then curx = curx - 1                                   00174204
      if d = 'U' then cury = cury + 1                                   00174304
      if d = 'D' then cury = cury - i                                   00174404
      if pathnum = 1 then do                                            00174505
        p1c = p1c + 1                                                   00174605
        p1.p1c = curx','cury                                            00174705
      end                                                               00174805
      if pathnum = 2 then do                                            00174905
        p2c = p2c + 1                                                   00175005
        p2.p2c = curx','cury                                            00175105
      end                                                               00175205
    end                                                                 00176004
  end                                                                   00180001
  if pathnum = 1 then return p1c                                        00190006
  if pathnum = 2 then return p2c                                        00200006
                                                                        00210006
