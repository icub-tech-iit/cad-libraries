# -*- coding: utf-8 -*-
"""
Created on Mon Jun 23 07:28:03 2014

@author: Alberto Parmiggiani
"""

import shelve
import matplotlib.pyplot as pl

             
def main():
    # open the dictionary containing all components data
    dictAct = shelve.open("actuatorsDB", writeback=True)
    
#    aStr = 'iCub2 prono-supination'
#     pl.plot(dictAct[aStr].xy1[0], dictAct[aStr].xy1[1], 'b', label = aStr)
#     pl.plot(dictAct[aStr].xy2[0], dictAct[aStr].xy2[1], 'b--')
#     pl.plot(dictAct[aStr].xy3[0], dictAct[aStr].xy3[1], 'b-.')
    
#    aStr = 'RBE01210A + CSD 14 100'
#    pl.plot(dictAct[aStr].xy1[0], dictAct[aStr].xy1[1], 'c', label = aStr)
#    pl.plot(dictAct[aStr].xy2[0], dictAct[aStr].xy2[1], 'c--')
#    pl.plot(dictAct[aStr].xy3[0], dictAct[aStr].xy3[1], 'c-.')

#    aStr = 'RBE00513A + CSD 14 100'
#    pl.plot(dictAct[aStr].xy1[0], dictAct[aStr].xy1[1], 'm', label = aStr)
#    pl.plot(dictAct[aStr].xy2[0], dictAct[aStr].xy2[1], 'm--')
#    pl.plot(dictAct[aStr].xy3[0], dictAct[aStr].xy3[1], 'm-.')

#    
#    aStr = 'C2900524 + CSD 17 100'
#    pl.plot(dictAct[aStr].xy1[0], dictAct[aStr].xy1[1], 'm', label = aStr)
#    pl.plot(dictAct[aStr].xy2[0], dictAct[aStr].xy2[1], 'm--')
#    pl.plot(dictAct[aStr].xy3[0], dictAct[aStr].xy3[1], 'm-.')
#    
    aStr = 'C2900525 + CSD 17 100'
    pl.plot(dictAct[aStr].xy1[1], dictAct[aStr].xy1[0], 'r', label = aStr)
    pl.plot(dictAct[aStr].xy2[1], dictAct[aStr].xy2[0], 'r--')
    pl.plot(dictAct[aStr].xy3[1], dictAct[aStr].xy3[0], 'r-.')
#
#    aStr = 'C2900525 + CSD-2UH 20 100'
#    pl.plot(dictAct[aStr].xy1[0], dictAct[aStr].xy1[1], 'g', label = aStr)
#    pl.plot(dictAct[aStr].xy2[0], dictAct[aStr].xy2[1], 'g--')
#    pl.plot(dictAct[aStr].xy3[0], dictAct[aStr].xy3[1], 'g-.')

#    aStr = 'CER joint 1 w. Mecapion i=40:1'
#    pl.plot(dictAct[aStr].xy1[0], dictAct[aStr].xy1[1], 'b', label = aStr)
#    pl.plot(dictAct[aStr].xy2[0], dictAct[aStr].xy2[1], 'b--')
#    pl.plot(dictAct[aStr].xy3[0], dictAct[aStr].xy3[1], 'b-.')
#    
#    aStr = 'CER joint 1 w. Mecapion i=120:1'
#    pl.plot(dictAct[aStr].xy1[0], dictAct[aStr].xy1[1], 'c', label = aStr)
#    pl.plot(dictAct[aStr].xy2[0], dictAct[aStr].xy2[1], 'c--')
#    pl.plot(dictAct[aStr].xy3[0], dictAct[aStr].xy3[1], 'c-.')
 
    pl.ylabel(r'$\tau$ [Nm]')
    pl.xlabel(r'$\omega$ [rpm]')
    pl.legend()
    pl.show()

    dictAct.close()

main()