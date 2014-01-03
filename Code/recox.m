function [ NewChrom ] = recox( OldChrom, RecRate )
%recox Order Crossover (OX) Recombination
%   proposed by L. Davis (1999)

NewChrom = OldChrom;

chromLength = size(OldChrom, 2);
chromCount = size(OldChrom, 1) - 1;

for idx = 1:2:chromCount
    if rand(1,1) > RecRate
        continue
    end
    
    parent1 = OldChrom(idx,:);
    parent2 = OldChrom(idx+1,:);
    child1 = parent1;
    child2 = parent2;
    
    % nothing to do if the chromes are identical
    if parent1 == parent2
        continue
    end
    
    % choose start and end position randomly
    spos = ceil(rand(1) * chromLength);
    epos = ceil(rand(1) * (chromLength-spos)) + spos;
    
    % select a substring from a parent
    ss1 = parent1(spos:epos);
    ss2 = parent2(spos:epos);
    
    % copy substring into the corresponding position of 'proto-child'
    child2(spos:epos) = ss1;
    child1(spos:epos) = ss2;
    
    % difference
    [dif1, dif1idx] = setdiff(parent1, ss2);
    [dif2, dif2idx] = setdiff(parent2, ss1);
    [~,dif1idxOrd] = sort(dif1idx);
    [~,dif2idxOrd] = sort(dif2idx);
    
    % write values to childs
    readIdx = 1;
    
    for writeIdx = [1:(spos-1),(epos+1):chromLength]
        child1(writeIdx) = dif1(dif1idxOrd(readIdx));
        child2(writeIdx) = dif2(dif2idxOrd(readIdx));
        readIdx = readIdx + 1;
    end
    
    % write childs to NewChrom
    NewChrom(idx,:) = child1;
    NewChrom(idx+1,:) = child2;
end

end
