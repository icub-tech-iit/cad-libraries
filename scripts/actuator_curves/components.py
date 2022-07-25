# -*- coding: utf-8 -*-
"""
Created on Mon Jun 23 07:28:03 2014

@author: Alberto Parmiggiani

Version History
---------------
XX.XX           YYYYMMDD   Author    Description
01.00           201407??   alberto   first release
02.00           20140825   alberto   fixed bug in efficiency curve calculation
                                     (function reducer.__init__)
03.00           20150417   alberto   modified actuator and motor curves code to
                                     account for cases where some data are
                                     missing
04.00           20150901   alberto   modified the actuator init and curves
                                     computation functions to fix an issue with
                                     torque saturation for normal gearboxes

"""

import numpy as np
from scipy import optimize


class motor:
    '''
    Parameters
    ----------
    name : str
        motor code / name
    ratedTorque : float
        motor rated torque in [Nm]
        can be calculated from the rated speed and the rated power values
    contStallTorque : float
        motor continuous stall torque [Nm] 
    peakTorque : float
         motor peak torque [Nm]
    ratedSpeed : float
         motor rated speed [rpm] 
    noLoadSpeed : float
        motor no load speed [rpm]
    torqueConst : float
        motor torque constant [Nm/A]
    backEMFConst : float
       motor back-EMF constant [V/krpm]
    designVoltage : float
        motor operating voltage by design [V]
        can be computed dividing the speed at rated power by the back EMF 
        constant
    busVoltage : float
        motor actual operating voltage [V]
    resistance : float
        motor winding resistance [Ohms]
    inductance : float
        motor inductance [mH]
    NPoles : int
        number of magnetic poles
    outerDiam : float
        motor outer diameter [mm]
    airgapDiam : float
        motor airgap diameter [mm]
    innerDiam : float
        motor rotor inner diameter [mm]
    tolalLength : float
        totla motor length [mm]
    stackLength : float
        motor stack length [mm]
    contCurveCoeffs : ndarray
        coeiffcients of the polynomial curve defining the continuous operating 
        region of the motor []

    '''

    def __init__(self, name,
                 ratedTorque, contStallTorque, peakTorque,
                 ratedSpeed, noLoadSpeed,
                 torqueConst, backEMFConst,
                 designVoltage, busVoltage, resistance, inductance, NPoles,
                 outerDiam, airgapDiam, innerDiam, tolalLength, stackLength):
        self.name = name
        self.ratedTorque = ratedTorque
        self.contStallTorque = contStallTorque
        self.peakTorque = peakTorque
        self.ratedSpeed = ratedSpeed
        self.noLoadSpeed = noLoadSpeed
        self.torqueConst = torqueConst
        self.backEMFConst = backEMFConst
        self.designVoltage = designVoltage
        self.busVoltage = busVoltage
        self.resistance = resistance
        self.inductance = inductance
        self.NPoles = NPoles
        self.contCurveCoeffs = []

        '''
        if all needed data are provided compute the motor continuous operation 
        curve.
        The curve is computed as a third order polynomial passing through
        the no load speed point, the stall torque point and the rated power
        point with the form: omega = c1*tau**3 + c2*tau**2 + c3*tau + c4. 
        The three coefficients are calculated with a constrained mimimization
        procedure and stored in the contCurveCoeffs variable.
        This is needed to enforce a proper shape of the polynomial, namely to 
        assure c3 is negative or equal to zero.
        '''

        def f(x, nls, rs, rt, cst):
            ''' return the sum of squared errors '''
            s = [nls, rs, 0]
            t = [0, rt, cst]
            return np.sum((np.polyval(x, t) - s) ** 2)

        if ratedTorque != [] and contStallTorque != [] and \
                        ratedSpeed != [] and noLoadSpeed != []:
            nls, rs, rt, cst = self.noLoadSpeed, self.ratedSpeed, \
                               self.ratedTorque, self.contStallTorque
            c = optimize.fmin_l_bfgs_b(f, np.array([0, 0, 0, nls]), \
                                       args=(nls, rs, rt, cst), \
                                       approx_grad=1, \
                                       bounds=((None, 0), (None, 0), \
                                               (None, 0), (None, nls)))
            self.contCurveCoeffs = c[0]


