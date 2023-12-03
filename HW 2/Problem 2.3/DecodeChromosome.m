% nIn = the number of inputs
% nHidden = the number of hidden neurons
% nOut = the number of output neurons
% Weights (and biases) should take values in the range [-wMax,wMax]

function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);

    sizeWIH = nHidden * (nIn + 1);

    chromosomeWIH = chromosome(1:sizeWIH);
    chromosomeWHO = chromosome(sizeWIH + 1:end);

    decodedWIH = 2 * wMax * chromosomeWIH - wMax;
    decodedWHO = 2 * wMax * chromosomeWHO - wMax;

    wIH = reshape(decodedWIH, nHidden, nIn + 1);
    wHO = reshape(decodedWHO, nOut, nHidden + 1);

end