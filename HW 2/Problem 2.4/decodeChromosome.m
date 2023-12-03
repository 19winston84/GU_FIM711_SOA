function yValue  = decodeChromosome(chromosome,numberOfVariables,constantsRegisters,cMax,xPosition)
    
    chromosomeLength = length(chromosome);
    
    % cut it to shorten to dividable by 4
    % if mod(chromosomeLength, 4) ~= 0
    %     chromosome = chromosome(1:4*floor(chromosomeLength/4));
    %     chromosomeLength = length(chromosome);
    % end

    variablesForUnion = [xPosition, zeros(1, numberOfVariables - 1)];
    unionSet = [variablesForUnion, constantsRegisters];

    for iGene = 1:chromosomeLength
            
        if iGene == 4
                
                destination = 1;

                if mod(iGene, 4) == 0
                    indexOperand2 = chromosome(iGene);
                    operand2 = unionSet(indexOperand2);
                
                    if operator == 1
                        unionSet(destination) = operand1 + operand2;
                    end
                    if operator == 2
                        unionSet(destination) = operand1 - operand2;
                    end
                    if operator == 3
                        unionSet(destination) = operand1 * operand2;
                    end
                    if operator == 4
                        if operand2 ~= 0
                            unionSet(destination) = operand1 / operand2;
                        else
                            unionSet(destination) = cMax;
                        end
                    end
                end
        else
            if mod(iGene, 4) == 1
                operator = chromosome(iGene);
            end
            if mod(iGene, 4) == 2
                destination = chromosome(iGene);
            end
            if mod(iGene, 4) == 3
                indexOperand1 = chromosome(iGene);
                operand1 = unionSet(indexOperand1);
            end
            if mod(iGene, 4) == 0
                indexOperand2 = chromosome(iGene);
                operand2 = unionSet(indexOperand2);
            
                if operator == 1
                    unionSet(destination) = operand1 + operand2;
                end
                if operator == 2
                    unionSet(destination) = operand1 - operand2;
                end
                if operator == 3
                    unionSet(destination) = operand1 * operand2;
                end
                if operator == 4
                    if operand2 ~= 0
                        unionSet(destination) = operand1 / operand2;
                    else
                        unionSet(destination) = cMax;
                    end
                end
            end

        end % iGene loop
    end % iChromosome loop
    yValue = unionSet(1);
end