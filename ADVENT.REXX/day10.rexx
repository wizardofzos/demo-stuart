/* REXX */                                                              00010000
                                                                        00020000
NUMERIC DIGITS 300                                                      00031042
NUMERIC FUZZ 100                                                        00031155
                                                                        00032009
map.1  = '###..#.##.####.##..###.#.#..'                                 00040001
map.2  = '#..#..###..#.......####.....'                                 00050001
map.3  = '#.###.#.##..###.##..#.###.#.'                                 00060001
map.4  = '..#.##..##...#.#.###.##.####'                                 00070001
map.5  = '.#.##..####...####.###.##...'                                 00080001
map.6  = '##...###.#.##.##..###..#..#.'                                 00090001
map.7  = '.##..###...#....###.....##.#'                                 00100001
map.8  = '#..##...#..#.##..####.....#.'                                 00110001
map.9  = '.#..#.######.#..#..####....#'                                 00120001
map.10 = '#.##.##......#..#..####.##..'                                 00130001
map.11 = '##...#....#.#.##.#..#...##.#'                                 00140001
map.12 = '##.####.###...#.##........##'                                 00150001
map.13 = '......##.....#.###.##.#.#..#'                                 00160001
map.14 = '.###..#####.#..#...#...#.###'                                 00170001
map.15 = '..##.###..##.#.##.#.##......'                                 00180001
map.16 = '......##.#.#....#..##.#.####'                                 00190001
map.17 = '...##..#.#.#.....##.###...##'                                 00200001
map.18 = '.#.#..#.#....##..##.#..#.#..'                                 00210001
map.19 = '...#..###..##.####.#...#..##'                                 00220001
map.20 = '#.#......#.#..##..#...#.#..#'                                 00230001
map.21 = '..#.##.#......#.##...#..#.##'                                 00240001
map.22 = '#.##..#....#...#.##..#..#..#'                                 00250001
map.23 = '#..#.#.#.##..#..#.#.#...##..'                                 00260001
map.24 = '.#...#.........#..#....#.#.#'                                 00270001
map.25 = '..####.#..#..##.####.#.##.##'                                 00280001
map.26 = '.#.######......##..#.#.##.#.'                                 00290001
map.27 = '.#....####....###.#.#.#.####'                                 00300001
map.28 = '....####...##.#.#...#..#.##.'                                 00310001
map.0  = 28                                                             00311001
                                                                        00312001
tst.1 = '.#..#'                                                         00313001
tst.2 = '.....'                                                         00314001
tst.3 = '#####'                                                         00315001
tst.4 = '....#'                                                         00316001
tst.5 = '...##'                                                         00317001
tst.0 = 5                                                               00320001
                                                                        00330001
tst1.1 = '.#....#####...#..'                                            00331099
tst1.2 = '##...##.#####..##'                                            00332099
tst1.3 = '##...#...#.#####.'                                            00333099
tst1.4 = '..#.....#...###..'                                            00334099
tst1.5 = '..#.#.....#....##'                                            00335099
tst1.0 = 5                                                              00336099
                                                                        00337099
ast. = '.'                                                              00340072
maxx = 0                                                                00341006
maxy = 0                                                                00342006
                                                                        00343006
coords. = ''                                                            00344073
coords.0 = 0                                                            00345073
asteroids = 0                                                           00346073
                                                                        00347073
do j = 1 to tst1.0                                                      00350099
  do k = 1 to length(tst1.j)                                            00351099
    y = j                                                               00351276
    x = k                                                               00351376
    maxx = x - 1                                                        00351499
    maxy = y - 1                                                        00351599
    if substr(tst1.j,k,1) = '#' then do                                 00351699
      say "(" || x || "," || y || ") has asteroid"                      00351775
      px = x - 1                                                        00351881
      py = y - 1                                                        00351981
      ast.px.py = '#'                                                   00352081
      asteroids = asteroids + 1                                         00352173
      coords.asteroids = px','py                                        00352282
      coords.0 = asteroids                                              00352382
    end /*                                                              00352454
    else do                                                             00352501
      say "(" || x || "," || y || ") has no asteroid"                   00352602
    end */                                                              00352754
  end                                                                   00353001
end                                                                     00360001
                                                                        00370004
                                                                        00370253
                                                                        00371082
say "There are "coords.0" asteroids"                                    00371187
fullmap. = '.'                                                          00371299
do cc = 1 to coords.0                                                   00371382
  parse var coords.cc xloc","yloc                                       00371599
  fullmap.xloc.yloc = '#'                                               00371699
end                                                                     00371782
do jj = 0 to maxy                                                       00371899
  line = ''                                                             00371999
  do kk = 0 to maxx                                                     00372099
    line = line || fullmap.kk.jj                                        00372199
  end                                                                   00372299
  say line                                                              00372399
end                                                                     00372499
                                                                        00372552
seemap. = '.'                                                           00372949
maxSeen = 0                                                             00373099
bestX   = 0                                                             00373199
bestY   = 0                                                             00373299
do a = 1 to coords.0                                                    00373385
  parse var coords.a x ',' y                                            00373585
  seenlist.= ''                                                         00373799
  seenlist.0 = 0                                                        00373899
  seen = 0                                                              00373999
  do b = 1 to coords.0                                                  00374086
    parse var coords.b x2 ',' y2                                        00374186
    if coords.b /= coords.a then do                                     00374399
      dx = x2 - x                                                       00374586
      dy = y2 - y                                                       00374686
      dx = dx % gcd(dx,dy)                                              00374799
      dy = dy % gcd(x2-x,dy)                                            00374899
      found = 0                                                         00375099
      do sss = 1 to seenlist.0                                          00375199
        if seenlist.sss = dx','dy then do                               00375299
          found = 1                                                     00375399
        end                                                             00375499
      end                                                               00375599
      if found = 0 then do                                              00375699
        seen = seen + 1                                                 00375799
        seenlist.seen = dx','dy                                         00375899
        seenlist.0 = seen                                               00375999
      end                                                               00376099
    end                                                                 00376186
  end                                                                   00377086
  seemap.x.y = seen                                                     00377199
  if seen > maxSeen then do                                             00377399
    maxSeen = seen                                                      00377499
    bestX = x                                                           00377599
    bestY = y                                                           00377699
  end                                                                   00377799
