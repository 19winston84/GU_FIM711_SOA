function [gear, gearChangeTimeCounter] = GearBox(deltaGear,gear,gearChangeTimeCounter,gearChangeThreshold)

    if deltaGear < 0.33 && gear < 10 && gearChangeTimeCounter >= gearChangeThreshold
        gear = gear + 1;
        gearChangeTimeCounter = 0;
    elseif 0.33 <= deltaGear && deltaGear < 0.66 && gear > 1 && gearChangeTimeCounter >= gearChangeThreshold
        gear = gear - 1; 
        gearChangeTimeCounter = 0;
    else
        % do not change gear (no action required)
    end
    
    gearChangeTimeCounter = gearChangeTimeCounter + 1;