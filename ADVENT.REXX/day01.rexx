/* REXX */                                                              00010000
                                                                        00011022
/* Solving day one for Advent of Code in REXX on z/OS */                00012022
/* And doing some final testing on zigi 1.2 :)        */                00013023
                                                                        00020000
say "testing"                                                           00030000
f = fuel(12)                                                            00040001
say "Fuel for mass 12 ="f                                               00050001
f = fuel(14)                                                            00060008
say "Fuel for mass 14 ="f                                               00070008
f = fuel(1969)                                                          00080008
say "Fuel for mass 1969 ="f                                             00090008
f = fuel(100756)                                                        00100008
say "Fuel for mass 100656 ="f                                           00110008
                                                                        00120000
                                                                        00130012
parse source stuff                                                      00140012
parse var stuff a b c d lib rest                                        00150013
input = lib"(DAY01IN)"                                                  00160014
input = "'"input"'"                                                     00170015
                                                                        00180013
"ALLOC  DA("input") F(INDD) SHR REUSE"                                  00190015
sumpart1 = 0                                                            00200014
sumpart2 = 0                                                            00210016
"EXECIO * DISKR INDD (STEM IN."                                         00220014
do i = 1 to in.0                                                        00230014
  sumpart1 = sumpart1 + fuel(in.i)                                      00240014
  sumpart2 = sumpart2 + withfuel(in.i)                                  00250016
end                                                                     00260014
                                                                        00270014
say "Sum part1 = "sumpart1                                              00280014
say "Sum part2 = "sumpart2                                              00281019
                                                                        00290014
exit                                                                    00300000
                                                                        00310000
fuel:                                                                   00320000
  parse arg mass                                                        00330000
  x = mass / 3                                                          00340000
  x = FLOOR(x)                                                          00350003
  x = x - 2                                                             00360004
  return x                                                              00370004
                                                                        00380016
withfuel:                                                               00390016
  parse arg mass                                                        00400016
  f = fuel(mass)                                                        00410016
  r = 0                                                                 00420016
  do while f > 0                                                        00430018
    r = r + f                                                           00440016
    f = fuel(f)                                                         00450016
  end                                                                   00451017
  return r                                                              00460016
                                                                        00470016
floor:                                                                  00480003
  parse arg number                                                      00490003
  parse var number num '.' decimals                                     00500010
  if num = "NUM"                                                        00510007
  then return number                                                    00520007
  else return num                                                       00530006