class reducer:
    '''
    Parameters
    ----------
    name : str
        speed reducer code / name
    reductionRatio : float
        speed reducer reduction ratio [-]
    efficiency : float
        speed reducer efficiency [-]
    efficiencyData : ndarray
        values defining the values of angular velocity and corresponding 
        efficiency values
    maxContTorque : float
        maximum repeatable peak torque [Nm]
    maxTempTorque : float
        momentary peak torque [Nm]
    maxContSpeed : float
        average input speed speed [rpm] 
    maxTempSpeed : float
        maximum input speed speed [rpm]
    '''

    def evalEff(self, x, a, b, c):
        ''' exponential function to fit efficiency data '''
        return a * np.exp(-b * x) + c

    def __init__(self, name, reductionRatio, efficiency, efficiencyData,
                 maxContTorque, maxTempTorque, maxContSpeed,
                 maxTempSpeed):
        self.name = name
        self.reductionRatio = reductionRatio
        self.efficiency = efficiency
        self.efficiencyData = efficiencyData
        ''' NOTE: values reported in the Harmonic
            Drive data-sheet are already ground true and comprise the 
            efficiency scaling '''
        #        print(efficiencyData)
        #        print(efficiency)
        #        print (efficiencyData != [])
        print(name)
        print('max Torque', maxContTorque)
        if efficiencyData != []:
            self.maxContTorque = maxContTorque
            self.maxTempTorque = maxTempTorque
            print('scaling...', maxContTorque)
        else:
            self.maxContTorque = maxContTorque
            self.maxTempTorque = maxTempTorque
            print('not scaling...', maxContTorque)
        self.maxContSpeed = maxContSpeed
        self.maxTempSpeed = maxTempSpeed
        self.efficiencyCoeffs = []
        ''' add a fake point at 10000rpm to enforce an almost constant value of
            the last part of the efficiency curve '''
        if efficiencyData != []:
            x = np.array(np.append(efficiencyData[0], 10000.0))
            y = np.array(np.append(efficiencyData[1], efficiencyData[1][-1]))
            ''' fit the efficiency data with an exponential function '''
            self.efficiencyCoeffs, pcov = optimize.curve_fit(self.evalEff,
                                                             x, y,
                                                             [0, 0, 0.5])

            # few lines for plotting for debug purposes
            # t = np.linspace(0,8000,100)
            # vv = self.evalEff(t, self.efficiencyCoeffs[0], self.efficiencyCoeffs[1], self.efficiencyCoeffs[2] )
            # pl.figure()
            # pl.plot(t,vv)
            # pl.plot(x, y,'rx')


class actuator:
    def __init__(self, name, mot, red):
        if name == []:
            self.name = mot.name + ' ' + red.name
        self.mot = mot
        self.red = red

    xy1 = []
    xy2 = []
    xy3 = []


def computeMotorCurves(m):
    '''
    Compute the characteristic curves of a motor
    
    Return the x-y coordinates defining the continuous and temporary operating
    regions of a given motor
    
    Parameters
    ----------
    m : motor
        Electric motor (motor and speed reducer).
    
    Returns
    -------
    tau : ndarray
        The vector defining the motor torque range.
    y1 : ndarray
        The vector defining the motor angular velocity in the continuous
        operating region.
    y2 : ndarray
        The vector defining the temporary maximum motor angular velocity when 
        the motor is run at its prescribed operating voltage.
    y3 : ndarray
        The vector defining the temporary maximum motor angular velocity when 
        the motor is run with a bus voltage lower than the prescribed 
        operating voltage.
    '''
    if m.contCurveCoeffs == []:
        print('Warning: motor constant operating region coefficients not computed.')
        pass
    else:
        tau = np.linspace(0, m.peakTorque, 150)
        y1 = np.maximum(np.polyval(m.contCurveCoeffs, tau), 0)
        ''' copy y1 to y2 and y3 so that if data are not available script does
        not fail '''
        y2, y3 = y1, y1
        if m.designVoltage != [] and m.inductance != [] and m.resistance != [] and \
                        m.backEMFConst != [] and m.NPoles != []:
            ''' renaming constants to increase formula legibility '''
            V, L, R, Bemf, Kt, p = m.designVoltage, m.inductance, \
                                   m.resistance, m.backEMFConst / 1000, \
                                   m.torqueConst, m.NPoles
            ''' compute angular velocity limit curve taking into consideration
                the limit caused by the inductance of the motor '''
            y2 = (60 * np.sqrt((
                               Kt ** 2 * L ** 2 * p ** 2 * tau ** 2 + 3600 * Bemf ** 2 * Kt ** 4) * V ** 2 - L ** 2 * p ** 2 * tau ** 4 * R ** 2) - 3600 * Bemf * Kt * tau * R) / (
                 L ** 2 * p ** 2 * tau ** 2 + 3600 * Bemf ** 2 * Kt ** 2)
            ''' using numpy.minumum to compare a vector to a scalar '''
            np.minimum(y1, y2, y1)
            ''' compute the limit curve if the bus voltage is different form 
                the design voltage of the motor '''
            if m.busVoltage != []:
                V = m.busVoltage
                y3 = (60 * np.sqrt((
                                   Kt ** 2 * L ** 2 * p ** 2 * tau ** 2 + 3600 * Bemf ** 2 * Kt ** 4) * V ** 2 - L ** 2 * p ** 2 * tau ** 4 * R ** 2) - 3600 * Bemf * Kt * tau * R) / (
                     L ** 2 * p ** 2 * tau ** 2 + 3600 * Bemf ** 2 * Kt ** 2)
                np.minimum(y1, y3, y1)
            else:
                y3 = y2

        y2 = np.append(y2, np.linspace(y2[-1], 0, 100))
        y3 = np.append(y3, np.linspace(y3[-1], 0, 100))
        return np.array([tau, y1]), \
               np.array([np.append(tau, np.repeat(tau[-1], 100)), y2]), \
               np.array([np.append(tau, np.repeat(tau[-1], 100)), y3])


