/* REXX */                                                              00010000
                                                                        00020000
NUMERIC DIGITS 20                                                       00021000
                                                                        00022000
input = "'IBMUSER.ADVENT.DAY11.IN'"                                     00023001
                                                                        00024000
"ALLOC  DA("input") F(INDD) SHR REUSE"                                  00025000
"EXECIO * DISKR INDD (STEM IN."                                         00026000
OMGINEEDDEBUG = 0                                                       00027000
r = run2(in.1,0)                                                        00028002
                                                                        00030000
exit                                                                    00040000
                                                                        00050000
run2:                                                                   00060000
  parse arg prog,in1,in2                                                00070000
  res = "NO OUTPUT"                                                     00080000
  theInput = in1                                                        00090000
  next = 0                                                              00100000
  relbase = 0                                                           00110000
  /* check for saved state */                                           00120000
  if pos('<',prog) > 0 then do                                          00121000
    next = substr(prog,1,pos('<',prog)-1)      /* read saved ins pos */ 00122000
    prog = substr(prog,pos('<',prog)+1)        /* for input wait     */ 00123000
  end                                                                   00124000
  if pos('>',prog) > 0 then do                                          00125000
    next = substr(prog,1,pos('>',prog)-1)      /* read saved ins pos */ 00126000
    prog = substr(prog,pos('=',prog)+1)        /* for output wait    */ 00126100
  end                                                                   00126200
  prog = translate(prog, ' ', ',')             /* get rid of commas  */ 00126300
  instructions = words(prog)                   /* count them all     */ 00126400
  say "There are "instructions" instructions"                           00126500
  originst = instructions                                               00126600
  p. = 0                                       /* stick em in a stem */ 00126700
  do i = 0 to instructions                                              00126800
    p.i= word(prog, i+1)                                                00126900
  end                                                                   00127000
  cont = 1                                     /* no halt psw :)     */ 00127100
  do while cont = 1                                                     00127200
    inst = right(p.next,'5',0)                 /* get the full inst  */ 00127300
    opcode = substr(inst,4,2)                  /* get the opcode     */ 00127400
    mod1   = substr(inst,3,1)                  /* mode parm1         */ 00127500
    mod2   = substr(inst,2,1)                  /*      parm2         */ 00127600
    mod3   = substr(inst,1,1)                  /*      parm3         */ 00127700
    p1     = next + 1                          /* position parm1     */ 00127800
    p2     = next + 2                          /*          parm2     */ 00127900
    p3     = next + 3                          /*          parm3     */ 00128000
    f = debug('inst='inst)                                              00129000
    f = debug('opcode='opcode)                                          00130000
    f = debug('relbase='relbase)                                        00131000
    f = debug('p1   ='p1   )                                            00132000
    f = debug('p2   ='p2   )                                            00133000
    f = debug('p3   ='p3   )                                            00133100
    f = debug('current='next)                                           00133200
    select                                                              00133300
      when opcode = '01' then do               /* Addition           */ 00133400
        a = getData(p1,mod1)                                            00133500
        b = getData(p2,mod2)                                            00133600
        c = getPos(p3,mod3)                                             00133700
        p.c     = a + b                                                 00133800
        next = next + 4                                                 00133900
        f = debug("Adding "a"+" b "-->"c)                               00134000
        iterate                                                         00134100
      end                                                               00134200
      when opcode = '02' then do               /* Multiplication     */ 00134300
        a = getData(p1,mod1)                                            00134400
        b = getData(p2,mod2)                                            00134500
        c = getPos(p3,mod3)                                             00134600
        p.c     = a * b                                                 00134700
        next = next + 4                                                 00134800
        f = debug("Multplying "a"*" b "-->"c)                           00134900
        iterate                                                         00135000
      end                                                               00135100
      when opcode = '03' then do               /* Store              */ 00135200
        a = getPos(p1,mod1)                                             00135300
        f = debug('-------------------------------------------------')  00135400
        f = debug("Reading "theInput" to "a)                            00135500
        p.a = theInput                                                  00135600
        next = next + 2                                                 00135700
        iterate                                                         00135800
      end                                                               00135900
      when opcode = '04' then do               /* Output             */ 00136000
        a = getData(p1,mod1)                                            00137000
        say "Output: "a                                                 00138100
        res = a                                                         00138200
        next = next + 2                                                 00138400
        iterate                                                         00138500
      end                                                               00138600
      when opcode = '05' then do               /* Jump if true       */ 00138700
        a = getData(p1,mod1)                                            00138800
        b = getData(p2,mod2)                                            00138900
        f = debug("Jump to " b " if " a " /= 0")                        00139000
        if a /= "0" then next = b                                       00139100
                    else next = next + 3                                00139200
        iterate                                                         00139300
      end                                                               00139400
      when opcode = '06' then do               /* Jump if false      */ 00139500
        a = getData(p1,mod1)                                            00139600
        b = getData(p2,mod2)                                            00139700
        f = debug("Jump to " b " if " a " == 0")                        00139800
        if a = "0" then next = b                                        00139900
                   else next = next + 3                                 00140000
        iterate                                                         00140100
      end                                                               00140200
      when opcode = '07' then do               /* Less than          */ 00140300
        a = getData(p1,mod1)                                            00140400
        b = getData(p2,mod2)                                            00140500
        c = getPos(p3,mod3)                                             00140600
        f = debug("Jump to " c " if " a "<" b)                          00140700
        if a < b then p.c = 1                                           00140800
                 else p.c = 0                                           00140900
        next = next + 4                                                 00141000
        iterate                                                         00141100
      end                                                               00141200
      when opcode = '08' then do               /* Equals             */ 00141300
        a = getData(p1,mod1)                                            00141400
        b = getData(p2,mod2)                                            00141500
        c = getPos(p3,mod3)                                             00141600
        f = debug("Set " c "to 1 if " a "=" b)                          00141700
        if a = b then p.c = 1                                           00141800
                 else p.c = 0                                           00141900
        next = next + 4                                                 00142000
      end                                                               00142100
      when opcode = '09' then do               /* Adjust relbase     */ 00142200
        a = getData(p1,mod1)                                            00142300
        f = debug("Adjusting relbase by " a   )                         00142400
        relbase = relbase + a                                           00142500
        next = next + 2                                                 00142600
        iterate                                                         00142700
      end                                                               00142800
      when opcode = '99' then do               /* Terminate          */ 00142900
        say "Finished, output=" a                                       00143000
        cont = 0                                                        00143100
      end                                                               00143200
      otherwise do                                                      00143300
        say "unexpected opcode ("opcode") at "next                      00143400
      end                                                               00143500
    end                                                                 00143600
    if next > instructions then do                                      00143700
      say "I'm beyond myself!"                                          00143800
      cont = 0                                                          00143900
    end                                                                 00144000
    if next > originst then do                                          00144100
      say "I'm beyond myself!"                                          00144200
      cont = 0                                                          00144300
    end                                                                 00144400
  end                                                                   00144500
  return "DONE"                                                         00144600
                                                                        00144700
                                                                        00144800