end                                                                     00377807
                                                                        00377949
do yy = 0 to maxy                                                       00378088
  line = ''                                                             00378149
  do xx = 0 to maxx                                                     00378288
    line = line || seemap.xx.yy                                         00378349
  end                                                                   00378449
  say line                                                              00378549
end                                                                     00378649
                                                                        00378708
say "Best coord ="bestX","bestY" with ("maxSeen") visibles"             00378815
                                                                        00378908
vaporized. = ''                                                         00379099
vaporized.1 = bestX','bestY  /* not really vaporizing our station */    00379199
vaporized.0 = 1                                                         00379299
                                                                        00379399
do while vaporized.0 /= coords.0                                        00379499
  nearestpoints. = ''                                                   00379599
  nearestpoints.0 = 0                                                   00379699
  nearest = 0                                                           00379799
  do a = 1 to coords.0                                                  00379999
    say "Checks for "coords.a                                           00380099
    parse var coords.a x ',' y                                          00380199
    gotthisone = 0                                                      00380299
    do sss = 1 to vaporized.0                                           00380399
      if vaporized.sss = x','y then gotthisone = 1                      00380499
    end                                                                 00380599
    if gotthisone = 0 then do                                           00380699
      dx = x - bestX                                                    00380799
      dy = y - bestY                                                    00380899
      dx = dx % gcd(dx,dy)                                              00380999
      dy = dy % gcd(x-bestX,dy)                                         00381099
      /* find closest points if not already */                          00381199
      nearx = 1000000000000                                             00381299
      neary = 1000000000000                                             00381399
      do ggg = 1 to nearestpoints.0                                     00381499
        if nearestpoints.ggg = dx','dy then do                          00381699
          parse var nearestpoints.ggg nearx ',' neary                   00381799
          say "HAVE IT...."nearx "," neary                              00381899
        end                                                             00381999
      end                                                               00382099
      checka = abs(x - bestX) + abs(y - bestY)                          00382199
      checkb = abs(nearx - bestX) + abs(neary - bestY)                  00382299
      if checka < checkb then do                                        00382399
        nearest = nearest + 1                                           00382499
        nearestpoints.nearest = x','y                                   00382599
        nearestpoints.0 = nearest                                       00382699
      end                                                               00382899
    end                                                                 00383099
  end                                                                   00383199
                                                                        00383299
  do mmm = 1 to nearestpoints.0                                         00383399
    parse var nearestpoints.mmm ax','ay                                 00383499
    /* need to sort them from up then clockwise */                      00383599
    /* so lets' not to tangents in rexx :( */                           00383699
    say "adding "nearestpoints.mmm                                      00384299
    vaporized.0 = vaporized.0 + 1                                       00384399
    new = vaporized.0                                                   00384499
    vaporized.new = nearestpoints.mmm                                   00384599
  end                                                                   00384699
  do mmm = 1 to nearestpoints.0                                         00384799
    say "adding "nearestpoints.mmm                                      00384899
    vaporized.0 = vaporized.0 + 1                                       00384999
    new = vaporized.0                                                   00385099
    vaporized.new = nearestpoints.mmm                                   00385199
  end                                                                   00385299
end                                                                     00385399
exit                                                                    00385608
                                                                        00385708
                                                                        00385813
                                                                        00385913
FLOOR: procedure                                                        00386058
  parse arg num                                                         00386158
  num = format(num,,,0)                                                 00386258
  if pos('.',num) = 0 then                                              00386358
    return format(num)                                                  00386458
  val = left(num,pos('.',num)-1)                                        00386558
  if val < 0 then val = val - 1                                         00386658
  return format(val)                                                    00386758
                                                                        00387058
gcd: procedure                                                          00390068
xgcd=arg(1)                                                             00400099
line ="GCD for "xgcd                                                    00400199
do jgcd=2 to arg()                                                      00401099
line = line ||' ' || arg(jgcd)                                          00401199
ygcd=arg(jgcd)                                                          00401299
If ygcd<>0 Then Do                                                      00401399
    do until zgcd==0                                                    00401499
      zgcd=xgcd//ygcd                                                   00401599
      xgcd=ygcd                                                         00401699
      ygcd=zgcd                                                         00401799
      end                                                               00401868
    end                                                                 00401968
end                                                                     00402068
/*say line                                                              00402199
say "returning: "abs(xgcd) */                                           00402299
return abs(xgcd)                                                        00402399
                                                                        00403013
distance:                                                               00410008
  parse arg xa,ya,xb,yb                                                 00420008
  dx = xb - xa                                                          00430008
  dy = yb - ya                                                          00440008
  sum = (dx*dx) + (dy*dy)                                               00450008
  res = sqrt(sum)                                                       00460008
  return res                                                            00470008
                                                                        00480008
sqrt:                                                                   00490008
  parse arg number                                                      00500008
  guess = number / 2                                                    00510008
  do 100                                                                00520008
    new_guess = (guess + (number / guess)) / 2                          00530008
    guess = new_guess                                                   00540008
  end                                                                   00550008
  return guess                                                          00560008
                                                                        00570099