def computeActuatorCurves(a):
    '''
    Compute the characteristic curves of an actuator
    
    Return the x-y coordinates defining the continuous and temporary operating
    regions of a given actuator
    
    Parameters
    ----------
    a : actuator
        actuator type (motor and speed reducer).
    
    Returns
    -------
    tau : ndarray
        The vector defining the actuator torque range (after the speed
        reducer).
    y1 : ndarray
        The vector defining the actuator angular velocity (after the speed 
        reducer) in the continuous operating region.
    y2 : ndarray
        The vector defining the temporary maximum actuator angular velocity 
        (after the speed reducer) when the actuator is run at its prescribed
        operating voltage.
    y3 : ndarray
        The vector defining the temporary maximum actuator angular velocity 
        (after the speed reducer) when the actuator is run with a bus voltage 
        lower than the prescribed operating voltage.
        
    '''

    ''' compute motor torques '''
    xy1, xy2, xy3 = computeMotorCurves(a.mot)

    ''' scale torques by the reducer reduction ratio '''
    xy1[0] = xy1[0] * a.red.reductionRatio
    xy2[0] = xy2[0] * a.red.reductionRatio
    xy3[0] = xy3[0] * a.red.reductionRatio

    ''' apply speed reducer maximum speed saturation '''
    if a.red.maxContSpeed != []:
        np.minimum(xy1[1], a.red.maxContSpeed, xy1[1])
        np.minimum(xy2[1], a.red.maxTempSpeed, xy2[1])
        np.minimum(xy3[1], a.red.maxTempSpeed, xy3[1])

    elif a.red.efficiency != []:
        xy1[0] = xy1[0] * a.red.efficiency
        xy2[0] = xy2[0] * a.red.efficiency
        xy3[0] = xy3[0] * a.red.efficiency

    ''' scale the angular velocities by the reducer reduction ratio '''
    xy1[1] = xy1[1] / a.red.reductionRatio
    xy2[1] = xy2[1] / a.red.reductionRatio
    xy3[1] = xy3[1] / a.red.reductionRatio

    ''' if the efficiency coefficients are available compute curves taking the
        speed reducer efficiency into account '''
    if a.red.efficiencyCoeffs != []:
        xy1[0] = xy1[0] * a.red.evalEff(xy1[1], a.red.efficiencyCoeffs[0],
                                        a.red.efficiencyCoeffs[1], a.red.efficiencyCoeffs[2])
        xy2[0] = xy2[0] * a.red.evalEff(xy2[1], a.red.efficiencyCoeffs[0],
                                        a.red.efficiencyCoeffs[1], a.red.efficiencyCoeffs[2])
        xy3[0] = xy3[0] * a.red.evalEff(xy3[1], a.red.efficiencyCoeffs[0],
                                        a.red.efficiencyCoeffs[1], a.red.efficiencyCoeffs[2])

    ''' apply speed reducer maximum torque saturation
        NOTE: the point of application of this saturation in the script is
        critical. If the saturation is applied before the efficiency scaling
        the script yileds wrong results. '''
    if a.red.maxContTorque != []:
        xy1[0][xy1[0] > a.red.maxContTorque] = a.red.maxContTorque
        xy2[0][xy2[0] > a.red.maxTempTorque] = a.red.maxTempTorque
        xy3[0][xy3[0] > a.red.maxTempTorque] = a.red.maxTempTorque

    return xy1, xy2, xy3
