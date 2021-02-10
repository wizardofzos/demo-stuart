/* REXX */                                                              00010001
                                                                        00020000
parse source stuff                                                      00030001
parse var stuff a b c d lib rest                                        00040001
INPUT = LIB"(DAY06TS)"                                                  00050046
input = "'"input"'"                                                     00060001
                                                                        00070001
"ALLOC  DA("input") F(INDD) SHR REUSE"                                  00080001
"EXECIO * DISKR INDD (STEM IN."                                         00110001
                                                                        00120002
                                                                        00121004
orbits. = ''                                                            00122009
orbits.0 = 0                                                            00122109
ocount = 0                                                              00122215
planets. = ''                                                           00122309
planets.0 = 0                                                           00122409
pcount = 0                                                              00122514
                                                                        00122636
known = ''                                                              00122737
                                                                        00123004
paths. = ''                                                             00124048
totpaths = 0                                                            00124148
                                                                        00125048
do i = 1 to in.0                                                        00130002
  a = word(in.i,1)                                                      00140004
  parse var a planet ")" moon                                           00141004
  totpaths = totpaths + 1                                               00142048
  paths.totpaths = planet' 'moon                                        00143048
  paths.0 = totpaths                                                    00144048
end                                                                     00150002
                                                                        00150116
say "Input parsed"                                                      00150216
                                                                        00150348
do i = 1 to paths.0                                                     00150450
  say paths.i                                                           00150550
end                                                                     00150650
                                                                        00150750
say "do it"                                                             00150853
                                                                        00150953
do i = 1 to paths.0                                                     00151148
  amount = words(paths.i)                                               00151250
  do j = 2 to amount                                                    00151354
    k = word(paths.i,j)                                                 00151451
    do l = 1 to paths.0                                                 00151550
      if l /= i then do                                                 00151652
        if word(paths.l,1) = k then do                                  00151752
          toadd = words(paths.l)                                        00151857
          do m = 2 to toadd                                             00151957
            paths.i = paths.i' 'word(paths.l,m)                         00152057
          end                                                           00152157
        end                                                             00152252
      end                                                               00152352
    end                                                                 00152450
  end                                                                   00152550
end                                                                     00152648
                                                                        00152736
do i = 1 to paths.0                                                     00153050
  say paths.i                                                           00154050
end                                                                     00155050
                                                                        00156058
do i = 1 to paths.0                                                     00156158
  amount = words(paths.i)                                               00156258
  do j = 2 to amount                                                    00156358
    k = word(paths.i,j)                                                 00156458
    do l = 1 to paths.0                                                 00156558
      if l /= i then do                                                 00156658
        if word(paths.l,1) = k then do                                  00156758
          toadd = words(paths.l)                                        00156858
          do m = 2 to toadd                                             00156958
            paths.i = paths.i' 'word(paths.l,m)                         00157058
          end                                                           00157158
        end                                                             00157258
      end                                                               00157358
    end                                                                 00157458
  end                                                                   00157558
end                                                                     00157658
                                                                        00158058
                                                                        00161005
                                                                        00169655
do i = 1 to paths.0                                                     00169755
  say paths.i                                                           00169855
end                                                                     00169955
                                                                        00170055
exit                                                                    00171055
                                                                        00180009
knownPlanet:                                                            00190009
  parse arg p                                                           00200009
  howmany = words(known)                                                00210037
  do findthem = 1 to howmany                                            00220036
    if word(known,findthem) = p then return 1                           00221037
  end                                                                   00230009
  return 0                                                              00240009
                                                                        00250044
hasMoons:                                                               00260044
  parse arg p                                                           00270044
  return words(orbits.p)                                                00280044
