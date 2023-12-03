function results = EvaluateSwarm(positions)
    
    x1 = positions(:, 1);
    x2 = positions(:, 2);

    term1 = (x1.^2 + x2 - 11).^2;
    term2 = (x1 + x2.^2 - 7).^2;

    results = term1 + term2;
    
end