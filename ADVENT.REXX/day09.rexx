/* REXX */                                                              00010000
                                                                        00020000
NUMERIC DIGITS 20                                                       00021099
                                                                        00022099
input = "'IBMUSER.ADVENT.DAY09.IN'"                                     00023099
                                                                        00024099
"ALLOC  DA("input") F(INDD) SHR REUSE"                                  00025099
"EXECIO * DISKR INDD (STEM IN."                                         00028099
OMGINEEDDEBUG = 0                                                       00124799
r = run2(in.1,1)                                                        00124899
r = run2(in.1,2)                                                        00124999
                                                                        00125073
exit                                                                    00125173
                                                                        00125273
run2:                                                                   00125373
  parse arg prog,in1,in2                                                00125473
  res = "NO OUTPUT"                                                     00125573
  theInput = in1                                                        00125673
  next = 0                                                              00125773
  relbase = 0                                                           00125873
  /* check for saved state */                                           00125973
  if pos('<',prog) > 0 then do                                          00126073
    next = substr(prog,1,pos('<',prog)-1)      /* read saved ins pos */ 00126173
    prog = substr(prog,pos('<',prog)+1)        /* for input wait     */ 00126273
  end                                                                   00126373
  if pos('>',prog) > 0 then do                                          00126473
    next = substr(prog,1,pos('>',prog)-1)      /* read saved ins pos */ 00126573
    prog = substr(prog,pos('=',prog)+1)        /* for output wait    */ 00126673
  end                                                                   00126773
  prog = translate(prog, ' ', ',')             /* get rid of commas  */ 00126873
  instructions = words(prog)                   /* count them all     */ 00126973
  say "There are "instructions" instructions"                           00127099
  originst = instructions                                               00127199
  p. = 0                                       /* stick em in a stem */ 00127299
  do i = 0 to instructions                                              00127373
    p.i= word(prog, i+1)                                                00127473
  end                                                                   00127599
  cont = 1                                     /* no halt psw :)     */ 00127699
  do while cont = 1                                                     00127899
    inst = right(p.next,'5',0)                 /* get the full inst  */ 00128399
    opcode = substr(inst,4,2)                  /* get the opcode     */ 00128499
    mod1   = substr(inst,3,1)                  /* mode parm1         */ 00128573
    mod2   = substr(inst,2,1)                  /*      parm2         */ 00128673
    mod3   = substr(inst,1,1)                  /*      parm3         */ 00128773
    p1     = next + 1                          /* position parm1     */ 00128873
    p2     = next + 2                          /*          parm2     */ 00128973
    p3     = next + 3                          /*          parm3     */ 00129073
    f = debug('inst='inst)                                              00132766
    f = debug('opcode='opcode)                                          00132864
    f = debug('relbase='relbase)                                        00132964
    f = debug('p1   ='p1   )                                            00133082
    f = debug('p2   ='p2   )                                            00133182
    f = debug('p3   ='p3   )                                            00133282
    f = debug('current='next)                                           00133682
    select                                                              00133866
      when opcode = '01' then do               /* Addition           */ 00133966
        a = getData(p1,mod1)                                            00134090
        b = getData(p2,mod2)                                            00134190
        c = getPos(p3,mod3)                                             00134290
        p.c     = a + b                                                 00134382
        next = next + 4                                                 00134566
        f = debug("Adding "a"+" b "-->"c)                               00134683
        iterate                                                         00134766
      end                                                               00134866
      when opcode = '02' then do               /* Multiplication     */ 00134966
        a = getData(p1,mod1)                                            00135090
        b = getData(p2,mod2)                                            00135190
        c = getPos(p3,mod3)                                             00135290
        p.c     = a * b                                                 00135388
        next = next + 4                                                 00135482
        f = debug("Multplying "a"*" b "-->"c)                           00135583
        iterate                                                         00135766
      end                                                               00135866
      when opcode = '03' then do               /* Store              */ 00135966
        a = getPos(p1,mod1)                                             00136699
        f = debug('-------------------------------------------------')  00137199
        f = debug("Reading "theInput" to "a)                            00137299
        p.a = theInput                                                  00137582
        next = next + 2                                                 00137766
        iterate                                                         00137866
      end                                                               00137966
      when opcode = '04' then do               /* Output             */ 00138066
        a = getData(p1,mod1)                                            00138190
        say "*****************************"                             00138266
        say "Output: "a                                                 00138382
        res = a                                                         00138499
        say "*****************************"                             00138536
        next = next + 2                                                 00138619
        iterate                                                         00138700
      end                                                               00138800
      when opcode = '05' then do               /* Jump if true       */ 00138900
        a = getData(p1,mod1)                                            00139090
        b = getData(p2,mod2)                                            00139190
        f = debug("Jump to " b " if " a " /= 0")                        00139287
        if a /= "0" then next = b                                       00139387
                    else next = next + 3                                00139487
        iterate                                                         00139599
      end                                                               00139600
      when opcode = '06' then do               /* Jump if false      */ 00139700
        a = getData(p1,mod1)                                            00139890
        b = getData(p2,mod2)                                            00139990
        f = debug("Jump to " b " if " a " == 0")                        00140087
        if a = "0" then next = b                                        00140187
                   else next = next + 3                                 00140287
        iterate                                                         00140399
      end                                                               00140400
      when opcode = '07' then do               /* Less than          */ 00140500
        a = getData(p1,mod1)                                            00140690
        b = getData(p2,mod2)                                            00140790
        c = getPos(p3,mod3)                                             00140890
        f = debug("Jump to " c " if " a "<" b)                          00140987
        if a < b then p.c = 1                                           00141087
                 else p.c = 0                                           00141187
        next = next + 4                                                 00141200
        iterate                                                         00141399
      end                                                               00141400
      when opcode = '08' then do               /* Equals             */ 00141500
        a = getData(p1,mod1)                                            00141690
        b = getData(p2,mod2)                                            00141790
        c = getPos(p3,mod3)                                             00141890
        f = debug("Set " c "to 1 if " a "=" b)                          00141999
        if a = b then p.c = 1                                           00142087
                 else p.c = 0                                           00142187
        next = next + 4                                                 00142200
      end                                                               00142300
      when opcode = '09' then do               /* Adjust relbase     */ 00142414
        a = getData(p1,mod1)                                            00142590
        f = debug("Adjusting relbase by " a   )                         00142687
        relbase = relbase + a                                           00142887
        next = next + 2                                                 00143014
        iterate                                                         00143199
      end                                                               00143214
      when opcode = '99' then do               /* Terminate          */ 00143314
        say "Finished, output=" a                                       00143499
        cont = 0                                                        00143514
      end                                                               00143614
      otherwise do                                                      00143714
        say "unexpected opcode ("opcode") at "next                      00143814
      end                                                               00143914
    end                                                                 00144014
    if next > instructions then do                                      00144199
      say "I'm beyond myself!"                                          00144299
      cont = 0                                                          00144399
    end                                                                 00144499
    if next > originst then do                                          00144599
      say "I'm beyond myself!"                                          00144699
      cont = 0                                                          00144799
    end                                                                 00144899
  end                                                                   00144999
  return "DONE"                                                         00145099
                                                                        00145199
                                                                        00145299