printprog:                                                              00144900
  parse arg pppp                                                        00145000
  out = ''                                                              00145100
  do kkk = 0 to instructions                                            00145200
    if kkk = next then do                                               00145300
      out = out '>'p.kkk'<'                                             00145400
    end                                                                 00145500
    else                                                                00145600
      out = out p.kkk                                                   00145700
  end                                                                   00145800
  return out                                                            00145900
                                                                        00146000
                                                                        00146100
getData:                                                                00146200
  parse arg position, parmmode                                          00146300
  idx =  getPos(position,parmmode)                                      00146400
  if idx > instructions then do                                         00146500
    instructions = idx                                                  00146600
    return 0                                                            00146700
  end                                                                   00146800
  return p.idx                                                          00146900
                                                                        00147000
getPos:                                                                 00147100
  parse arg pos1, parm1                                                 00147200
  if parm1 = 0 then thepos = p.pos1                                     00147300
  if parm1 = 1 then thepos = pos1                                       00147400
  if parm1 = 2 then thepos = relbase + p.pos1                           00147500
  if thepos > instructions then do                                      00147600
    p.thepos = 0                                                        00147700
    instructions = thepos                                               00147800
  end                                                                   00147900
  return thepos                                                         00148000
                                                                        00148100
debug:                                                                  00148200
  parse arg msg                                                         00148300
  if OMGINEEDDEBUG=1 then say msg                                       00148400
  return 0                                                              00148500
