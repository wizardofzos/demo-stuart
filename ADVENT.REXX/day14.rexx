/* REXX */                                                              00010000
                                                                        00020000
NUMERIC DIGITS 20                                                       00030001
                                                                        00040001
INPUT = "'IBMUSER.ADVENT.DAY14.TEST.IN'"                                00050001
                                                                        00060001
"ALLOC  DA("input") F(INDD) SHR REUSE"                                  00070001
"EXECIO * DISKR INDD (STEM IN."                                         00080001
                                                                        00090002
                                                                        00091004
materials. = ''                                                         00092004
materials.0 = 0                                                         00093004
                                                                        00093118
formulae. = ''                                                          00093218
formulae.0 = 0                                                          00093318
                                                                        00093427
matamount. = 0                                                          00093527
matamount.0 = 0                                                         00093627
                                                                        00093727
do i = 1 to in.0                                                        00100002
  parse var in.i input '=>' output                                      00110003
  amountout = word(output,1)                                            00110113
  materialout = word(output,2)                                          00110213
  if knownMaterial(materialout) = 1 then do                             00111014
    say "Hey there's a recipy for this mat"                             00111104
  end                                                                   00112004
  else do                                                               00113004
    nmc = materials.0 + 1                                               00113104
    materials.nmc = materialout                                         00113217
    materials.0 = nmc                                                   00113305
    formulae.materialout = input                                        00113523
    matamount.materialout = amountout                                   00113628
  end                                                                   00114004
end                                                                     00120002
                                                                        00121005
do l = 1 to materials.0                                                 00122005
  material = materials.l                                                00123126
  say material                                                          00123225
  say matamount.material "of " material "requires" formulae.material    00123327
end                                                                     00124005
                                                                        00125027
ORE = 0                                                                 00126027
required = needMaterial('FUEL')                                         00127033
                                                                        00128031
what = makeMaterial(required)                                           00129034
                                                                        00129136
say what                                                                00129234
                                                                        00130002
exit                                                                    00131004
                                                                        00132004
knownMaterial:                                                          00140004
  parse arg mat                                                         00150004
  say "checking "mat                                                    00151006
  do m = 1 to materials.0                                               00160004
    if materials.m = mat then return 1                                  00170004
  end                                                                   00180004
  return 0                                                              00190004
end                                                                     00200004
                                                                        00210030
needMaterial:                                                           00220033
  parse arg mat                                                         00230030
  return formulae.mat                                                   00240030
                                                                        00250033
makeMaterial:                                                           00260033
  parse arg mat                                                         00261033
  list = ''                                                             00262033
  parse var required part1','rest                                       00270033
  do while part1 /= ''                                                  00280033
    say "need "part1                                                    00290033
    list = list part1                                                   00291035
    required = rest                                                     00300033
    parse var required  part1,','rest                                   00310033
  end                                                                   00320033
  return list                                                           00330034
