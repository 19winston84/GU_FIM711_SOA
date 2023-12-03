function chromosome = EncodeNetwork(wIH, wHO, wMax)

% Encoding: Starting from two weight matrices (wIH and wHO), of size nHidden x (nIn+1) and
% nOut x (nHidden+1), respectively, generate a single chromosome, such that the
% first nHidden x (nIn+1) genes are used for obtaining wIH and the remaining
% genes for wHO. The genes should take values in the range [0,1] 
% (e.g. 0.219412987333, 0.452951914512, and so on), meaning that the
% weights must be rescaled appropriately (with the help of wMax, see below), 
% during encoding.

    arrayWIH = reshape(wIH, 1, []);
    arrayWHO = reshape(wHO, 1, []);

    encodedWIH = (arrayWIH + wMax) / (2 * wMax);
    encodedWHO = (arrayWHO + wMax) / (2 * wMax);

    chromosome = [encodedWIH, encodedWHO];

end