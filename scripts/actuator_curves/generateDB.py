# -*- coding: utf-8 -*-
"""
Created on Wed Jul 16 13:34:38 2014

@author: Alberto Parmiggiani

Version History
---------------
XX.XX           YYYYMMDD   Author    Description
01.00           2014????   alberto   first release
02.00           20150831   alberto   added Mecapion motor
03.00           20220603     divya   added eCub joint components & actuators

"""

from components import *
import shelve


def main():
    ''' open a dictionary to save all components data '''
    dictComp = shelve.open("componentsDB", writeback=True)
    ''' open a dictionary to save all actuator data '''
    dictAct = shelve.open("actuatorsDB", writeback=True)
    # insert component and corresponding data
    dictComp['Faulhaber 1016M012'] = \
        motor('Faulhaber 1016M012', 0.0013, 0.00289, [], 6650, 14700, [], [], 12, [], 31.6, 344, [], [], [], [], [], [])
    dictComp['Faulhaber 1224N012'] = \
        motor('Faulhaber 1224N012', 0.0017, [], [], 8500, [], [], [], 12, [], [], [], [], [], [], [], [], [])
    dictComp['Faulhaber 2342S012CR'] = \
        motor(name='Faulhaber 2342S012CR',
              ratedTorque=0.017,
              contStallTorque=0.08,
              peakTorque=0.23,
              ratedSpeed=7000,
              noLoadSpeed=12000,
              torqueConst=0.0134,
              backEMFConst=1.4,
              designVoltage=12,
              busVoltage=[],
              resistance=1.9,
              inductance=0.101 / 1000,
              NPoles=[],
              outerDiam=23,
              airgapDiam=[],
              innerDiam=[],
              tolalLength=42,
              stackLength=[])
    dictComp['Kollmorgen RBE00513-A'] = \
        motor(name='Kollmorgen RBE00513-A',
              ratedTorque=0.057948,
              contStallTorque=0.0854,
              peakTorque=0.23,
              ratedSpeed=11700,
              noLoadSpeed=18000,
              torqueConst=0.0226,
              backEMFConst=2.36,
              designVoltage=28,
              busVoltage=[],
              resistance=1.11,
              inductance=0.34 / 1000,
              NPoles=6,
              outerDiam=26.67,
              airgapDiam=12,
              innerDiam=4.80,
              tolalLength=34.54,
              stackLength=25.4)
    dictComp['Kollmorgen RBE01211-A'] = \
        motor(name='Kollmorgen RBE01211-A',
              ratedTorque=0.15,
              contStallTorque=0.22,
              peakTorque=0.806,
              ratedSpeed=9680,
              noLoadSpeed=14000,
              torqueConst=0.041,
              backEMFConst=4.29,
              designVoltage=42,
              busVoltage=[],
              resistance=0.664,
              inductance=0.32 / 1000,
              NPoles=8,
              outerDiam=[],
              airgapDiam=[],
              innerDiam=[],
              tolalLength=[],
              stackLength=[])
    dictComp['Kollmorgen RBE01210-A'] = \
        motor(name='Kollmorgen RBE01210-A',
              ratedTorque=0.07335,
              contStallTorque=0.22,
              peakTorque=0.806,
              ratedSpeed=9680,
              noLoadSpeed=18500,
              torqueConst=0.041,
              backEMFConst=4.29,
              designVoltage=42,
              busVoltage=[],
              resistance=0.664,
              inductance=0.32 / 1000,
              NPoles=8,
              outerDiam=[],
              airgapDiam=[],
              innerDiam=[],
              tolalLength=[],
              stackLength=[])
    dictComp['Kollmorgen RBE01510-A'] = \
        motor(name='Kollmorgen RBE01510-A',
              ratedTorque=0.1218,
              contStallTorque=0.19,
              peakTorque=0.55,
              ratedSpeed=7450,
              noLoadSpeed=11500,
              torqueConst=0.0407,
              backEMFConst=4.26,
              designVoltage=32,
              busVoltage=[],
              resistance=0.814,
              inductance=0.32 / 1000,
              NPoles=12,
              outerDiam=[],
              airgapDiam=[],
              innerDiam=[],
              tolalLength=[],
              stackLength=[])
    dictComp['Kollmorgen RBE01511-A'] = \
        motor(name='Kollmorgen RBE01511-A',
              ratedTorque=0.2316,
              contStallTorque=0.384,
              peakTorque=1.15,
              ratedSpeed=5400,
              noLoadSpeed=8333,
              torqueConst=0.0833,
              backEMFConst=8.73,
              designVoltage=47,
              busVoltage=[],
              resistance=1.04,
              inductance=0.58 / 1000,
              NPoles=12,
              outerDiam=[],
              airgapDiam=[],
              innerDiam=[],
              tolalLength=[],
              stackLength=[])
    dictComp['Kollmorgen RBE01810-A'] = \
        motor(name='Kollmorgen RBE01810-A',
              ratedTorque=0.2835,
              contStallTorque=0.429,
              peakTorque=1.53,
              ratedSpeed=7040,
              noLoadSpeed=10250,
              torqueConst=0.0855,
              backEMFConst=8.95,
              designVoltage=63,
              busVoltage=[],
              resistance=1.22,
              inductance=0.9 / 1000,
              NPoles=12,
              outerDiam=[],
              airgapDiam=[],
              innerDiam=[],
              tolalLength=[],
              stackLength=[])
    dictComp['Kollmorgen RBE01811-C'] = \
        motor(name='Kollmorgen RBE01811-C',
              ratedTorque=0.546,
              contStallTorque=0.856,
              peakTorque=3.04,
              ratedSpeed=5250,
              noLoadSpeed=7500,
              torqueConst=0.121,
              backEMFConst=12.7,
              designVoltage=67,
              busVoltage=[],
              resistance=0.753,
              inductance=0.92 / 1000,
              NPoles=12,
              outerDiam=[],
              airgapDiam=[],
              innerDiam=[],
              tolalLength=[],
              stackLength=[])
    dictComp['MOOG C2900525'] = \
        motor(name='MOOG C2900525',
              ratedTorque=0.18,
              contStallTorque=0.22,
              peakTorque=0.8,
              ratedSpeed=6000,
              noLoadSpeed=11900,
              torqueConst=0.047,
              backEMFConst=4.08,
              designVoltage=48,
              busVoltage=[],
              resistance=0.682,
              inductance=0.452 / 1000,
              NPoles=8,
              outerDiam=[],
              airgapDiam=[],
              innerDiam=[],
              tolalLength=[],
              stackLength=[])
    dictComp['MOOG C2900524'] = \
        motor(name='MOOG C2900524',
              ratedTorque=0.09,
              contStallTorque=0.11,
              peakTorque=0.8,
              ratedSpeed=6000,
              noLoadSpeed=22160,
              torqueConst=0.025,
              backEMFConst=2.2,
              designVoltage=48,
              busVoltage=[],
              resistance=0.731,
              inductance=0.34 / 1000,
              NPoles=8,
              outerDiam=[],
              airgapDiam=[],
              innerDiam=[],
              tolalLength=[],
              stackLength=[])
    dictComp['Maxon EC-i 40 70W 36V'] = \
        motor(name='Maxon EC-i 40 70W 36V',
              ratedTorque=0.075,
              contStallTorque=0.0829,
              peakTorque=1.41,
              ratedSpeed=6000,
              noLoadSpeed=10700,
              torqueConst=0.0315,
              backEMFConst=2.2,
              designVoltage=36,
              busVoltage=[],
              resistance=0.807,
              inductance=0.644 / 1000,
              NPoles=7,
              outerDiam=40,
              airgapDiam=[],
              innerDiam=[],
              tolalLength=36,
              stackLength=[])
    dictComp['Mavilor FC13'] = \
        motor(name='Mavilor FC13',
              ratedTorque=0.15,
              contStallTorque=0.2,
              peakTorque=1.2,
              ratedSpeed=10000,
              noLoadSpeed=20000,
              torqueConst=0.018,
              backEMFConst=1.885,
              designVoltage=36,
              busVoltage=[],
              resistance=0.169,
              inductance=0.025 / 1000,
              NPoles=4,
              outerDiam=32,
              airgapDiam=[],
              innerDiam=[],
              tolalLength=70,
              stackLength=[])
    # TODO: check ratedTorque and ratedSpeed
    dictComp['Mecapion APM-SA01A'] = \
        motor(name='Mecapion APM-SA01A',
              ratedTorque=0.318,
              contStallTorque=0.35,
              peakTorque=0.95,
              ratedSpeed=3000,
              noLoadSpeed=5000,
              torqueConst=0.135,
              backEMFConst=12.7,
              designVoltage=48,
              busVoltage=[],
              resistance=2.9,
              inductance=0.2 / 1000,
              NPoles=4,
              outerDiam=40,
              airgapDiam=[],
              innerDiam=[],
              tolalLength=70,
              stackLength=[])

    dictComp['HPC M1 40-1 worm drive'] = \
        reducer(name='HPC M1 40-1 worm drive',
                reductionRatio=40,
                efficiency=0.25,
                efficiencyData=[],
                maxContTorque=40,
                maxTempTorque=40,
                maxContSpeed=[],
                maxTempSpeed=[])

    dictComp['HPC M1 120-1 worm drive'] = \
        reducer(name='HPC M1 120-1 worm drive',
                reductionRatio=120,
                efficiency=0.25,
                efficiencyData=[],
                maxContTorque=40,
                maxTempTorque=40,
                maxContSpeed=[],
                maxTempSpeed=[])

    dictComp['Harmonic Drive HFUC-2A 8-100'] = \
        reducer(name='Harmonic Drive HFUC-2A 8-100',
                reductionRatio=100,
                efficiency=[],
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.83, 0.8, 0.75, 0.7]],
                maxContTorque=3.3,
                maxTempTorque=4.8,
                maxContSpeed=6500,
                maxTempSpeed=14000)
    dictComp['Harmonic Drive HFUC-2A 14-100'] = \
        reducer(name='Harmonic Drive HFUC-2A 14-100',
                reductionRatio=100,
                efficiency=[],
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.83, 0.8, 0.75, 0.7]],
                maxContTorque=11,
                maxTempTorque=28,
                maxContSpeed=3500,
                maxTempSpeed=8500)
    dictComp['Harmonic Drive HFUC-2A 17-100'] = \
        reducer(name='Harmonic Drive HFUC-2A 17-100',
                reductionRatio=100,
                efficiency=[],
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.85, 0.82, 0.78, 0.74]],
                maxContTorque=39,
                maxTempTorque=54,
                maxContSpeed=3500,
                maxTempSpeed=7300)
    dictComp['Harmonic Drive HFUC-2A 20-100'] = \
        reducer(name='Harmonic Drive HFUC-2A 20-100',
                reductionRatio=100,
                efficiency=[],
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.85, 0.82, 0.78, 0.74]],
                maxContTorque=49,
                maxTempTorque=82,
                maxContSpeed=3500,
                maxTempSpeed=6500)
    dictComp['Harmonic Drive HFUC-2A 25-100'] = \
        reducer(name='Harmonic Drive HFUC-2A 25-100',
                reductionRatio=100,
                efficiency=[],
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.85, 0.82, 0.78, 0.74]],
                maxContTorque=108,
                maxTempTorque=157,
                maxContSpeed=3500,
                maxTempSpeed=6500)
    dictComp['Harmonic Drive CSD-2A 17-100'] = \
        reducer(name='Harmonic Drive CSD-2A 17-100',
                reductionRatio=100,
                efficiency=[],
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.79, 0.75, 0.70, 0.64]],
                maxContTorque=27,
                maxTempTorque=37,
                maxContSpeed=3500,
                maxTempSpeed=7300)
    dictComp['Harmonic Drive CSD-2A 14-100'] = \
        reducer(name='Harmonic Drive CSD-2A 14-100',
                reductionRatio=100,
                efficiency=[],
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.72, 0.68, 0.62, 0.55]],
                maxContTorque=7.7,
                maxTempTorque=19,
                maxContSpeed=3500,
                maxTempSpeed=7300)
    dictComp['Harmonic Drive CSD-2UH 20-100'] = \
        reducer(name='Harmonic Drive CSD-2UH 20-100',
                reductionRatio=100,
                efficiency=[],
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.79, 0.75, 0.70, 0.64]],
                maxContTorque=34,
                maxTempTorque=57,
                maxContSpeed=3500,
                maxTempSpeed=6500)

    dictComp['none'] = \
        reducer(name='none',
                reductionRatio=1,
                efficiency=[],
                efficiencyData=[],
                maxContTorque=[],
                maxTempTorque=[],
                maxContSpeed=[],
                maxTempSpeed=[])

    dictComp['MOOG C2900525'].busVoltage = 36
    dictComp['Kollmorgen RBE01210-A'].busVoltage = 40
    dictComp['Kollmorgen RBE01211-A'].busVoltage = 40
    dictComp['Kollmorgen RBE01510-A'].busVoltage = dictComp['Kollmorgen RBE01510-A'].designVoltage
    dictComp['Kollmorgen RBE01510-A'].designVoltage = 36
    dictComp['Kollmorgen RBE01511-A'].busVoltage = 36
    dictComp['Kollmorgen RBE01810-A'].busVoltage = 36
    dictComp['Mecapion APM-SA01A'].busVoltage = 24

    # TODO: verify all data from TQ ILM 50x08 & CPL 20-160    
    dictComp['TQ ILM 50x08 SS'] = \
        motor(name='TQ ILM 50x08 SS',
              ratedTorque=0.30,
              contStallTorque=0.6, #(?)
              peakTorque=0.96,
              ratedSpeed=6850,
              noLoadSpeed=12000, #mech no load speed
              torqueConst=0.058,
              backEMFConst=7.007, #(?)
              designVoltage=48,
              busVoltage=[], # 32 (?)
              resistance=0.54,
              inductance=0.49/1000,
              NPoles=10,
              outerDiam=50,
              airgapDiam=[],
              innerDiam=30,
              tolalLength=16.4,
              stackLength=[]) 

    dictComp['TQ ILM 70x10 DS'] = \
        motor(name='TQ ILM 70x10 DS',
              ratedTorque=0.66,
              contStallTorque=1.3, #(?)
              peakTorque=2.13,
              ratedSpeed=6300,
              noLoadSpeed=10000, #mech no load speed
              torqueConst=0.109,
              backEMFConst=7.619, #(?)
              designVoltage=48,
              busVoltage=[], # 32 (?)
              resistance=0.47,
              inductance=0.91/1000,
              NPoles=10,
              outerDiam=69,
              airgapDiam=[],
              innerDiam=42,
              tolalLength=22.6,
              stackLength=[]) 
        
    dictComp['Harmonic Drive CPL-2A 20-160'] = \
        reducer(name='Harmonic Drive CPL-2A 20-160',
                reductionRatio=160,
                efficiency=[], #0.74
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.78, 0.74, 0.66, 0.58]],
                maxContTorque=49, #average torque
                maxTempTorque=92, #repeatable peak
                maxContSpeed=3500,
                maxTempSpeed=6500)        

    dictComp['Harmonic Drive CSD-2A 25-160'] = \
        reducer(name='Harmonic Drive CSD-2A 25-160',
                reductionRatio=160,
                efficiency=[], #0.66
                efficiencyData=[[500, 1000, 2000, 3500],
                                [0.72, 0.66, 0.57, 0.50]],
                maxContTorque=75, #average torque
                maxTempTorque=123, #repeatable peak
                maxContSpeed=3500,
                maxTempSpeed=5600)

    aStr = 'iCub3 medium actuator'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['MOOG C2900525'],
                             red=dictComp['Harmonic Drive HFUC-2A 17-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'iCub3 low power actuator'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['MOOG C2900524'],
                             red=dictComp['Harmonic Drive HFUC-2A 17-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'RBE00513A + CSD 14 100'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Kollmorgen RBE00513-A'],
                             red=dictComp['Harmonic Drive CSD-2A 14-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'RBE01210A + CSD 14 100'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Kollmorgen RBE01210-A'],
                             red=dictComp['Harmonic Drive CSD-2A 14-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'RBE01211A + CSD 17 100'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Kollmorgen RBE01211-A'],
                             red=dictComp['Harmonic Drive CSD-2A 17-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'C2900524 + CSD 17 100'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['MOOG C2900524'],
                             red=dictComp['Harmonic Drive CSD-2A 17-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'C2900525 + CSD 17 100'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['MOOG C2900525'],
                             red=dictComp['Harmonic Drive CSD-2A 17-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'C2900525 + CSD-2UH 20 100'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['MOOG C2900525'],
                             red=dictComp['Harmonic Drive CSD-2UH 20-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'iCub3 high power actuator var1'  # not good
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Kollmorgen RBE01510-A'],
                             red=dictComp['Harmonic Drive HFUC-2A 20-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'iCub3 high power actuator var2'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Kollmorgen RBE01511-A'],
                             red=dictComp['Harmonic Drive HFUC-2A 20-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'iCub3 high power actuator var3'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Kollmorgen RBE01511-A'],
                             red=dictComp['Harmonic Drive HFUC-2A 25-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'iCub3 high power actuator var4'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Kollmorgen RBE01810-A'],
                             red=dictComp['Harmonic Drive HFUC-2A 25-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'CER joint 1 w. Maxon'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Maxon EC-i 40 70W 36V'],
                             red=dictComp['HPC M1 40-1 worm drive'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'CER joint 1 w. Mecapion i=40:1'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Mecapion APM-SA01A'],
                             red=dictComp['HPC M1 40-1 worm drive'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'CER joint 1 w. Mecapion i=120:1'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Mecapion APM-SA01A'],
                             red=dictComp['HPC M1 120-1 worm drive'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'Maxon EC-i 40 70W 36V'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Maxon EC-i 40 70W 36V'],
                             red=dictComp['none'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'Mavilor FC13'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Mavilor FC13'],
                             red=dictComp['none'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'iCub2 prono-supination'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['Faulhaber 2342S012CR'],
                             red=dictComp['Harmonic Drive HFUC-2A 8-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'eCub2 small joint'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['TQ ILM 50x08 SS'],
                             red=dictComp['Harmonic Drive CSD-2A 17-100'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'eCub2 medium joint'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['TQ ILM 50x08 SS'],
                             red=dictComp['Harmonic Drive CPL-2A 20-160'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    aStr = 'eCub2 large joint'
    dictAct[aStr] = actuator(name=aStr,
                             mot=dictComp['TQ ILM 70x10 DS'],
                             red=dictComp['Harmonic Drive CSD-2A 25-160'])
    dictAct[aStr].xy1, dictAct[aStr].xy2, dictAct[aStr].xy3 = \
        computeActuatorCurves(dictAct[aStr])

    dictComp.sync()
    dictAct.sync()
    dictComp.close()
    dictAct.close()


main()