printprog:                                                              00145399
  parse arg pppp                                                        00145499
  out = ''                                                              00145599
  do kkk = 0 to instructions                                            00145699
    if kkk = next then do                                               00145799
      out = out '>'p.kkk'<'                                             00145899
    end                                                                 00145999
    else                                                                00146099
      out = out p.kkk                                                   00146199
  end                                                                   00146299
  return out                                                            00146399
                                                                        00146499
                                                                        00146599
getData:                                                                00146699
  parse arg position, parmmode                                          00146799
  idx =  getPos(position,parmmode)                                      00146899
  if idx > instructions then do                                         00146999
    instructions = idx                                                  00147199
    return 0                                                            00147299
  end                                                                   00147399
  return p.idx                                                          00147499
                                                                        00147599
getPos:                                                                 00147699
  parse arg pos1, parm1                                                 00147799
  if parm1 = 0 then thepos = p.pos1                                     00147999
  if parm1 = 1 then thepos = pos1                                       00148099
  if parm1 = 2 then thepos = relbase + p.pos1                           00148199
  if thepos > instructions then do                                      00148299
    p.thepos = 0                                                        00148499
    instructions = thepos                                               00148599
  end                                                                   00148699
  return thepos                                                         00148799
                                                                        00148899
debug:                                                                  00148999
  parse arg msg                                                         00149099
  if OMGINEEDDEBUG=1 then say msg                                       00149199
  return 0                                                              00150000
