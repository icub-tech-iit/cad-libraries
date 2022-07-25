# -*- coding: utf-8 -*-
"""
Created on Mon Jun 23 07:28:03 2014

@author: Alberto Parmiggiani

Version History
---------------
XX.XX           YYYYMMDD   Author    Description
01.00           20140623   alberto   first release (?)
02.00           20220603     divya   added eCub actuator combinations + bug fix

"""

import shelve
import matplotlib.pyplot as pl

             
def main():
    # open the dictionary containing all components data
    dictAct = shelve.open("actuatorsDB", writeback=True)
    
    # aStr = 'iCub2 prono-supination'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'b', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'b--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'b-.')
    
    # aStr = 'RBE01210A + CSD 14 100'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'c', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'c--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'c-.')

    # aStr = 'RBE00513A + CSD 14 100'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'm', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'm--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'm-.')

    
    # aStr = 'C2900524 + CSD 17 100'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'm', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'm--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'm-.')
    
    # aStr = 'C2900525 + CSD 17 100'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'r', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'r--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'r-.')

    # aStr = 'C2900525 + CSD-2UH 20 100'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'g', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'g--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'g-.')

    # aStr = 'CER joint 1 w. Mecapion i=40:1'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'b', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'b--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'b-.')
    
    # aStr = 'CER joint 1 w. Mecapion i=120:1'
    # pl.plot(dictAct[aStr].xy1[0], dictAct[aStr].xy1[1], 'c', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[0], dictAct[aStr].xy2[1], 'c--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[0], dictAct[aStr].xy3[1], 'c-.')

    # eCub 2.0 actuator combinations

    # aStr = 'eCub2 small joint'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'y', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'y--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'y-.')

    aStr = 'eCub2 medium joint'
    pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'g', label = 'nominal')
    pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'g--', label = 'peak')
    pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'g-.')
    
    # aStr = 'eCub2 large joint'
    # pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'b', label = 'nominal')
    # pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'b--', label = 'peak')
    # pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'b-.') 
    
    pl.title(aStr)
    pl.ylabel(r'$\tau$ [Nm]')
    pl.xlabel(r'$\omega$ [rpm]')
    pl.legend()
    pl.show()

    dictAct.close()

main()