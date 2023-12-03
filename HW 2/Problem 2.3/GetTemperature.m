function tB = GetTemperature(pP,tB,tAmb,tau,cH)

    if pP < 0.01
        deltaTB = - (tB-tAmb) / tau;
    else
        deltaTB = cH * pP;
    end
    tB = tAmb + deltaTB;
    
end