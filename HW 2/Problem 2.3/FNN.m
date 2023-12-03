function [pP, deltaGear] = FNN(input,wIH,wHO,sigmoidConstant)
    
    iTmp = size(wIH, 2)-1;
    localFieldHidden = wIH(:, 1:iTmp) * input' - wIH(:,iTmp+1);
    outputHidden = 1 ./ (1 + exp(-sigmoidConstant * localFieldHidden));

    nTmp = size(wHO, 2)-1;
    localFieldOutput = wHO(:, 1:nTmp) * outputHidden - wHO(:,nTmp+1);
    output = 1 ./ (1 + exp(-sigmoidConstant * localFieldOutput));
    
    pP = output(1, 1);
    deltaGear = output(2, 1);
    
end