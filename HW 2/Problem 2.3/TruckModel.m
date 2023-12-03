function newVelocity = TruckModel(alpha,gravitation,tB,pP,tMax,gear,cB,truckMass,deltaT,oldVelocity)

    % v(t+delta_t) = delta_t(F_g/M-F_b/M-F_{eb}/M)+v(t)
    
    %Fg/M 
    gForce = gravitation * sin(alpha*pi/180);

    
    %Fb/M
    if tB < tMax - 100
        bForce = gravitation / 20 * pP;
    else
        eulerFactor = exp(-(tB - (tMax - 100)) / 100);
        bForce = gravitation / 20 * pP * eulerFactor;
    end


    %Feb/M
    gearRatios = [7.0, 5.0, 4.0, 3.0, 2.5, 2.0, 1.6, 1.4, 1.2, 1.0];
    eBForce = gearRatios(gear) * cB / truckMass;
    
    newVelocity = deltaT*(gForce-bForce-eBForce)+oldVelocity;
end

